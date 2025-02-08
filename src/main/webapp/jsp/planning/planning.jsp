<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>여행 플래너</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/planning/planning.css">
</head>
<body>
<div class="content-wrapper">

  <!-- Left Panel -->
  <div id="left-panel">
    <div id="logo">zenzenclub</div>
    <div id="date-container"></div> <!-- Dates will be added dynamically -->
    <div id="plan-save-buttons">
      <button class="action-button" onclick="save_plan()">저장</button>
    </div>
  </div>

  <!-- Middle-Left Panel (Destination List) -->
  <div id="middle-left-panel">
    <div id="destination-header">서울</div>
    <div id="destination-date-range">2025-01-14 ~ 2025-01-20</div>
    <div class="categories">
      <div class="category">🍴 음식</div>
      <div class="category">☕ 카페</div>
      <div class="category">❤️ 하트</div>
    </div>
    <div id="search-bar">
      <input type="text" placeholder="장소를 입력해주세요.">
      <button>검색</button>
    </div>
    <div id="destination-list"></div>
    <div id="action-buttons">
      <button class="action-button">숙소 선택</button>
    </div>
  </div>

  <!-- Middle Panel (Selected Places) -->
  <div id="middle-panel">
    <div id="time-summary">3 / 6시간 0분 / 24시간 0분</div>
    <button id="clear-button">장소 설정 초기화</button>
    <!-- Container for selected places -->
    <div id="selected-places"></div>
  </div>

  <!-- Right Panel -->
  <div id="right-panel">
    <div id="map">맵</div>
    <button id="floating-button">이용방법</button>
  </div>

</div>

