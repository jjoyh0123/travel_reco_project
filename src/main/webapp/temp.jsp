<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>지도 임시</title>
  <script
      src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8"></script>
  <style>
      #controls {
          margin: 10px;
      }

      #controls button {
          margin: 5px;
      }

      #routeInfo {
          margin-top: 20px;
      }

      .custom-marker {
          background-color: white;
          border: 1px solid black;
          border-radius: 50%;
          width: 30px;
          height: 30px;
          display: flex;
          align-items: center;
          justify-content: center;
      }
  </style>
</head>
<body>
<div id="controls">
  <button id="addYeoksam">역삼역</button>
  <button id="addGangnam">강남역</button>
  <button id="addSinnonhyeon">신논현역</button>
  <button id="addSeonjeongneung">선정릉역</button>
  <button id="addTest">테스트</button>
</div>
<div id="map_div" style="width:750px; height:750px;"></div>
<div id="routeInfo"></div>

<!-- 좌표 데이터를 JSON 형식으로 저장 -->
<div id="waypointsData" style="display:none;">
  {
  "yeoksam": {"lat": 37.500837, "lng": 127.036948},
  "gangnam": {"lat": 37.497991, "lng": 127.027772},
  "sinnonhyeon": {"lat": 37.504460, "lng": 127.024553},
  "seonjeongneung": {"lat": 37.510250, "lng": 127.043512},
  "testt": {"lat": 37.56344380519, "lng":126.9847483173}
  }
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  // 지도 초기화
  let map = new Tmapv2.Map("map_div", {
    center: new Tmapv2.LatLng(37.499338, 127.033239),
    width: "750px",
    height: "750px",
    zoom: 17,
    httpsMode: true
  });

  let markerArr = [];
  let lineArr = [];
  let currentWaypoints = [];

  // 좌표 데이터 설정
  let start = {lat: 37.499338, lng: 127.033239}; // 쌍용교육
  let end = {lat: 37.499338, lng: 127.033239}; // 쌍용교육 (종료점)

  // JSON 형식의 좌표 데이터를 읽어오기
  let waypointsData = JSON.parse(document.getElementById('waypointsData').innerText);

  // 고정된 무지개 색상 배열
  let colors = [
    "#FF0000", "#FFA500", "#FFFF00", "#008000",
    "#0000FF", "#4B0082", "#EE82EE", "#A52A2A",
    "#FFD700", "#ADFF2F", "#000080", "#8A2BE2",
    "#FF69B4", "#FF6347", "#00FFFF", "#4682B4",
    "#DC143C", "#FF8C00", "#ADFF2F", "#6A5ACD"
  ]


  // 마커를 추가하는 함수
  function addMarker(lat, lng, content) {
    let marker = new Tmapv2.Marker({
      position: new Tmapv2.LatLng(lat, lng),
      iconHTML: content,  // 커스텀 HTML 요소
      map: map
    });
    markerArr.push(marker); // 마커 배열에 추가
    return marker;
  }

  // 마커 추가
  addMarker(start.lat, start.lng, '<div class="custom-marker">S</div>');
  addMarker(end.lat, end.lng, '<div class="custom-marker">E</div>');

  // 경로를 그리는 함수
  function drawRoute(start, end, waypoints, colors) {
    let points = [start, ...waypoints, end];
    let positionBounds = new Tmapv2.LatLngBounds();

    // 각 구간별 경로를 호출 및 그리기
    for (let i = 0; i < points.length - 1; i++) {
      let startX = points[i].lng;
      let startY = points[i].lat;
      let endX = points[i + 1].lng;
      let endY = points[i + 1].lat;

      let requestData = {
        version: 1,
        startX: startX,
        startY: startY,
        endX: endX,
        endY: endY,
        reqCoordType: "WGS84GEO",
        resCoordType: "WGS84GEO",
        searchOption: 0
      };

      $.ajax({
        type: "POST",
        url: "https://apis.openapi.sk.com/tmap/routes?version=1",
        headers: {
          "appKey": "zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8",
          "Content-Type": "application/json"
        },
        data: JSON.stringify(requestData),
        async: false, // 동기 요청
        success: function (response) {
          let resultData = response.features;
          let path = [];

          resultData.forEach(data => {
            if (data.geometry.type === "LineString") {
              let coordinates = data.geometry.coordinates;
              coordinates.forEach(coord => {
                let latlng = new Tmapv2.LatLng(coord[1], coord[0]);
                positionBounds.extend(latlng);
                path.push(latlng);
              });
            }
          });

          let polyline = new Tmapv2.Polyline({
            path: path,
            strokeColor: colors[i % colors.length], // 구간별 색상 설정
            strokeWeight: 6,
            map: map
          });
          lineArr.push(polyline);
        },
        error: function (request, status, error) {
          console.error("경로 검색 중 오류가 발생했습니다:", error);
        }
      });
    }

    map.panToBounds(positionBounds);
    map.zoomOut();

    // 경로 정보 업데이트
    updateRouteInfo(points);
  }

  // 경로 정보 업데이트 함수
  function updateRouteInfo(points) {
    let routeInfo = "현재 경로: ";
    points.forEach((point, index) => {
      if (index === 0) {
        routeInfo += "시작점 -> ";
      } else if (index === points.length - 1) {
        routeInfo += "종료점";
      } else {
        routeInfo += '경유지 ' + index + ' -> ';
      }
    });
    document.getElementById("routeInfo").innerText = routeInfo;
  }

  // 경로 그리기 호출
  drawRoute(start, end, currentWaypoints, colors);

  // 버튼 클릭 시 경유지 추가 또는 제거
  function toggleWaypoint(waypoint) {
    let index = currentWaypoints.findIndex(wp => wp.lat === waypoint.lat && wp.lng === waypoint.lng);
    if (index === -1) {
      // 경유지 추가
      currentWaypoints.push(waypoint);
      let markerContent = '<div class="custom-marker">' + currentWaypoints.length + '</div>';
      addMarker(waypoint.lat, waypoint.lng, markerContent);
    } else {
      let markerIndex = index + 2; // 시작점과 종료점을 제외한 마커 인덱스
      markerArr[markerIndex].setMap(null); // 마커 제거
      markerArr.splice(markerIndex, 1);
      currentWaypoints.splice(index, 1);

      // 나머지 마커의 번호 업데이트
      for (let i = markerIndex; i < markerArr.length; i++) {
        markerArr[i].setIconHTML('<div class="custom-marker">' + (i - 1) + '</div>');
      }
    }
    lineArr.forEach(line => line.setMap(null));
    lineArr = [];
    drawRoute(start, end, currentWaypoints, colors);
  }

  $("#addYeoksam").on("click", function () {
    toggleWaypoint(waypointsData.yeoksam);
  });

  $("#addGangnam").on("click", function () {
    toggleWaypoint(waypointsData.gangnam);
  });

  $("#addSinnonhyeon").on("click", function () {
    toggleWaypoint(waypointsData.sinnonhyeon);
  });

  $("#addSeonjeongneung").on("click", function () {
    toggleWaypoint(waypointsData.seonjeongneung);
  });

  $("#addTest").on("click", function () {
    toggleWaypoint(waypointsData.testt);
  });
</script>
</body>
</html>