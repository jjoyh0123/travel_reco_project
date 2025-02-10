<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>여행 일정 - ${plan.title}</title>
  <script
      src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8"></script>
  <style>
      /* Use your existing CSS here – for brevity the same styles as before are used. */
      * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
          font-family: 'Arial', sans-serif;
      }

      body {
          display: flex;
          height: 100vh;
          background-color: #f8f9fa;
      }

      .container {
          display: flex;
          width: 100%;
      }

      /* Sidebar Styling */
      .sidebar {
          width: 140px;
          background: #f8f9fa;
          display: flex;
          flex-direction: column;
          padding: 20px;
          border-right: 1px solid #ddd;
          align-items: center; /* Center align all content */
      }

      /* Placeholder Logo */
      .logo {
          font-size: 20px;
          font-weight: bold;
          color: #FF7F50; /* Coral color */
          text-align: center;
          margin-bottom: 50px; /* Add spacing below logo */
          margin-top: 5px;
      }


      /* Sidebar buttons - General styling */
      .sidebar button {
          color: #FF7F50; /* Coral background */
          background: #ffffff;
          border: none;
          padding: 10px 15px;
          font-size: 16px;
          font-weight: bold;
          text-align: center;
          cursor: pointer;
          border-radius: 8px;
          margin-bottom: 10px;
          transition: all 0.3s ease;
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Shadow effect */
      }

      /* Hover effect */
      .sidebar button:hover {
          background: #FF7F50; /* Coral background */
          color: #ffffff; /* White text */
          box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
      }

      /*!* "공유하기" button (Dark Gray) *!*/
      /*.share-btn {*/
      /*    background-color: darkgrey !important; !* Dark gray *!*/
      /*    color: #ffffff !important;*/
      /*}*/

      /*!* "내 일정에 담기" button (Black) *!*/
      /*.save-btn {*/
      /*    background-color: #000000 !important; !* Black *!*/
      /*    color: white !important;*/
      /*}*/

      /* Keep bottom buttons aligned at the bottom */
      .sidebar-bottom {
          margin-top: auto;
          display: flex;
          flex-direction: column;
          gap: 10px;
      }


      .full-schedule {
          background-color: #FF7F50;
          color: #ffffff;
          border: none;
          padding: 10px;
          font-size: 16px;
          cursor: pointer;
          margin-bottom: 18px !important; /* Increase spacing between this and the day buttons */
          border-radius: 5px;
      }

      .days-nav {
          display: flex;
          flex-direction: column; /* Ensure vertical stacking */
          gap: 3px; /* Space between day buttons */
          /*width: 100%; !* Ensure full width *!*/
      }

      .day-btn {
          background: #ffffff;
          color: #FF7F50;
          box-shadow: 0 2px 8px 0 rgba(31,38,135,.08) !important;
          border-radius: 8px;
          border: none initial !important;

          padding: 10px;
          font-size: 16px;
          cursor: pointer;
          margin-bottom: 0px;
      }

      .day-btn.active {
          color: #FF7F50;
          background: #ffffff;
      }

      /* Style for "공유하기" button */
      .share-btn {
          background-color: black!important; /* Light gray */
          color: white!important; /* Black text */
      }

      /* Style for "내 일정에 담기" button */
      .save-btn {
          background-color: #333 !important; /* Black */
          color: white!important;
      }

      .main-content {
          flex-grow: 2;
          max-width: 400px;
          padding: 20px 40px;
          display: flex;
          flex-direction: column;
      }

      .trip-header {
          display: flex;
          flex-direction: column; /* Ensures each element appears on a new line */
          font-size: 24px;
          font-weight: bold;
          margin-bottom: 20px;
      }

      .trip-header h1 {
          font-size: 28px; /* Larger title */
          margin-bottom: 5px; /* Add spacing below */
      }

      .trip-header .date {
          font-size: 20px;
          color: #555; /* Slightly dimmed color */
          margin-bottom: 5px;
      }

      .trip-header .destination-area {
          font-size: 20px;
          font-weight: bold;
          color: lightcoral; /* Set destination in orange */
      }

      .date {
          font-size: 23px;
      }

      .itinerary {
          display: flex;
          flex-direction: column;
          gap: 15px;
      }

      .day-schedule {
          background: white;
          padding: 15px;
          border-radius: 8px;
          box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
          display: block; /* will be toggled by JS */
          margin-bottom: 5px;
      }

      .schedule-item {
          display: flex;
          align-items: center;
          gap: 15px; /* Default gap between elements */
          margin-bottom: 3px;
          position: relative;
      }

      /* Step Number (Index) - Move slightly higher */
      .step-number {
          width: 18px;
          height: 18px;
          background-color: rgb(229, 75, 75);
          color: #fff;
          font-size: 0.75rem;
          font-weight: bold;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          position: relative;
          top: -23px; /* Moves the index higher */
      }

      /* Time and Place Container */
      .time-category {
          display: flex;
          flex-direction: column;
          align-items: flex-start;
          gap: 5px; /* Adds spacing between time and place info */
      }

      /* Time - Align with index */
      .time {
          font-size: 13px;
          font-weight: bold;
          color: rgb(170, 177, 184);
          margin-top: 5px;
          margin-bottom: 5px; /* Adds space between time and place details */
      }

      /* Place Type - Keep original style */
      .place-type {
          font-size: 12px;
          color: darkorange; /* Blue color for category */
          font-weight: bold;
          margin-left: 10px; /* Add spacing */
      }

      /* Place Name - Keep original style */
      .place-name {
          font-size: 19px;
          font-weight: bold;
          color: #333; /* Dark text for readability */
          margin-left: 10px; /* Add spacing */
      }

      /* Image Alignment */
      .place-image {
          width: 60px;
          height: 60px;
          object-fit: cover;
          border-radius: 8px;
          margin-left: auto; /* Push image to the right */
      }

      .right-panel {
          width: 50%;
          flex-grow: 1;
          background: #B3E0FF;
          display: flex;
          align-items: center;
          justify-content: center;
          border-left: 1px solid #ddd;
      }

      #map_div {
          width: 100%;
          height: 100%;
          min-width: 100px;
          min-height: 100px;
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
<div class="container">
  <aside class="sidebar">
    <!-- Placeholder Logo -->
    <div class="logo">zenzenclub</div>

    <button class="full-schedule" id="fullScheduleBtn">전체일정</button>

    <nav class="days-nav">
      <c:forEach var="date" items="${plan.dateList}" varStatus="status">
        <button class="day-btn ${status.first ? 'active' : ''}" data-index="${status.index}">
            ${status.index + 1}일차
        </button>
      </c:forEach>
    </nav>

    <div class="sidebar-bottom">
      <button class="share-btn" id="sharePlanBtn">공유하기</button>
      <c:if test="${sessionScope.user_idx ne plan.user_idx}">
        <button class="save-btn" id="copyPlanBtn">내 일정에 담기</button>
      </c:if>
    </div>
  </aside>

  <main class="main-content" id="mainContent">
    <header class="trip-header">
      <h1>${plan.title}</h1>
      <span class="date" id="duration">${plan.start_date} - ${plan.end_date}</span>
      <span class="destination-area">${plan.area_code}</span> <!-- Add this -->
    </header>
    <section class="itinerary" id="itinerarySection">
      <c:forEach var="date" items="${plan.dateList}" varStatus="status">
        <div class="day-schedule" data-day-index="${status.index}">
          <h2>${status.index + 1}일차 <span class="date">${date.date}</span></h2>
          <c:forEach var="place" items="${date.placeList}" varStatus="pStatus">
            <div class="schedule-item">
              <span class="step-number">${pStatus.index + 1}</span>
              <div class="time-category">
                <span class="time">${place.time}</span>
                <span class="place-type">
                                    <c:choose>
                                      <c:when test="${place.content_type_id == 1}">🏨 숙소</c:when>
                                      <c:when test="${place.content_type_id == 2}">🍽 식당</c:when>
                                      <c:otherwise>📍 장소</c:otherwise>
                                    </c:choose>
                                </span>
                <span class="place-name">${place.title}</span>
              </div>
              <c:if test="${not empty place.thumbnail}">
                <img src="${place.thumbnail}" class="place-image" alt="${place.title}">
              </c:if>
            </div>
          </c:forEach>
        </div>
      </c:forEach>
    </section>
  </main>

  <aside class="right-panel" id="rightPanel">
    <div id="map_div"></div>
  </aside>
