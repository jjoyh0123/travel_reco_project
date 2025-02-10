<%@ page import="mybatis.vo.PlaceVO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <title>후기 보기</title>
  <script
      src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=zMJiV7MhBT2LFF24HwQZXC808gWctsd9ydragwu8"></script>
  <style>
      /*    별점 기능*/
      .starpoint_wrap {
          display: inline-block;
      }

      .starpoint_box {
          position: relative;
          background: url('/www/sp_star.png') 0 0 no-repeat;
          font-size: 0;
      }

      .starpoint_box .starpoint_bg {
          display: block;
          position: absolute;
          top: 0;
          left: 0;
          height: 18px;
          background: url('/www/sp_star.png') 0 -20px no-repeat;
          pointer-events: none;
      }

      .starpoint_box .label_star {
          display: inline-block;
          width: 10px;
          height: 18px;
          box-sizing: border-box;
      }

      .starpoint_box .star_radio {
          opacity: 0;
          width: 0;
          height: 0;
          position: absolute;
      }

      .starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg {
          width: 8.7%;
      }

      .starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg {
          width: 18.7%;
      }

      .starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg {
          width: 28.7%;
      }

      .starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg {
          width: 38.7%;
      }

      .starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg {
          width: 48.7%;
      }

      .starpoint_box .star_radio:nth-of-type(6):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(6):checked ~ .starpoint_bg {
          width: 58.7%;
      }

      .starpoint_box .star_radio:nth-of-type(7):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(7):checked ~ .starpoint_bg {
          width: 68.7%;
      }

      .starpoint_box .star_radio:nth-of-type(8):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(8):checked ~ .starpoint_bg {
          width: 78.7%;
      }

      .starpoint_box .star_radio:nth-of-type(9):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(9):checked ~ .starpoint_bg {
          width: 88.7%;
      }

      .starpoint_box .star_radio:nth-of-type(10):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(10):checked ~ .starpoint_bg {
          width: 98.7%;
      }

      .blind {
          position: absolute;
          clip: rect(0 0 0 0);
          margin: -1px;
          width: 1px;
          height: 1px;
          overflow: hidden;
      }

      body {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0;
          background-color: #F5F5F7;
      }

      .content {
          width: 1100px;
          min-height: 600px;
          flex-grow: 1;
          margin-bottom: 20px;
      }

      .journal_box {
          background-color: white;
          border-radius: 40px;
          /*border: 1px solid red;*/
          width: 100%;
          margin-bottom: 20px;
          padding-bottom: 20px;
      }

      #journal_carousel {
          /*background-color: #bbbbbb;*/
          width: 70%;
          /*height: 70%;*/
          margin: 0 auto;
          border-radius: 20px;
          border: none;
      }

      #carouselExample {
          border: none
      }

      .main_carousel_image {
          display: inline-block;
          border-radius: 20px; /* 이미지 테두리를 둥글게 설정 */
          max-width: 100%;
          max-height: 400px;
          width: 100%; /* 부모 요소에 맞춤 */
          height: 400px; /* 원하는 높이로 조정 */
          object-fit: cover; /* 이미지 비율 유지 및 잘라내기 */
          margin-top: 20px;
          /*box-shadow: 6px 6px 12px gray; !* 그림자 효과 추가 *!*/

      }

      .carousel-item {
          position: relative; /* 상대 위치 기준 */
      }

      #add_image_button2:hover {
          /*background-color: white;*/
          transform: scale(1.1); /* 마우스 호버 시 약간 확대 */
          /*filter: brightness(1.2);  !* 밝기 조정 *!*/
      }

      .add_image_button {
          width: 50px; /* 버튼 크기 조정 (원하는 크기로 조절 가능) */
          height: 50px; /* 버튼 크기 조정 (원하는 크기로 조절 가능) */
          cursor: pointer; /* 클릭 가능한 커서로 변경 */
          transition: transform 0.3s ease;
          z-index: 10; /* 최상위 레이어로 설정 */
      }

      #add_image_button2 {
          position: absolute; /* 절대 위치 설정 */
          right: 20px; /* 오른쪽에서 20px 떨어진 위치 */
          bottom: 40px; /* 아래쪽에서 20px 떨어진 위치 */
      }

      #journal_article {
          width: 70%; /* 부모 요소에 맞춤 */
          height: 300px; /* 원하는 높이로 조정 */
          /*border: 1px solid black;*/
          margin: 20px auto;
      }

      .journal_text {
          width: 100%;
          border: none;
          /*height: 200px;*/
          /*margin-bottom: 20px;*/
      }

      #journal_title {
          font-size: 20px;
          /*font-weight: bold;*/
      }

      textarea {
          resize: none;
      }

      .journal_day {
          margin: 0 auto;
          /*border: 1px solid blue;*/
          width: 70%;
      }

      .day_button {
          display: inline-block;
          text-align: center;
          border-radius: 40px;
          border: 1px solid #bbbbbb;
          width: 90px;
          margin: auto;
          font-size: 14px;
          padding: 5px;
          cursor: pointer;
          transition: background-color 0.3s, color 0.3s;
      }

      .date {
          color: #bbbbbb;
          display: inline;
          font-weight: 700;
      }

      .day {
          display: inline;
          font-weight: 900;
      }

      .day, .date {
          margin: 0;
          padding: 0;
      }

      .day_bar {
          font-weight: 900;
          margin: 20px auto;
          font-size: 20px;
          display: flex;
          padding: 10px;
          /*border: 1px solid #bbbbbb;*/

      }

      .edit_button {
          width: 30px;
          height: 30px;
          margin-left: auto; /* 오른쪽 정렬 */
          /*background-color: white;*/
      }

      .vertical_line {
          width: 3px; /* 세로 줄 두께 */
          height: 15px; /* 세로 줄 길이 */
          background-color: #bbbbbb; /* 세로 줄 색상 */
          display: inline;
          margin: auto 10px;
          align-items: center;
      }

      .circle {
          border-radius: 50%;
          border: 1px solid #555555;
          width: 25px;
          height: 25px;
          /*line-height: 26px;*/
          color: white;
          background-color: #007bff;
          font-weight: bold;
          text-align: center;
          font-size: 14px;
          /*align-items: center;*/
      }

      .journal_place {
          display: flex;
          /*border: 1px solid red;*/
          margin: 30px auto;
      }

      .place_name {
          font-weight: 800;
      }

      .place_info {
          /*display: block;*/
          color: #bbbbbb;
          font-size: 12px;
      }

      .place_div {
          margin-left: 10px;
      }

      .circle_container {
          display: flex;
          flex-direction: column; /* 요소들을 세로로 정렬 */
          align-items: center; /* 중앙 정렬 */
      }

      .long_vertical_line {
          width: 2px; /* 세로 줄 두께 */
          height: 50px; /* 세로 줄 길이 */
          background-color: #bbbbbb; /* 줄 색상 */
          margin-top: 5px; /* 원과의 간격 */
      }

      .day_button.active {
          background-color: #007bff; /* 클릭 후 배경 색 */
          color: white; /* 클릭 후 텍스트 색 */
      }

      .modal_button {
          background-color: white;
          border: none;
          margin-left: auto;
          padding-top: 10px;
          align-self: start;
      }

      .modal_button:hover {
          cursor: pointer; /* 클릭 가능한 커서로 변경 */
          transition: transform 0.3s ease;
          transform: scale(1.1); /* 마우스 호버 시 약간 확대 */
          /*filter: brightness(1.2);  !* 밝기 조정 *!*/
      }

      .modal_title {
          background-color: black;
          color: white;
          width: 100%;
          border-radius: 10px;
          margin: 0 auto;
          height: 40px;
      }

      .modal_day_bar {
          line-height: 40px;
          font-weight: 900;
          font-size: 20px;
          display: flex;
          margin: 0 10px;
          align-items: center;
          justify-content: space-between;
      }

      .modal_vertical_line {
          width: 3px; /* 세로 줄 두께 */
          height: 30px; /* 세로 줄 길이 */
          background-color: white; /* 세로 줄 색상 */
          margin: 0 20px;
      }

      .modal_day {
          text-align: left;
          flex: 1;
          margin-left: 5px;
      }

      .modal_date {
          text-align: right;
          flex: 1;
          margin-right: 5px;
      }

      .nav {
          background-color: white;
          margin-top: 20px;
      }

      .nav-item {
          background-color: white;
      }

      #navbar-example2 {
          background-color: white;
      }

      .nav-link {
          padding: 5px;
      }

      .modal_textarea {
          border-radius: 10px;
          width: 100%;
      }

      .modal-content {
          width: 370px;
      }

      h3 {
          font-weight: 700;
      }

      .modal_image {
          /*display: inline-block;*/
          border-radius: 20px; /* 이미지 테두리를 둥글게 설정 */
          width: 100%; /* 부모 요소에 맞춤 */
          height: 100%; /* 원하는 높이로 조정 */
          object-fit: cover; /* 이미지 비율 유지 및 잘라내기 */
      }

      .modal_carousel_area {
          width: 100%;
          height: 200px;
          margin-right: 0;
          position: relative; /* 캐러셀의 부모 요소에 상대 위치 지정 */
      }

      .add_image_button_area {
          position: absolute; /* 버튼을 절대 위치로 설정 */
          bottom: 20px; /* 캐러셀 하단에서 20px 떨어지게 */
          right: 20px; /* 캐러셀 오른쪽에서 20px 떨어지게 */
          z-index: 10; /* 버튼이 다른 요소 위에 오도록 설정 */
      }

      #add_image_button1 {
          width: 35px; /* 버튼 크기 조정 */
          height: 35px; /* 버튼 크기 조정 */
          cursor: pointer; /* 클릭할 수 있음을 시각적으로 표현 */
          margin-right: 10px;
          margin-bottom: 10px;
      }

      #add_image_button1:hover {
          transform: scale(1.1); /* 마우스 호버 시 약간 확대 */
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

      .map_div {
          width: 100%;
          height: 400px;
          /*border: 1px solid red;*/
      }

      .place_review {
          display: flex;
          align-items: center; /* 세로 중앙 정렬 */
          gap: 20px; /* 요소 간 간격 */
      }

      .show_place_review {
          display: flex;
          flex-direction: column; /* 세로 방향 정렬 */
          align-items: flex-start; /* 왼쪽 정렬 (위쪽 정렬 포함) */
          justify-content: flex-start; /* 위쪽 정렬 */
          gap: 5px; /* 후기와 별점 사이 간격 */
          margin-bottom: 250px;
      }

      .place_review_carousel {
          flex: 1; /* 오른쪽 영역 차지 */
          display: flex;
          width: 100%;
          justify-content: center; /* 중앙 정렬 */
      }

      .rate img {
          height: 1em; /* 글자 크기와 동일 */
          width: auto; /* 비율 유지 */
          vertical-align: middle; /* 글자와 정렬 */
      }

      .journal_carousel {
          width: 700px; /* 원하는 크기로 조정 */
          max-width: 100%; /* 반응형 유지 */
          height: 300px;
      }

      .carousel-inner {
          width: 100%;
      }

      .main_carousel_image {
          width: 100%; /* 캐러셀 크기에 맞게 이미지 조정 */
          height: auto; /* 비율 유지 */
          object-fit: cover; /* 필요하면 추가 */
      }


  </style>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
