<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <title>후기 작성</title>
  <style>
      /*    별점 기능*/
      .starpoint_wrap{
          display:inline-block;
      }
      .starpoint_box{
          position:relative;
          background:url('/www/sp_star.png') 0 0 no-repeat;
          font-size:0;
      }
      .starpoint_box .starpoint_bg{
          display:block;
          position:absolute;
          top:0;
          left:0;
          height:18px;
          background:url('/www/sp_star.png') 0 -20px no-repeat;
          pointer-events:none;
      }
      .starpoint_box .label_star{
          display:inline-block;
          width:10px;
          height:18px;
          box-sizing:border-box;
      }
      .starpoint_box .star_radio{
          opacity:0;
          width:0;
          height:0;
          position:absolute;
      }
      .starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg{
          width:10%;
      }
      .starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg{
          width:20%;
      }
      .starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg{
          width:30%;
      }
      .starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg{
          width:40%;
      }
      .starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg{
          width:50%;
      }
      .starpoint_box .star_radio:nth-of-type(6):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(6):checked ~ .starpoint_bg{
          width:60%;
      }
      .starpoint_box .star_radio:nth-of-type(7):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(7):checked ~ .starpoint_bg{
          width:70%;
      }
      .starpoint_box .star_radio:nth-of-type(8):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(8):checked ~ .starpoint_bg{
          width:80%;
      }
      .starpoint_box .star_radio:nth-of-type(9):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(9):checked ~ .starpoint_bg{
          width:90%;
      }
      .starpoint_box .star_radio:nth-of-type(10):hover ~ .starpoint_bg,
      .starpoint_box .star_radio:nth-of-type(10):checked ~ .starpoint_bg {
          width:100%;
      }

      .blind{
          position:absolute;
          clip:rect(0 0 0 0);
          margin:-1px;
          width:1px;
          height: 1px;
          overflow:hidden;
      }

      body {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0;
          background-color: #F5F5F7;
      }
      .content{
          width: 1100px;
          min-height: 600px;
          flex-grow: 1;
          margin-bottom: 20px;
      }
      .journal_box{
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
      .main_carousel_image{
          display: inline-block;
          border-radius: 20px; /* 이미지 테두리를 둥글게 설정 */
          max-width: 100%;
          max-height: 80%;
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
          transform: scale(1.1);  /* 마우스 호버 시 약간 확대 */
          /*filter: brightness(1.2);  !* 밝기 조정 *!*/
      }
      .add_image_button {
          width: 50px; /* 버튼 크기 조정 (원하는 크기로 조절 가능) */
          height: 50px; /* 버튼 크기 조정 (원하는 크기로 조절 가능) */
          cursor: pointer; /* 클릭 가능한 커서로 변경 */
          transition: transform 0.3s ease;
          z-index: 10;  /* 최상위 레이어로 설정 */
      }
      #add_image_button2{
          position: absolute; /* 절대 위치 설정 */
          right: 20px; /* 오른쪽에서 20px 떨어진 위치 */
          bottom: 40px; /* 아래쪽에서 20px 떨어진 위치 */
      }
      #journal_article{
          width: 70%; /* 부모 요소에 맞춤 */
          height: 300px; /* 원하는 높이로 조정 */
          /*border: 1px solid black;*/
          margin: 20px auto;
      }
      .journal_text{
          width: 100%;
          border: none;
          /*height: 200px;*/
          /*margin-bottom: 20px;*/
      }
      #journal_title{
          font-size: 20px;
          /*font-weight: bold;*/
      }
      textarea{
          resize: none;
      }
      .journal_day{
          margin: 0 auto;
          /*border: 1px solid blue;*/
          width: 70%;
      }
      .day_button{
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
      .date{
          color: #bbbbbb;
          display: inline;
          font-weight: 700;
      }
      .day{
          display: inline;
          font-weight: 900;
      }
      .day, .date{
          margin: 0;
          padding: 0;
      }
      .day_bar{
          font-weight: 900;
          margin: 20px auto;
          font-size: 20px;
          display: flex;
          padding: 10px;
          /*border: 1px solid #bbbbbb;*/

      }
      .edit_button{
          width: 30px;
          height: 30px;
          margin-left: auto; /* 오른쪽 정렬 */
          /*background-color: white;*/
      }
      .vertical_line {
          width: 3px;               /* 세로 줄 두께 */
          height: 15px;            /* 세로 줄 길이 */
          background-color: #bbbbbb;   /* 세로 줄 색상 */
          display: inline;
          margin: auto 10px;
          align-items: center;
      }
      .circle{
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
      .journal_place{
          display: flex;
          /*border: 1px solid red;*/
          margin: 30px auto;
      }
      .place_name{
          font-weight: 800;
      }
      .place_info{
          /*display: block;*/
          color: #bbbbbb;
          font-size: 12px;
      }
      .place_div{
          margin-left: 10px;
      }
      .circle_container {
          display: flex;
          flex-direction: column;  /* 요소들을 세로로 정렬 */
          align-items: center;     /* 중앙 정렬 */
      }
      .long_vertical_line{
          width: 2px;             /* 세로 줄 두께 */
          height: 50px;           /* 세로 줄 길이 */
          background-color: #bbbbbb; /* 줄 색상 */
          margin-top: 5px;        /* 원과의 간격 */
      }
      .day_button.active {
          background-color: #007bff; /* 클릭 후 배경 색 */
          color: white; /* 클릭 후 텍스트 색 */
      }
      .modal_button{
          background-color: white;
          border: none;
          margin-left: auto;
      }
      .modal_button:hover{
          cursor: pointer; /* 클릭 가능한 커서로 변경 */
          transition: transform 0.3s ease;
          transform: scale(1.1);  /* 마우스 호버 시 약간 확대 */
          /*filter: brightness(1.2);  !* 밝기 조정 *!*/
      }
      .modal_title{
          background-color: black;
          color: white;
          width: 100%;
          border-radius: 10px;
          margin: 0 auto;
          height: 40px;
      }
      .modal_day_bar{
          line-height: 40px;
          font-weight: 900;
          font-size: 20px;
          display: flex;
          margin: 0 10px;
          align-items: center;
          justify-content: space-between;
      }
      .modal_vertical_line{
          width: 3px;               /* 세로 줄 두께 */
          height: 30px;            /* 세로 줄 길이 */
          background-color: white;   /* 세로 줄 색상 */
          margin: 0 20px;
      }
      .modal_day{
          text-align: left;
          flex: 1;
          margin-left: 5px;
      }
      .modal_date{
          text-align: right;
          flex: 1;
          margin-right: 5px;
      }
      .nav{
          background-color: white;
          margin-top: 20px;
      }
      .nav-item{
          background-color: white;
      }
      #navbar-example2{
          background-color: white;
      }
      .nav-link{
          padding: 5px;
      }
      #modal_textarea{
          border-radius: 10px;
          width: 100%;
      }
      .modal-content{
          width: 370px;
      }
      h3{
          font-weight: 700;
      }

      .modal_img{
          /*display: inline-block;*/
          border-radius: 20px; /* 이미지 테두리를 둥글게 설정 */
          width: 100%; /* 부모 요소에 맞춤 */
          height: 100%; /* 원하는 높이로 조정 */
          object-fit: cover; /* 이미지 비율 유지 및 잘라내기 */
      }
      #modal_carousel_area{
          width: 100%;
          height: 200px;
          margin-right: 0;
          position: relative; /* 캐러셀의 부모 요소에 상대 위치 지정 */
      }

      #add_image_button_area {
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
          transform: scale(1.1);  /* 마우스 호버 시 약간 확대 */
      }
  </style>
