<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>${title} 길찾기</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <script
      src="https://apis.openapi.sk.com/tmap/vectorjs?version=1&appKey=zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8"></script>
  <style>
      .custom-img {
          width: 40px;
          height: 40px;
          display: block;
          margin: 0 auto;
      }

      .custom-marker {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          text-align: center;
          font-size: 12px;
          white-space: nowrap;
      }

      #left_side {
          width: 20%;
          height: 100%;
          padding-top: 20px;
          padding-left: 20px;
      }

      #right_side {
          width: 80%;
          height: 100%;
      }

      #map_div {
          width: 100%;
          height: 100%;
      }

      #wrap {
          width: 100%;
          height: 100%;
          display: flex;
      }

      .place {
          width: 200px;
          text-align: right;
      }
  </style>
</head>
<body>
<div id="wrap">
  <div id="left_side">
    <h2>경로 안내</h2>
    <div class="now">
      <button type="button" class="btn btn-primary" disabled>현재 위치</button>
      <button type="button" class="btn btn-outline-primary place" disabled>쌍용교육센터</button>
    </div>
    <br>
    <div class="goto">
      <button type="button" class="btn btn-success" disabled>목표 위치</button>
      <button type="button" class="btn btn-outline-success place" disabled>${title}</button>
    </div>
  </div>
  <div id="right_side">
    <div id="map_div"></div>
  </div>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  let map;
  let marker;
  let coordinates = {lat: 37.499322, lng: 127.033211, title: '쌍용교육센터'};
  let destination = {lat: ${mapy}, lng: ${mapx}, title: '${title}'};


  function updateMarker(lat, lng, title) {
    if (marker) {
      marker.setMap(null);
    }
    marker = new Tmapv3.Marker({
      position: new Tmapv3.LatLng(lat, lng),
      iconHTML: '<div class="custom-marker"><img class="custom-img" src="./www/logo.png" alt="로고"><div>' + title + '</div></div>',
      map: map
    });
  }

  function initTmap() {
    map = new Tmapv3.Map("map_div", {
      center: new Tmapv3.LatLng(coordinates.lat, coordinates.lng), // 쌍용 교육센터 중심으로 시작
      width: "100%",
      height: "100%",
      zoom: 16
    });

    // 마커 표시
    updateMarker(coordinates.lat, coordinates.lng, coordinates.title); // 쌍용 교육센터 마커
    updateMarker(destination.lat, destination.lng, destination.title); // 목표 위치 마커

    // 경로 그리기
    drawRoute(coordinates, destination);
  }

  function updateMarker(lat, lng, title) {
    marker = new Tmapv3.Marker({
      position: new Tmapv3.LatLng(lat, lng),
      iconHTML: '<div class="custom-marker"><img class="custom-img" src="./www/logo.png" alt="로고"><div>' + title + '</div></div>',
      map: map
    });
  }

  function drawRoute(start, end) {
    const routeRequest = {
      startX: start.lng,
      startY: start.lat,
      endX: end.lng,
      endY: end.lat,
      reqCoordType: "WGS84GEO",
      resCoordType: "WGS84GEO",
      searchOption: 0,
      version: 1
    };

    $.ajax({
      type: "POST",
      url: "https://apis.openapi.sk.com/tmap/routes?version=1",
      headers: {
        "appKey": "zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8",
        "Content-Type": "application/json"
      },
      data: JSON.stringify(routeRequest),
      success: function (response) {
        const resultData = response.features;
        let path = [];

        resultData.forEach(data => {
          if (data.geometry.type === "LineString") {
            const coordinates = data.geometry.coordinates;
            coordinates.forEach(coord => {
              const latlng = new Tmapv3.LatLng(coord[1], coord[0]);
              path.push(latlng);
            });
          }
        });

        new Tmapv3.Polyline({
          path: path,
          strokeColor: "red", // 원하는 색상으로 변경
          strokeWeight: 5,
          map: map
        });

        // 지도 영역 조정 (두 마커가 모두 보이도록)
        const bounds = new Tmapv3.LatLngBounds();
        bounds.extend(new Tmapv3.LatLng(start.lat, start.lng));
        bounds.extend(new Tmapv3.LatLng(end.lat, end.lng));
        map.fitBounds(bounds);

      },
      error: function (error) {
        console.error("경로 검색 오류:", error);
      }
    });
  }


  $(document).ready(function () {
    initTmap();
  });

</script>
</body>
</html>
