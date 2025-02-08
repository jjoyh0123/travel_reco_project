<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>simpleMap</title>
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
  </style>
</head>
<body>
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"
        onclick="setCoordinates(37.566, 126.978, '서울시청')">
  Button 1
</button>
<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal"
        onclick="setCoordinates(37.575, 126.986, '경복궁')">
  Button 2
</button>
<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal"
        onclick="setCoordinates(37.583, 126.993, '남산타워')">
  Button 3
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="map_div" style="width: 100%; height: 400px;"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script>
  let map;
  let marker;
  let coordinates = {lat: 37.56520450, lng: 126.98702028, title: '기본 위치'};

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
    if (!map) {
      map = new Tmapv3.Map("map_div", {
        center: new Tmapv3.LatLng(coordinates.lat, coordinates.lng),
        width: "100%",
        height: "400px",
        zoom: 16
      });
    } else {
      map.zoom = 16;
      map.setCenter(new Tmapv3.LatLng(coordinates.lat, coordinates.lng));
    }
  }

  function setCoordinates(lat, lng, title) {
    coordinates = {lat: lat, lng: lng, title: title};
  }

  const modal = document.getElementById('exampleModal');
  modal.addEventListener('shown.bs.modal', () => {
    initTmap();
    updateMarker(coordinates.lat, coordinates.lng, coordinates.title);
  });
</script>
</body>
</html>