</head>
<body>

<!-- 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <%--모달 제목--%>
<%--        <h1 class="modal-title fs-5" id="exampleModalLabel">--%>
          <h2 class="modal_title">
            <div class="modal_day_bar">
              <div class="modal_day">Day 1</div>
              <div class="modal_vertical_line"></div>
              <div class="modal_date">2024.08.23</div>
            </div>
          </h2>

<%--        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
      </div>
      <div class="modal-body">
        <h3>제주 국제 공항</h3>
<%--별점 기능--%>
        <div class="starpoint_wrap">
          <div class="starpoint_box">
            <label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5점</span></label>
            <label for="starpoint_2" class="label_star" title="1"><span class="blind">1점</span></label>
            <label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5점</span></label>
            <label for="starpoint_4" class="label_star" title="2"><span class="blind">2점</span></label>
            <label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5점</span></label>
            <label for="starpoint_6" class="label_star" title="3"><span class="blind">3점</span></label>
            <label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5점</span></label>
            <label for="starpoint_8" class="label_star" title="4"><span class="blind">4점</span></label>
            <label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5점</span></label>
            <label for="starpoint_10" class="label_star" title="5"><span class="blind">5점</span></label>
            <input type="radio" name="starpoint" id="starpoint_1" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_2" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_3" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_4" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_5" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_6" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_7" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_8" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_9" class="star_radio">
            <input type="radio" name="starpoint" id="starpoint_10" class="star_radio">
            <span class="starpoint_bg"></span>
          </div>
        </div>
      <%--별점 기능 끝--%>
        <hr>
        <textarea id="modal_textarea" maxlength="250" rows="5" placeholder="간단한 후기 작성(250자)"></textarea>
        <hr>
        <div id="add_image_area">