<script>
  // GLOBAL array to store the current plan (so we can reorder, limit to 10, etc.)
  let currentPlan = [];
  let allDates = [];
  // Store previous date selection
  let previousDate = null;
  let selectedDate = null;

  document.addEventListener("DOMContentLoaded", function () {
    fetchTouristSpots();
    setupDragAndDrop();
    initializeDates();
  });

  function generate_date_range(start_date, end_date) {
    const start = new Date(start_date);
    const end = new Date(end_date);
    const dates = [];

    while (start <= end) {
      // Format the date as YYYY-MM-DD
      dates.push(start.toISOString().split('T')[0]);
      start.setDate(start.getDate() + 1);
    }

    return dates;
  }

  // Function to generate date range from session storage
  function initializeDates() {
    const start_date = sessionStorage.getItem("start_date");
    const end_date = sessionStorage.getItem("end_date");

    if (!start_date || !end_date) {
      console.error("Start date or end date missing from session storage.");
      return;
    }

    const dateContainer = document.getElementById("date-container");
    dateContainer.innerHTML = "";

    allDates = generate_date_range(start_date, end_date);

    allDates.forEach((date, index) => {
      const dateElement = document.createElement("div");
      dateElement.classList.add("date");
      dateElement.textContent = date;

      if (index === 0) {
        dateElement.classList.add("active"); // Default to first date
        selectedDate = date;
      }

      dateElement.addEventListener("click", function () {
        selectDate(date, dateElement);
      });

      dateContainer.appendChild(dateElement);
    });

    updateSelectedPlaces(selectedDate);
  }

  // Function to handle date selection
  function selectDate(date, element) {
    previousDate = selectedDate;
    selectedDate = date;

    // Update active class
    document.querySelectorAll(".date").forEach(d => d.classList.remove("active"));
    element.classList.add("active");

    console.log(`Previous Date: ${previousDate}, Selected Date: ${selectedDate}`);

    // Update places for the selected date
    updateSelectedPlaces(selectedDate);
  }

  // Function to update selected places based on selectedDate
  function updateSelectedPlaces(date) {
    const container = document.getElementById("selected-places");
    container.innerHTML = "";

    const placesForDate = currentPlan.filter(place => place.date === date);

    if (placesForDate.length === 0) {
      container.innerHTML = `<p>장소 추가하기</p>`;
    } else {
      renderSelectedPlaces(placesForDate);
    }
  }

  // Ensure adding places saves them under selectedDate
  function addPlaceToPlan(place) {
    if (currentPlan.length >= 10) {
      alert("이미 10개 장소가 선택되었습니다. 더 이상 추가할 수 없습니다.");
      return;
    }

    if (!selectedDate) {
      alert("날짜가 선택되지 않았습니다.");
      return;
    }

    place.date = selectedDate;
    currentPlan.push(place);
    updateSelectedPlaces(selectedDate);
  }

  // 1) Fetch your list of tourist spots
  function fetchTouristSpots() {
    fetch('/Controller?type=getTouristSpots')
        .then(response => response.json())
        .then(data => displayPlaces(data))
        .catch(error => console.error('Error fetching data:', error));
  }

  // 2) Display them in the "destination-list" (left panel)
  function displayPlaces(places) {
    const destinationList = document.getElementById("destination-list");
    destinationList.innerHTML = "";

    places.forEach(function (place) {
      const imgSrc = place.image ? place.image : "https://dummyimage.com/50";
      const shortAddress = place.address;

      const listItem = document.createElement("div");
      listItem.classList.add("destination");
      listItem.dataset.lat = place.mapy;
      listItem.dataset.lon = place.mapx;
      listItem.dataset.category = place.category;
      listItem.dataset.contentid = place.contentid;

      // Build the inner HTML
      listItem.innerHTML =
          '<img src="' + imgSrc + '" alt="thumbnail">' +
          '<div class="destination-info">' +
          '<h4>' + place.title + '</h4>' +
          '<p>' + shortAddress + '</p>' +
          '<div class="ratings">⭐ <span>4.5</span></div>' +
          '</div>' +
          '<span class="heart">♥</span>' +
          '<span class="add-button">+</span>';

      destinationList.appendChild(listItem);

      // "+" button adds to our plan
      const addButton = listItem.querySelector(".add-button");
      addButton.addEventListener("click", function (e) {
        e.stopPropagation();
        addPlaceToPlan(place);
      });
    });
  }

  // 4) Render selected places in the middle panel
  function renderSelectedPlaces(planArray) {
    const container = document.getElementById("selected-places");
    container.innerHTML = "";

    planArray.forEach((spot, index) => {
      const imgSrc = spot.image || "https://dummyimage.com/50";
      const div = document.createElement("div");
      div.classList.add("selected-place");
      div.setAttribute("draggable", "true"); // for reordering
      // store the index so we can reorder currentPlan
      div.dataset.index = index;

      // Build the item layout
      div.innerHTML =
          '<div class="number">' + (index + 1) + '</div>' +
          '<img src="' + imgSrc + '" alt="thumbnail">' +
          '<div class="info">' +
          '<h4>' + spot.title + '</h4>' +
          '<p>' + spot.address + '</p>' +
          '</div>' +
          '<input type="time" class="time-picker" ' + (spot.time ? 'value="' + spot.time + '"' : 'value="00:00"') + '>' +
          '<span class="delete">🗑</span>';

      // Keep the time in sync with our array
      const timeInput = div.querySelector(".time-picker");
      timeInput.addEventListener("change", (e) => {
        // store the time in the spot object
        spot.time = e.target.value;
      });

      // Delete from plan
      const deleteBtn = div.querySelector(".delete");
      deleteBtn.addEventListener("click", function () {
        removePlaceFromPlan(index);
      });

      container.appendChild(div);
    });
  }

  function removePlaceFromPlan(indexToRemove) {
    // For example, call server to remove from session if needed
    // Then update local array
    currentPlan.splice(indexToRemove, 1);
    renderSelectedPlaces(currentPlan);
  }

  // 5) Drag & Drop setup
  function setupDragAndDrop() {
    const container = document.getElementById("selected-places");
    let draggedEl = null;

    // dragstart
    container.addEventListener("dragstart", (e) => {
      if (e.target.classList.contains("selected-place")) {
        draggedEl = e.target;
        draggedEl.classList.add("dragging");
        // set data transfer if needed
        e.dataTransfer.setData("text/plain", e.target.dataset.index);
      }
    });

    // dragover
    container.addEventListener("dragover", (e) => {
      e.preventDefault(); // allow drop
      const afterElement = getDragAfterElement(container, e.clientY);
      if (draggedEl && afterElement === null) {
        container.appendChild(draggedEl);
      } else if (draggedEl && afterElement) {
        container.insertBefore(draggedEl, afterElement);
      }
    });

    // dragend
    container.addEventListener("dragend", (e) => {
      if (draggedEl) {
        draggedEl.classList.remove("dragging");
        // Re-build currentPlan array based on new DOM order
        const newOrderEls = [...container.querySelectorAll(".selected-place")];
        const newPlan = [];
        newOrderEls.forEach((el) => {
          // old index
          const oldIndex = parseInt(el.dataset.index, 10);
          newPlan.push(currentPlan[oldIndex]);
        });
        currentPlan = newPlan;

        // Re-render so the numbers get updated
        renderSelectedPlaces(currentPlan);
        draggedEl = null;
      }
    });

    // figure out what element is just after the drag position
    function getDragAfterElement(container, y) {
      const nonDragged = [...container.querySelectorAll(".selected-place:not(.dragging)")];

      let closest = null;
      let closestOffset = Number.NEGATIVE_INFINITY;
      nonDragged.forEach(child => {
        const box = child.getBoundingClientRect();
        const offset = y - (box.top + box.height / 2);
        // offset < 0 means the mouse is above this child
        if (offset < 0 && offset > closestOffset) {
          closestOffset = offset;
          closest = child;
        }
      });
      return closest;
    }
  }

  // 6) Clear the entire plan
  document.getElementById("clear-button").addEventListener("click", function () {
    currentPlan = [];
    renderSelectedPlaces(currentPlan);
  });

  // // 7) Save plan (you can send the updated currentPlan to your server)

  function save_plan() {
    if (currentPlan.length === 0) {
      alert("여행 계획을 추가하세요.");
      return;
    }

    // Fetch session data
    const user_idx = sessionStorage.getItem("user_idx") || "1";
    const area_code = sessionStorage.getItem("area_code") || "1";
    const start_date = sessionStorage.getItem("start_date");
    const end_date = sessionStorage.getItem("end_date");
    const title = prompt("여행 계획 제목을 입력하세요:");

    if (!title) return;

    // Check if start_date and end_date are available
    if (!start_date || !end_date) {
      alert("여행 시작일과 종료일이 필요합니다.");
      return;
    }

    // // Generate all dates between start_date and end_date
    // const allDates = generate_date_range(start_date, end_date);
    allDates = generate_date_range(start_date, end_date);

    // Convert plan to structured format
    const planData = {
      user_idx: user_idx,
      area_code: area_code,
      title: title,
      start_date: start_date,
      end_date: end_date,
      status: 0,
      dates: {} // Will be populated with places for each date
    };

    // Initialize empty arrays for each date in the date range
    allDates.forEach(date => {
      planData.dates[date] = []; // Initialize an empty array for each date
    });

    console.log("planData", planData); //**

    // Populate the dates with the places from currentPlan
    currentPlan.forEach(place => {
      const dateKey = place.date; // This will be set in addPlaceToPlan
      if (planData.dates[dateKey]) {
        planData.dates[dateKey].push({
          content_id: place.contentid,
          content_type_id: 1,
          title: place.title,
          thumbnail: place.image,
          map_x: place.mapx,
          map_y: place.mapy,
          time: place.time || "00:00"
        });
      }
    });

    // Ensure the dates object is correctly populated
    // console.log("Plan data to be sent:", planData);

    // Send planData to the server
    fetch("/Controller?type=save_plan", {
      method: "POST",
      body: JSON.stringify(planData)
    })
        .then(response => response.json())
        .then(data => {
          console.log("fetch recieve data", data)
          if (data.success) {
            console.log("result success!");
          } else {
            console.log("result fail!");
          }
        })
        .catch(err => console.log("fetch recieve error", err))
  }

</script>
</body>
</html>
