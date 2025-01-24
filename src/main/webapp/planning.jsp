<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>여행 플래너</title>
  <style>
      body {
          margin: 0;
          font-family: 'Noto Sans KR', sans-serif;
          display: flex;
          height: 100vh;
          color: #333;
      }

      .content-wrapper {
          display: flex;
          width: 100%;
          height: 100%;
      }

      #left-panel {
          width: 12%;
          background-color: #fff;
          border-right: 1px solid #ddd;
          display: flex;
          flex-direction: column;
          align-items: center;
          padding: 15px;
      }

      #logo {
          font-size: 22px;
          font-weight: bold;
          color: #f56b2a;
          margin-bottom: 20px;
      }

      .date {
          margin-bottom: 8px;
          padding: 8px 12px;
          border-radius: 5px;
          background-color: #f5f5f5;
          text-align: center;
          cursor: pointer;
      }

      .date.active {
          background-color: #f56b2a;
          color: white;
          font-weight: bold;
      }

      .date:hover {
          background-color: #eaeaea;
      }

      #middle-left-panel {
          width: 25%;
          background-color: #f9f9f9;
          display: flex;
          flex-direction: column;
          padding: 15px;
      }

      #destination-header {
          font-size: 18px;
          font-weight: bold;
          margin-bottom: 5px;
      }

      #destination-date-range {
          font-size: 14px;
          color: #666;
          margin-bottom: 20px;
      }

      .categories {
          display: flex;
          gap: 10px;
          margin-bottom: 15px;
      }

      .category {
          display: flex;
          align-items: center;
          gap: 5px;
          padding: 5px 10px;
          background-color: #f5f5f5;
          border-radius: 5px;
          cursor: pointer;
      }

      .category:hover {
          background-color: #eaeaea;
      }

      #search-bar {
          display: flex;
          margin-bottom: 15px;
      }

      #search-bar input {
          flex-grow: 1;
          padding: 8px;
          border: 1px solid #ddd;
          border-radius: 5px;
          margin-right: 10px;
      }

      #search-bar button {
          padding: 8px 15px;
          background-color: #007bff;
          color: white;
          border: none;
          border-radius: 5px;
          cursor: pointer;
      }

      #search-bar button:hover {
          background-color: #0056b3;
      }

      #destination-list {
          flex-grow: 1;
          overflow-y: auto;
      }

      .destination {
          display: flex;
          align-items: center;
          margin-bottom: 10px;
          padding: 10px;
          background-color: #fff;
          border: 1px solid #ddd;
          border-radius: 5px;
      }

      .destination img {
          width: 50px;
          height: 50px;
          margin-right: 10px;
          border-radius: 5px;
      }

      .destination-info {
          flex-grow: 1;
      }

      .destination-info h4 {
          margin: 0;
          font-size: 16px;
          font-weight: bold;
      }

      .destination-info p {
          margin: 5px 0 0;
          font-size: 12px;
          color: #666;
      }

      .destination-info .ratings {
          display: flex;
          align-items: center;
          font-size: 12px;
          color: #666;
          margin-top: 5px;
      }

      .ratings span {
          margin-left: 5px;
      }

      .heart {
          font-size: 18px;
          color: #f44336;
          cursor: pointer;
      }

      .add-button {
          font-size: 16px;
          color: #007bff;
          cursor: pointer;
          margin-left: 10px;
      }

      #middle-panel {
          width: 20%;
          background-color: #f9f9f9;
          display: flex;
          flex-direction: column;
          padding: 15px;
      }

      #time-summary {
          font-size: 14px;
          margin-bottom: 10px;
          font-weight: bold;
      }

      #clear-button {
          align-self: flex-end;
          margin-bottom: 15px;
          padding: 8px 12px;
          background-color: #f44336;
          color: white;
          border: none;
          border-radius: 5px;
          cursor: pointer;
      }

      #clear-button:hover {
          background-color: #d32f2f;
      }

      .selected-place {
          display: flex;
          align-items: center;
          margin-bottom: 10px;
          padding: 10px;
          background-color: #fff;
          border: 1px solid #ddd;
          border-radius: 5px;
      }

      .selected-place .number {
          font-size: 16px;
          font-weight: bold;
          margin-right: 10px;
      }

      .selected-place .info {
          flex-grow: 1;
      }

      .selected-place .duration {
          font-size: 14px;
          color: #666;
      }

      #right-panel {
          width: 43%;
          background-color: #eaeaea;
          position: relative;
      }

      #map {
          width: 100%;
          height: 100%;
          background-color: #eaeaea; /* Placeholder for map */
      }

      #floating-button {
          position: absolute;
          top: 10px;
          right: 10px;
          background-color: #007bff;
          color: white;
          border: none;
          padding: 8px 12px;
          border-radius: 5px;
          cursor: pointer;
      }

      #floating-button:hover {
          background-color: #0056b3;
      }

      #action-buttons {
          display: flex;
          justify-content: space-between;
          margin-top: 20px;
      }

      .action-button {
          flex: 1;
          margin: 0 5px;
          padding: 10px;
          background-color: #007bff;
          color: white;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          font-size: 16px;
      }

      .action-button:hover {
          background-color: #0056b3;
      }
  </style>
</head>
<body>
<div class="content-wrapper">
  <!-- Left Panel -->
  <div id="left-panel">
    <div id="logo">zenzenclub</div>
    <div class="date active">2025-01-14</div>
    <div class="date">2025-01-15</div>
    <div class="date">2025-01-16</div>
    <div class="date">2025-01-17</div>
    <!-- Action Buttons -->
    <div id="action-buttons">
      <button class="action-button">저장</button>
    </div>
  </div>

  <!-- Middle-Left Panel -->
  <div id="middle-left-panel">
    <div id="destination-header">제주</div>
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
    <div id="destination-list">
      <div class="destination">
        <img src="https://via.placeholder.com/50" alt="thumbnail">
        <div class="destination-info">
          <h4>성산 일출봉</h4>
          <p>제주특별자치도 서귀포시 성산읍</p>
          <div class="ratings">⭐ <span>1612만</span> <span>4.7</span></div>
        </div>
        <span class="heart">♥</span>
        <span class="add-button">+</span>
      </div>
    </div>
    <!-- Action Buttons -->
    <div id="action-buttons">
      <button class="action-button">숙소 선택</button>
    </div>
  </div>

  <!-- Middle Panel -->
  <div id="middle-panel">
    <div id="time-summary">3 / 6시간 0분 / 24시간 0분</div>
    <button id="clear-button">장소 설정 초기화</button>
    <div class="selected-place">
      <div class="number">1</div>
      <div class="info">
        <h4>성산 일출봉</h4>
        <div class="duration">2시간 0분</div>
      </div>
    </div>
  </div>

  <!-- Right Panel -->
  <div id="right-panel">
    <div id="map">맵</div>
    <button id="floating-button">이용방법</button>
  </div>

</div>
</body>
</html>
