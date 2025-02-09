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

      .map-div {
          width: 750px;
          height: 750px;
          margin-bottom: 20px;
      }

      .btn-container {
          margin-bottom: 10px;
      }

      .route-btn {
          padding: 10px;
          margin-right: 5px;
          cursor: pointer;
          background-color: #007bff;
          color: white;
          border: none;
          border-radius: 5px;
      }

      .route-btn.active {
          background-color: #0056b3;
      }
  </style>
</head>
<body>

<!-- 버튼 컨테이너 -->
<div class="btn-container">
  <c:forEach var="list" items="${tempLists}" varStatus="status">
    <button class="route-btn" data-index="${status.index}">경로 ${status.index + 1}</button>
  </c:forEach>
</div>

<!-- 지도 영역 -->
<div id="map_div" class="map-div"></div>

<!-- 좌표 데이터 저장 -->
<c:forEach var="list" items="${tempLists}" varStatus="status">
  <div id="waypointsData${status.index}" style="display:none;">
    {
    <c:forEach var="temp" items="${list}" varStatus="tempStatus">
      "${temp.title}": {
      "lat": ${temp.map_x},
      "lng": ${temp.map_y}
      }<c:if test="${!tempStatus.last}">,</c:if>
    </c:forEach>
    }
  </div>
</c:forEach>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  let map;
  let markerArr = [];
  let lineArr = [];

  function initializeMap(waypointsDataId, colors) {
    // 기존 마커와 라인 제거
    markerArr.forEach(marker => marker.setMap(null));
    lineArr.forEach(line => line.setMap(null));
    markerArr = [];
    lineArr = [];

    if (!map) {
      map = new Tmapv2.Map("map_div", {
        center: new Tmapv2.LatLng(37.5, 127),
        width: "750px",
        height: "750px",
        zoom: 12,
        httpsMode: true
      });
    }

    let waypointsData = JSON.parse(document.getElementById(waypointsDataId).innerText);
    let waypointKeys = Object.keys(waypointsData);

    if (waypointKeys.length === 0) return;

    let start = waypointsData[waypointKeys[0]];
    let end = waypointsData[waypointKeys[waypointKeys.length - 1]];
    let waypoints = waypointKeys.slice(1, -1).map(key => waypointsData[key]);

    function addMarker(lat, lng, content) {
      let marker = new Tmapv2.Marker({
        position: new Tmapv2.LatLng(lat, lng),
        iconHTML: '<div class="custom-marker">' + content + '</div>',
        map: map
      });
      markerArr.push(marker);
    }

    addMarker(start.lat, start.lng, "S");
    addMarker(end.lat, end.lng, "E");

    waypoints.forEach((waypoint, index) => {
      addMarker(waypoint.lat, waypoint.lng, index + 1);
    });

    function drawRoute(start, end, waypoints, colors) {
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
            console.error("경로 검색 중 오류 발생:", error);
          }
        });
      }

      map.panToBounds(positionBounds);
      map.zoomOut();
    }

    drawRoute(start, end, waypoints, colors);
  }

  let colors = ["#FF0000", "#FFA500", "#FFFF00", "#008000", "#0000FF", "#4B0082", "#EE82EE"];

  $(".route-btn").click(function () {
    $(".route-btn").removeClass("active");
    $(this).addClass("active");

    let index = $(this).data("index");
    initializeMap("waypointsData" + index, colors);
  });

  // 첫 번째 버튼 자동 클릭 (초기 경로 로드)
  $(".route-btn").first().trigger("click");
</script>

</body>
</html>