<article class="content">
  <%--  이미지 케러셀--%>
  <div class="journal_box">
    <div id="journal_carousel">
      <div id="carouselExample" class="carousel slide">
        <div class="carousel-inner">
          <c:forEach var="image" items="${imageList}" varStatus="index">
            <c:if test="${image.plan_idx == plan_idx}">
              <div class="carousel-item ${index.first ? 'active' : ''}">
                <img src="${image.file_path}" alt="${image.file_path}" class="main_carousel_image">
              </div>
            </c:if>
          </c:forEach>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
    </div>
    <%--    이미지 케러셀 끝--%>
    <%--    간단한 후기 글 작성란--%>
    <div id="journal_article">
      <%--      <input type="text" class="journal_text" id="journal_title" maxlength="25" placeholder="여행기 제목(필수 최대 25자)" value="${journalVO.title}">--%>
      <a id="journal_title">${journalVO.title}</a>
      <hr>
      <%--      <textarea class="journal_text" id="journal_" rows="9" maxlength="250" placeholder="이번 여행은 어떤 여행이었나요? 여행에 대한 한 줄 요약 또는 여행 꿀팁을 남겨보세요.(최대 250자)">${fn:trim(journalVO.subtitle)}</textarea>--%>
      <a>${fn:trim(journalVO.subtitle)}</a>
    </div>
  </div>

  <div class="journal_box">
    <div class="journal_day">
      <nav id="navbar-example2" class="navbar">
        <ul class="nav nav-pills">
          <c:forEach var="dateVO" items="${dateVO}" varStatus="index">
            <li class="nav-item">
              <a class="nav-link" href="#scrollspyHeading${index.index}">
                <div class="day_button" onclick="changeColor(this)">
                  <p class="day">day ${index.count}</p>
                  <br>
                  <p class="date">
                    <fmt:parseDate value="${dateVO.date}" pattern="yyyy-MM-dd" var="parsedDate"/>
                    <!-- 월/일/요일 형식으로 출력 -->
                    <fmt:formatDate value="${parsedDate}" pattern="M.dd/EEE"/>
                  </p>
                </div>
              </a>
            </li>
          </c:forEach>
        </ul>
      </nav>
      <div class="day_box">
        <%--  Day 바 --%>
        <c:forEach var="dateVO" items="${dateVO}" varStatus="status">
          <div id="map_div${status.index}" class="map_div"></div>

          <div id="waypointsData${status.index}" style="display:none;">
            {
            <c:set var="first" value="true"/>
            <c:forEach var="temp" items="${list}">
              <c:if test="${temp.date_idx == dateVO.idx}">
                <c:if test="${not first}">,</c:if>
                "${temp.title}": {
                "lng": ${temp.map_x},
                "lat": ${temp.map_y}
                }
                <c:set var="first" value="false"/>
              </c:if>
            </c:forEach>
            }
          </div>
          <div class="day_bar" id="scrollspyHeading${status.index}">
            Day ${status.count}
            <div class="vertical_line"></div>
              ${dateVO.date}
          </div>

          <hr>

          <c:forEach var="list" items="${list}" varStatus="status2">
            <c:if test="${list.date_idx == dateVO.idx}">
              <div class="journal_place">
                <div class="circle_container">
                  <div class="circle">${list.visit_order}</div>
                  <div class="long_vertical_line"></div>
                </div>
                <div class="place_div">
                  <div class="place_name" id="day${status2.count}_place${status2.count}" data-bs-toggle="modal"
                       data-bs-target="#exampleModal${status2.count}" style="cursor: pointer">
                      ${list.title}
                  </div>
                  <p class="place_info">
                    <c:if test="${planVO.area_code == 1}">서울</c:if>
                    <c:if test="${planVO.area_code == 2}">인천</c:if>
                    <c:if test="${planVO.area_code == 3}">대전</c:if>
                    <c:if test="${planVO.area_code == 4}">대구</c:if>
                    <c:if test="${planVO.area_code == 5}">광주</c:if>
                    <c:if test="${planVO.area_code == 6}">경남</c:if>
                    <c:if test="${planVO.area_code == 7}">울산</c:if>
                    <c:if test="${planVO.area_code == 31}">경기</c:if>
                    <c:if test="${planVO.area_code == 32}">강원</c:if>
                    <c:if test="${planVO.area_code == 33}">충북</c:if>
                    <c:if test="${planVO.area_code == 34}">충남</c:if>
                    <c:if test="${planVO.area_code == 35}">경북</c:if>
                    <c:if test="${planVO.area_code == 36}">경남</c:if>
                    <c:if test="${planVO.area_code == 37}">전북</c:if>
                    <c:if test="${planVO.area_code == 38}">전남</c:if>
                    <c:if test="${planVO.area_code == 39}">제주도</c:if>
                    <c:if test="${planVO.area_code == 8}">세종</c:if>
                    *
                    <c:if test="${list.content_type_id == 32}">숙박</c:if>
                    <c:if test="${list.content_type_id == 38}">쇼핑</c:if>
                    <c:if test="${list.content_type_id == 39}">음식</c:if>
                    <c:if test="${list.content_type_id == 28}">레포츠</c:if>
                    <c:if test="${list.content_type_id == 25}">여행코스</c:if>
                    <c:if test="${list.content_type_id == 15}">축제/공연/행사</c:if>
                    <c:if test="${list.content_type_id == 14}">문화시설</c:if>
                    <c:if test="${list.content_type_id == 12}">관광지</c:if>
                  </p>
                    <%-- review가 표시될 div --%>
                    <%--                  <div id="reviewPreview${index.count}" class="place_info"></div>--%>
                </div>
                  <%--                <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal${index.count}">--%>
                  <%--                  <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">--%>
                  <%--                </button>--%>
              </div>
              <%--          후기 div--%>
              <c:forEach var="rv" items="${reviewVO}">

                <c:if test="${list.place_idx == rv.place_idx}">
                  <div class="place_review">

                    <div class="show_place_review">
                      <div class="review">작성한 후기: ${reviewVO.review}</div>
                        <%--          별점 div--%>
                      <div class="rate">별점:
                        <c:if test="${reviewVO.rate == 5}">
                          <img src="/www/rate_5.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 4.5}">
                          <img src="/www/rate_4.5.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 4}">
                          <img src="/www/rate_4.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 3.5}">
                          <img src="/www/rate_3.5.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 3}">
                          <img src="/www/rate_3.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 2.5}">
                          <img src="/www/rate_2.5.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 2}">
                          <img src="/www/rate_2.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 1.5}">
                          <img src="/www/rate_1.5.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 1}">
                          <img src="/www/rate_1.png">
                        </c:if>
                        <c:if test="${reviewVO.rate == 0.5}">
                          <img src="/www/rate_0.5.png">
                        </c:if>
                      </div>
                    </div>
                    <div class="place_review_carousel">
                      <div class="journal_box">
                        <div id="journal_carousel" class="journal_carousel">
                          <div id="carouselExample" class="carousel slide">
                            <div class="carousel-inner">
                              <c:forEach var="image" items="${imageList}" varStatus="index">
                                <%--                          <c:if test="${image.plan_idx == plan_idx}">--%>
                                <div class="carousel-item ${index.first ? 'active' : ''}">
                                  <img src="${image.file_path}" alt="${image.file_path}" class="main_carousel_image">
                                </div>
                                <%--                          </c:if>--%>
                              </c:forEach>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample"
                                    data-bs-slide="prev">
                              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample"
                                    data-bs-slide="next">
                              <span class="carousel-control-next-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Next</span>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </c:if>

              </c:forEach>
            </c:if>
          </c:forEach>

        </c:forEach>

      </div>
    </div>
  </div>