<%--      사진 추가 버튼--%>
        <div id="add_image_button_area">
          <img src="/www/add_image_button.png" id="add_image_button1" class="add_image_button" alt="사진 추가 버튼">
        </div>
<%--  사진 추가 버튼 끝--%>
<%--          캐러셀--%>
        <div id="modal_carousel_area">
          <div id="modal_carousel" class="carousel slide">
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="/www/journal1.jpg" class="modal_img" alt="...">
              </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample1" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample2" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>
          </div>
        </div>
      </div>
<%--      캐러셀 끝--%>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<jsp:include page="/jsp/header.jsp"/>
<article class="content">
<%--  이미지 케러셀--%>
  <div class="journal_box">
    <div id="journal_carousel">
      <div id="carouselExample" class="carousel slide">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="/www/journal1.jpg" class="main_carousel_image" alt="후기 사진1">
          </div>
          <div class="carousel-item">
            <img src="/www/journal2.jpg" class="main_carousel_image" alt="후기 사진2">
          </div>
          <div class="carousel-item">
            <img src="/www/journal3.jpg" class="main_carousel_image" alt="후기 사진3">
          </div>
          <img src="/www/add_image_button.png" id="add_image_button2" class="add_image_button" alt="사진 추가 버튼">
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
      <input type="text" class="journal_text" id="journal_title" maxlength="25" placeholder="여행기 제목(필수 최대 25자)">
      <hr>
      <textarea class="journal_text" id="journal_" rows="9" maxlength="250" placeholder="이번 여행은 어떤 여행이었나요? 여행에 대한 한 줄 요약 또는 여행 꿀팁을 남겨보세요.(최대 250자)"></textarea>
    </div>

  </div>

  <div class="journal_box">

    <div class="journal_day">

        <nav id="navbar-example2" class="navbar">
          <ul class="nav nav-pills">
            <li class="nav-item">
              <a class="nav-link" href="#scrollspyHeading1">
                <div class="day_button" onclick="changeColor(this)"><p class="day">day1</p><br><p class="date">8.23/금</p></div>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#scrollspyHeading2">
                <div class="day_button" onclick="changeColor(this)"><p class="day">day2</p><br><p class="date">8.24/토</p></div>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#scrollspyHeading3">
                <div class="day_button" onclick="changeColor(this)"><p class="day">day3</p><br><p class="date">8.25/일</p></div>
              </a>
            </li>
          </ul>
        </nav>


    <div class="day_box">
      <%--  Day 바 --%>
      <div class="day_bar" id="scrollspyHeading1">
        Day 1
        <div class="vertical_line"></div>
        2024.08.23
        <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
          <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
        </button>
      </div>

      <hr>

      <%--  day1   --%>
      <div class="journal_place">
        <div  class="circle_container">
          <div class="circle">1</div>
          <div class="long_vertical_line"></div>
        </div>
        <div class="place_div">
          <div class="place_name" id="day1_place1">제주 국제공항</div>
          <p class="place_info">관광명소 * 제주 시내</p>
        </div>
        <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
          <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
        </button>
      </div>

        <div class="journal_place">

          <div  class="circle_container">
            <div class="circle">2</div>
            <div class="long_vertical_line"></div>
          </div>
          <div class="place_div">
            <div class="place_name" id="day1_place2">호텔 브릿지 서귀포</div>
            <p class="place_info">숙소 * 서귀포</p>
          </div>
            <!-- 모달을 실행할 버튼 -->
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>

        </div>

        <div class="journal_place">
          <div  class="circle_container">
            <div class="circle">3</div>
            <div class="long_vertical_line"></div>
          </div>
          <div class="place_div">
            <div class="place_name" id="day1_place3">나원 회 포차</div>
            <p class="place_info">음식점 * 서귀포</p>
          </div>
          <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
          </button>
        </div>

        <div class="journal_place">
          <div  class="circle_container">
            <div class="circle">4</div>
            <div class="long_vertical_line"></div>
          </div>
          <div class="place_div">
            <div class="place_name" id="day1_place4">제주 약수터 올레 시장 점</div>
            <p class="place_info">술집/바 * 서귀포</p>
          </div>
          <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
          </button>
        </div>

        <div class="journal_place">
          <div  class="circle_container">
            <div class="circle">5</div>
            <div class="long_vertical_line"></div>
          </div>
          <div class="place_div">
            <div class="place_name" id="day1_place5">뽈살집 서귀포 점</div>
            <p class="place_info">음식점 * 서귀포</p>
          </div>
          <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
          </button>
        </div>

        <div class="journal_place">
          <div  class="circle_container">
            <div class="circle">6</div>
            <div class="long_vertical_line"></div>
          </div>
          <div class="place_div">
            <div class="place_name" id="day1_place6">흑돼지 비비큐</div>
            <p class="place_info">음식점 * 제주 서귀포시</p>
          </div>
          <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
          </button>
        </div>
    </div>

        <div class="day_box">
          <%--  Day 바 --%>
          <div class="day_bar" id="scrollspyHeading2">
            Day 2
            <div class="vertical_line"></div>
            2024.08.24
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

          <hr>

          <%--  day2   --%>
          <div class="journal_place">
            <div  class="circle_container">
              <div class="circle">1</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day2_place1">유동 커피</div>
              <p class="place_info">카페/디저트 * 서귀포</p>
            </div>
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

          <div class="journal_place">
            <div  class="circle_container">
              <div class="circle">2</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day2_place2">자리돔 횟집</div>
              <p class="place_info">음식점 * 서귀포</p>
            </div>
            <!-- 모달을 실행할 버튼 -->
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

          <div class="journal_place">
            <div  class="circle_container">
              <div class="circle">3</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day2_place3">귤꽃다락</div>
              <p class="place_info">카페/디저트 * 서귀포</p>
            </div>
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

          <div class="journal_place">
            <div  class="circle_container">
              <div class="circle">4</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day2_place4">너븐</div>
              <p class="place_info">카페/디저트 * 서귀포</p>
            </div>
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

          <div class="journal_place">
            <div  class="circle_container">
              <div class="circle">5</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day2_place5">한라산 과자점 서귀포 점</div>
              <p class="place_info">카페/디저트 * 제주 서귀포시</p>
            </div>
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

            <div class="journal_place">
              <div  class="circle_container">
                <div class="circle">6</div>
                <div class="long_vertical_line"></div>
              </div>
              <div class="place_div">
                <div class="place_name" id="day2_place6">제주 약수터 본점</div>
                <p class="place_info">술집/바 * 서귀포</p>
              </div>
              <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
                <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
              </button>
            </div>

            <div class="journal_place">
              <div  class="circle_container">
                <div class="circle">7</div>
                <div class="long_vertical_line"></div>
              </div>
              <div class="place_div">
                <div class="place_name" id="day2_place7">제일 수사 횟집</div>
                <p class="place_info">음식점 * 서귀포</p>
              </div>
              <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
                <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
              </button>
            </div>
        </div>
        <div class="day_box">
          <%--  Day 바 --%>
          <div class="day_bar" id="scrollspyHeading3">
            Day 3
            <div class="vertical_line"></div>
            2024.08.25
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

          <hr>

          <%--  day3   --%>
          <div class="journal_place">
            <div  class="circle_container">
              <div class="circle">1</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day3_place1">마농 치킨 중앙 통닭 본점</div>
              <p class="place_info">음식점 * 서귀포</p>
            </div>
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>

          <div class="journal_place">

            <div  class="circle_container">
              <div class="circle">2</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day_3place2">원앙 폭포</div>
              <p class="place_info">관광명소 * 서귀포</p>
            </div>
            <!-- 모달을 실행할 버튼 -->
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>

          </div>

          <div class="journal_place">
            <div  class="circle_container">
              <div class="circle">3</div>
              <div class="long_vertical_line"></div>
            </div>
            <div class="place_div">
              <div class="place_name" id="day3_place3">호텔 브릿지 서귀포</div>
              <p class="place_info">숙소 * 서귀포</p>
            </div>
            <button type="button" class="modal_button" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <img src="/www/edit_button.png" class="edit_button" alt="수정 버튼">
            </button>
          </div>
        </div>
    </div>
  </div>

</article>
<script>
  function changeColor(button) {
    // 모든 버튼에서 active 클래스를 제거
    var buttons = document.querySelectorAll('.day_button');
    buttons.forEach(function(btn) {
      btn.classList.remove('active');
    });

    // 클릭한 버튼에 active 클래스 추가
    button.classList.add('active');
  }

</script>
<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>
