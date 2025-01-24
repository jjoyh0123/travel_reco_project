<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>지도 임시</title>
  <script
      src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8"></script>
  <style>

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
<div id="map_div" style="width:750px; height:750px;"></div>

<!-- 좌표 데이터를 JSON 형식으로 저장 -->
<div id="waypointsData" style="display:none;">
  {
  <c:forEach var="temp" items="${tempList}" varStatus="status">
    "${temp.title}": {
    "lat": ${temp.map_x},
    "lng": ${temp.map_y}
    }<c:if test="${!status.last}">,</c:if>
  </c:forEach>
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

  // JSON 형식의 좌표 데이터를 읽어오기
  let waypointsData = JSON.parse(document.getElementById('waypointsData').innerText);

  // waypointsData의 키를 배열로 만듦
  let waypointKeys = Object.keys(waypointsData);

  // 시작점과 종료점을 waypointsData의 첫 번째 및 마지막 항목으로 설정
  let start = waypointsData[waypointKeys[0]];
  let end = waypointsData[waypointKeys[waypointKeys.length - 1]];

  // 고정된 무지개 색상 배열
  let colors = [
    "#FF0000", "#FFA500", "#FFFF00", "#008000",
    "#0000FF", "#4B0082", "#EE82EE", "#A52A2A",
    "#FFD700", "#ADFF2F", "#000080", "#8A2BE2",
    "#FF69B4", "#FF6347", "#00FFFF", "#4682B4",
    "#DC143C", "#FF8C00", "#ADFF2F", "#6A5ACD"
  ];

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

  }
  
  // 순서대로 경유지 설정 (첫 번째와 마지막 항목 제외)
  for (let i = 1; i < waypointKeys.length - 1; i++) {
    let waypoint = waypointsData[waypointKeys[i]];
    currentWaypoints.push(waypoint);
    addMarker(waypoint.lat, waypoint.lng, '<div class="custom-marker">' + (currentWaypoints.length) + '</div>');
  }

  // 경로 그리기 호출
  drawRoute(start, end, currentWaypoints, colors);
</script>
</body>
</html>