</div>

<c:forEach var="date" items="${plan.dateList}" varStatus="status">
  <div id="waypointsData${status.index}" style="display:none;">
    {
    <c:forEach var="place" items="${date.placeList}" varStatus="tempStatus">
      "${place.title}": {
      "lng": ${place.map_x},
      "lat": ${place.map_y}
      }<c:if test="${!tempStatus.last}">,</c:if>
    </c:forEach>
    }
  </div>
</c:forEach>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  // Simple JS to toggle between “전체일정” and a single day view
  document.addEventListener("DOMContentLoaded", function () {
    init_position(); // 대한민국 지도를 처음 표시

    const dayButtons = document.querySelectorAll(".day-btn");
    const fullScheduleBtn = document.getElementById("fullScheduleBtn");
    const daySchedules = document.querySelectorAll(".day-schedule");
    const rightPanel = document.getElementById("rightPanel");

    function showFullSchedule() {
      dayButtons.forEach(btn => btn.classList.remove("active"));
      fullScheduleBtn.classList.add("active");
      daySchedules.forEach(schedule => schedule.style.display = "block");
      rightPanel.style.display = "flex";
    }

    // Start by showing the full schedule
    showFullSchedule();

    dayButtons.forEach(btn => {
      btn.addEventListener("click", function () {
        dayButtons.forEach(b => b.classList.remove("active"));
        fullScheduleBtn.classList.remove("active");
        this.classList.add("active");
        const dayIndex = this.getAttribute("data-index");
        daySchedules.forEach(schedule => {
          schedule.style.display = (schedule.getAttribute("data-day-index") === dayIndex) ? "block" : "none";
        });
        rightPanel.style.display = "flex";

      });
    });

    fullScheduleBtn.addEventListener("click", showFullSchedule);

    // “내 일정에 담기” button – redirect to copy action
    const copyPlanBtn = document.getElementById("copyPlanBtn");
    if (copyPlanBtn) {
      copyPlanBtn.addEventListener("click", function () {
        // Pass along the current plan id (assumed stored as plan.idx)
        const planId = "${plan.idx}";
        window.location.href = "Controller?type=copyPlan&planId=" + planId;
      });
    }
  });

  let map;
  let markerArr = [];
  let lineArr = [];

  function init_position() {
    if (!map) {
      map = new Tmapv2.Map("map_div", {
        center: new Tmapv2.LatLng(36.5, 127.5), // 대한민국 중심
        width: "100%",
        height: "100%",
        zoom: 7, // 대한민국 전체가 보이는 줌 레벨
      });
    }
  }


  function initializeMap(waypointsDataId, colors) {
    markerArr.forEach((marker) => marker.setMap(null));
    lineArr.forEach((line) => line.setMap(null));
    markerArr = [];
    lineArr = [];

    let waypointsData = JSON.parse(
        document.getElementById(waypointsDataId).innerText
    );
    let waypointKeys = Object.keys(waypointsData);

    if (waypointKeys.length === 0) {
      init_position(); // 경로가 없으면 대한민국 지도 유지
      return;
    }

    let start = waypointsData[waypointKeys[0]];
    let end = waypointsData[waypointKeys[waypointKeys.length - 1]];
    let waypoints = waypointKeys.slice(1, -1).map((key) => waypointsData[key]);

    function addMarker(lat, lng, content) {
      let marker = new Tmapv2.Marker({
        position: new Tmapv2.LatLng(lat, lng),
        iconHTML: '<div class="custom-marker">' + content + "</div>",
        map: map,
      });
      markerArr.push(marker);
    }

    addMarker(start.lat, start.lng, "S");
    addMarker(end.lat, end.lng, "E");

    waypoints.forEach((waypoint, index) => {
      addMarker(waypoint.lat, waypoint.lng, index + 1);
    });

    if (waypointKeys.length === 1) {
      map.setCenter(new Tmapv2.LatLng(start.lat, start.lng));
      map.setZoom(18); // 단일 지점일 경우 너무 확대되지 않도록 조절
      return;
    }

    drawRoute(start, end, waypoints, colors);
  }


  function drawRoute(start, end, waypoints, colors) {
    let points = [start, ...waypoints, end];
    let positionBounds = new Tmapv2.LatLngBounds();

    // 단일 지점일 경우 지도에 마커만 표시
    if (points.length === 1) {
      init_position(points[0]);

      // 기존 마커 제거
      markerArr.forEach(marker => marker.setMap(null));
      markerArr = [];

      let marker = new Tmapv2.Marker({
        position: center,
        map: map
      });

      markerArr.push(marker);
      return; // 경로 요청을 하지 않음
    }

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
  }

  let colors = ["#FF0000", "#FFA500", "#FFFF00", "#008000", "#0000FF", "#4B0082", "#EE82EE"];

  $(".day-btn").click(function () {
    $(".day-btn").removeClass("active");
    $(this).addClass("active");
    let index = $(this).data("index");
    initializeMap("waypointsData" + index, colors);
  });

</script>
</body>
</html>