</article>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  <%--day 이동 버튼--%>

  function changeColor(button) {
    // 모든 버튼에서 active 클래스를 제거
    var buttons = document.querySelectorAll('.day_button');
    buttons.forEach(function (btn) {
      btn.classList.remove('active');
    });

    // 클릭한 버튼에 active 클래스 추가
    button.classList.add('active');
  }

  function upload_images() {
    var form = $('#upload_form')[0];
    var form_data = new FormData(form);
    const result_div = document.getElementById('result');

    $.ajax({
      url: 'http://${applicationScope.publicIP}:8080/Controller?type=upload_image',
      type: 'POST',
      data: form_data,
      processData: false,
      contentType: false,
      success: function (response) {
        if (response.status === 'success') {
          // 결과 메시지 표시
          result_div.innerHTML = '';
          let image_names_html = '<ul>';
          for (let i = 0; i < response.image_names.length; i++) {
            image_names_html += '<li>' + 'http://${applicationScope.publicIP}' + response.image_names[i] + '</li>';
          }
          image_names_html += '</ul>';
          result_div.innerHTML = `<p>${response.message}</p><p>업로드된 파일 목록:</p>` + image_names_html;
        } else {
          result_div.innerHTML = '<p>${response.status}</p><p>${response.message}</p>';
        }
      },
      error: function (xhr, status, error) {
        alert('Error: ' + error);
      }
    });
  }

  // textarea 글 출력
  document.addEventListener("DOMContentLoaded", function () {
    let waypointsElements = document.querySelectorAll("[id^='waypointsData']");

    waypointsElements.forEach((element, index) => {
      initializeMap('map_div' + index, element.id, colors);
    });

    document.querySelectorAll("textarea[id^='textarea${index.count}']").forEach(textarea => {
      const index = textarea.id.replace("textarea", ""); // ID에서 숫자 추출
      const output = document.getElementById(`outputText${index.count}`);

      textarea.addEventListener("input", function () {
        output.textContent = textarea.value;
      });
    });
  });

  // rate 출력
  function updateStarRating(rating, title) {
    // 선택된 별점에 맞게 starpoint_bg의 너비를 조정
    const starBg = document.querySelector('.starpoint_box .starpoint_bg');
    const percentage = (rating / 5) * 100; // 5점 만점 기준으로 비율 계산
    starBg.style.width = percentage + '%';

    // 선택된 별점의 title 값을 출력
    document.getElementById("selectedRating${index.count}").innerText = title;
  }

  function initializeMap(mapDivId, waypointsDataId, colors) {
    let map = new Tmapv2.Map(mapDivId, {
      center: new Tmapv2.LatLng(37, 127),
      // width: "750px",
      // height: "750px",
      zoom: 17,
      httpsMode: true
    });

    let markerArr = [];
    let lineArr = [];
    let currentWaypoints = [];

    // JSON 형식의 좌표 데이터를 읽어오기
    let waypointsData = JSON.parse(document.getElementById(waypointsDataId).innerText);

    // waypointsData 의 키를 배열로 만듦
    let waypointKeys = Object.keys(waypointsData);

    // 시작점과 종료점을 waypointsData 의 첫 번째 및 마지막 항목으로 설정
    let start = waypointsData[waypointKeys[0]];
    let end = waypointsData[waypointKeys[waypointKeys.length - 1]];

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

        console.log(requestData);

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
  }

  // 통일된 색상 배열
  let colors = [
    "#FF0000", "#FFA500", "#FFFF00", "#008000",
    "#0000FF", "#4B0082", "#EE82EE", "#A52A2A",
    "#FFD700", "#ADFF2F", "#000080", "#8A2BE2",
    "#FF69B4", "#FF6347", "#00FFFF", "#4682B4",
    "#DC143C", "#FF8C00", "#ADFF2F", "#6A5ACD"
  ];

</script>
<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>
