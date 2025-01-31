<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>경로 저장 및 보기</title>
  <script
      src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8"></script>
  <style>
      .buttons {
          display: flex;
          justify-content: space-between;
          margin-bottom: 20px;
      }

      .left-buttons {
          display: flex;
          flex-direction: column;
      }

      .map-container {
          display: flex;
      }

      .map-div {
          width: 750px;
          height: 750px;
          margin-left: 20px;
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
<form id="routeForm" action="Controller" method="post">
  <input type="hidden" name="type" value="temp2">
  <div class="buttons">
    <button type="button" onclick="loadRoute(1)">1번 경로</button>
    <button type="button" onclick="loadRoute(2)">2번 경로</button>
  </div>
  <div class="map-container">
    <div class="left-buttons">
      <button type="button" onclick="toggleLocation('Location1', 37.5665, 126.9780)">Location1</button>
      <button type="button" onclick="toggleLocation('Location2', 37.541, 126.986)">Location2</button>
      <button type="button" onclick="toggleLocation('Location3', 37.5794, 126.9771)">Location3</button>
      <button type="button" onclick="toggleLocation('Location4', 35.1796, 129.0756)">Location4</button>
      <button type="button" onclick="toggleLocation('Location5', 35.1595, 126.8526)">Location5</button>
    </div>
    <div id="map_div" class="map-div"></div>
  </div>
  <input type="hidden" name="route1Titles" id="route1Titles">
  <input type="hidden" name="route1Lats" id="route1Lats">
  <input type="hidden" name="route1Lngs" id="route1Lngs">
  <input type="hidden" name="route2Titles" id="route2Titles">
  <input type="hidden" name="route2Lats" id="route2Lats">
  <input type="hidden" name="route2Lngs" id="route2Lngs">
</form>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  let map;
  let markerArr = [];
  let lineArr = [];
  let route1 = [];
  let route2 = [];
  let currentRoute = route1;
  let colors = [
    "#FF0000", "#FFA500", "#FFFF00", "#008000",
    "#0000FF", "#4B0082", "#EE82EE", "#A52A2A",
    "#FFD700", "#ADFF2F", "#000080", "#8A2BE2",
    "#FF69B4", "#FF6347", "#00FFFF", "#4682B4",
    "#DC143C", "#FF8C00", "#ADFF2F", "#6A5ACD"
  ];

  // 지도 초기화
  function initializeMap() {
    map = new Tmapv2.Map("map_div", {
      center: new Tmapv2.LatLng(37, 127),
      width: "750px",
      height: "750px",
      zoom: 17,
      httpsMode: true
    });
  }

  // 마커 추가 함수
  function addMarker(lat, lng, content) {
    let marker = new Tmapv2.Marker({
      position: new Tmapv2.LatLng(lat, lng),
      iconHTML: content,
      map: map
    });
    markerArr.push(marker);
    return marker;
  }

  // 경로 그리기 함수
  function drawRoute(route) {
    // 기존 마커와 라인 제거
    markerArr.forEach(marker => marker.setMap(null));
    lineArr.forEach(line => line.setMap(null));
    markerArr = [];
    lineArr = [];

    if (route.length === 0) return;

    let start = route[0];
    let end = route[route.length - 1];
    let waypoints = route.slice(1, -1);

    // 시작점과 종료점 마커 추가
    addMarker(start.lat, start.lng, '<div class="custom-marker">S</div>');
    addMarker(end.lat, end.lng, '<div class="custom-marker">E</div>');

    // 경유지 마커 추가
    waypoints.forEach((point, index) => {
      addMarker(point.lat, point.lng, '<div class="custom-marker">' + (index + 1) + '</div>');
    });

    // 경로 그리기
    let points = [start, ...waypoints, end];
    let positionBounds = new Tmapv2.LatLngBounds();

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
        async: false,
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
            strokeColor: colors[i % colors.length],
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

  // 왼쪽 버튼 클릭 시 위치 추가/제거 및 경로 다시 그리기
  function toggleLocation(title, lat, lng) {
    let index = currentRoute.findIndex(point => point.title === title);
    if (index === -1) {
      currentRoute.push({title, lat, lng}); // 위치 추가
    } else {
      currentRoute.splice(index, 1); // 위치 제거
    }
    drawRoute(currentRoute); // 경로 다시 그리기
  }

  // 1번 또는 2번 버튼 클릭 시 해당 경로 불러오기
  function loadRoute(routeNumber) {
    currentRoute = (routeNumber === 1) ? route1 : route2;
    drawRoute(currentRoute);
  }

  // 폼 제출 시 경로 데이터 저장
  function saveRoutes() {
    document.getElementById('route1Titles').value = route1.map(point => point.title).join(',');
    document.getElementById('route1Lats').value = route1.map(point => point.lat).join(',');
    document.getElementById('route1Lngs').value = route1.map(point => point.lng).join(',');
    document.getElementById('route2Titles').value = route2.map(point => point.title).join(',');
    document.getElementById('route2Lats').value = route2.map(point => point.lat).join(',');
    document.getElementById('route2Lngs').value = route2.map(point => point.lng).join(',');
    document.getElementById('routeForm').submit();
  }

  window.onbeforeunload = saveRoutes;

  // 초기화
  function initializeRoutes() {
    initializeMap();

    // 서버에서 전달된 데이터로 초기화
    <c:if test="${not empty route1}">
    route1 = [
      <c:forEach var="temp" items="${route1}" varStatus="status">
      {title: "${temp.title}", lat: ${temp.map_x}, lng: ${temp.map_y}}<c:if test="${!status.last}">, </c:if>
      </c:forEach>
    ];
    </c:if>

    <c:if test="${not empty route2}">
    route2 = [
      <c:forEach var="temp" items="${route2}" varStatus="status">
      {title: "${temp.title}", lat: ${temp.map_x}, lng: ${temp.map_y}}<c:if test="${!status.last}">, </c:if>
      </c:forEach>
    ];
    </c:if>

    loadRoute(1); // 초기에는 1번 경로를 로드
  }

  initializeRoutes();
</script>
</body>
</html>