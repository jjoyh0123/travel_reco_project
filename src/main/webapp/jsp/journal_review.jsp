<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <style>
      body {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0;
          justify-content: center;
      }
      #body {
          position: absolute;
          display: flex;
          flex-direction: row; /* 수평 방향으로 배치 */
          justify-content: flex-start;
          align-items: flex-start;
          gap: 20px; /* 간격 추가 */
          width: 450px;
          height: 750px;
          margin-top: 37px;
      }

      #board_banner {
          background-color: coral;
          border: 1px solid coral;
          margin-bottom: 10px;
          width: 700px;
          text-align: center;
          border-radius: 5px;
          margin-left: 130px;
      }

      #board_banner>a {
          font-size: 25px;
          color: white;
          text-decoration: none;
      }

      .board_search {
          width: 500px;
          margin-left: 210px;
      }

      .search_type {
          margin-top: 20px;
          text-align: right;
          border: none;
          background-color: black;
          color: white;
          font-weight: bold;
          margin-left: -3px;
      }

      .loc {
          display: flex;
          width: 450px;
          height: 700px;
          flex-direction: column;
          margin-right: -250px;
      }

      .loc_icon {
          display: flex;
          justify-content: center;
          align-items: center;
          width: 150px;
          height: 150px;
          border: 1px solid lightgray;
          border-radius: 8px;
      }

      .loc_row {
          display: flex;
      }

      .loc_icon > a {
          display: block;
          text-decoration: none;
          width: 100%;
          height: 100%;
          color: black;
      }

      .span {
          margin-top: 15px;
          display: block;
          text-align: center;
          width: 100%;
      }
      .review {
          position: relative;
          display: flex;
          flex-wrap: wrap; /* 아이템들이 자동으로 줄바꿈되도록 */
          gap: 5px; /* 아이템 간의 간격 설정 */
          width: 805px;
          right: -500px;
          background: #f8f9fa;
      }

      .travel_review {
          flex-basis: calc(33.33% - 5px); /* 각 아이템의 너비 설정, 간격을 고려한 계산 */
          /*box-sizing: border-box; /* padding과 margin 포함한 크기 설정 */

      }

      .review_img > img {
          width: 100%;
          height: 100%;
          object-fit: cover;
      }

      .review_img {
          width: 100%;
          height: 100%;
      }

      .review_img {
          border: 1px solid lightgray;
          width: 400px;
          height: 350px;
          background-color: white;
          border-radius: 25px;
          margin-bottom: 30px;
          margin-top: 40px;
      }

      #img_1 {
          width: 100px;
          height: 100px;
          background-image: url("${pageContext.request.contextPath}/www/1.png");
          background-repeat: no-repeat;
          background-position: center;
          background-size: 100px 100px;
          border-radius: 50%;
          margin-left: 25px;
          margin-top: 5px;
      }

      #img_2, #img_3, #img_4, #img_5, #img_6, #img_7, #img_8, #img_9,
      #img_10, #img_11, #img_12, #img_13, #img_14, #img_15, #img_16,
      #img_17, #img_18 {
          width: 100px;
          height: 100px;
          background-image: url("${pageContext.request.contextPath}/www/icon_area.png");
          margin-left: 25px;
          margin-top: 5px;
          overflow: hidden;
      }

      #img_2 { background-position: 0px -0px; }
      #img_3 { background-position: 0px -100px; }
      #img_4 { background-position: 0px -200px; }
      #img_5 { background-position: 0px -300px; }
      #img_6 { background-position: 0px -400px; }
      #img_7 { background-position: 0px -500px; }
      #img_8 { background-position: 0px -600px; }
      #img_9 { background-position: 0px -700px; }
      #img_10 { background-position: 0px -800px; }
      #img_11 { background-position: 0px -900px; }
      #img_12 { background-position: 0px -1000px; }
      #img_13 { background-position: 0px -1100px; }
      #img_14 { background-position: 0px -1200px; }
      #img_15 { background-position: 0px -1300px; }
      #img_16 { background-position: 0px -1400px; }
      #img_17 { background-position: 0px -1500px; }
      #img_18 { background-position: 0px -1600px; }
      .span{
          margin-top: 15px;
          display: block;
          text-align: center; /* 글자가 가운데 정렬되도록 */
          width: 100%; /* span 요소가 loc_icon의 전체 너비를 차지하도록 */
      }
      .heart-icon{
          font-size: 15px;
          opacity: 0.2; /* 기본 상태는 투명 */
          cursor: pointer;
          transition: opacity 0.3s, color 0.3s;
          margin-left: 270px;
          border-style: none;
      }
      .top3_img> a{
          list-style: none;
          text-decoration: none;
          display: flex;
          width: 35px;
      }
      .hit{
          height: 30px;
          text-align: right;
          padding-right: 15px;
      }
      .hit>a{
          text-decoration: none;
      }
      .nickname{
          display: flex;
          justify-content: flex-end;
          text-decoration: none;
          color: black;
          font-weight: bold;
      }
      .review_content{
          font-size: 15px;
          text-decoration: none; /* 링크 밑줄 제거 */
          color: gray;
          margin-left: 5px;
      }
      .review_title{
          font-weight: bold;
          font-size: 20px;
          text-decoration: none; /* 링크 밑줄 제거 */
          text-align: left;
          color: black;
      }
      .content{

      }
      /* 기타 이미지 스타일들... */
      .option_button>a>span{
          border: 1px solid #555555;
          background: #bbbbbb;
          width: 60px;
      }
      .option_button>a{
          text-decoration: none;
      }
      #option_button{
          display: flex;
          margin-right: 6px;
          justify-content: flex-end;
      }

  </style>
  <script>
    function toggleHeart(button) {
      // 하트 버튼을 클릭했을 때 상태를 변경
      if (button.style.opacity === '1') {
        button.style.opacity = '0.2';
        button.style.color = '';
      } else {
        button.style.opacity = '1';
        button.style.color = 'red';
      }
    }
  </script>
  <title>Title</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<article class="content">
  <thead>
  <div id="board_banner">
    <a href="">여행 후기 게시판</a>
  </div>
  </thead>
  <div>
    <input type="search" class="board_search" placeholder="검색(제목으로 검색)">
    <img src="" alt="🔍">
    <div id="option_button">
      <select class="option_button">
        <option class="search_type">::선택::</option>
        <option class="search_type" data-contentTypeId="">::좋아요::</option>
        <option class="search_type" data-contentTypeId="12">::조회수::</option>
      </select>
    </div>
  </div>
  <div id="body">
    <div class="loc">
      <div class="loc_row">
        <div class="loc_icon"><a href=""><div id="img_1"></div><span class="span">전국</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_2"></div><span class="span">서울</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_3"></div><span class="span">인천</span></a></div>
      </div>
      <div class="loc_row">
        <div class="loc_icon"><a href=""><div id="img_4"></div><span class="span">대전</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_5"></div><span class="span">대구</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_6"></div><span class="span">광주</span></a></div>
      </div>
      <div class="loc_row">
        <div class="loc_icon"><a href=""><div id="img_7"></div><span class="span">부산</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_8"></div><span class="span">울산</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_9"></div><span class="span">경기</span></a></div>
      </div>
      <div class="loc_row">
        <div class="loc_icon"><a href=""><div id="img_10"></div><span class="span">강원</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_11"></div><span class="span">충북</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_12"></div><span class="span">충남</span></a></div>
      </div>
      <div class="loc_row">
        <div class="loc_icon"><a href=""><div id="img_13"></div><span class="span">경북</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_14"></div><span class="span">경남</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_15"></div><span class="span">전북</span></a></div>
      </div>
      <div class="loc_row">
        <div class="loc_icon"><a href=""><div id="img_16"></div><span class="span">전남</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_17"></div><span class="span">제주</span></a></div>
        <div class="loc_icon"><a href=""><div id="img_18"></div><span class="span">세종</span></a></div>
      </div>
    </div>
  </div>


  <div class="review">
    <c:forEach var="journal" items="${journal}">
      <div class="travel_review">
        <div class="review_item">
          <div class="review_img">
            <img src="${journal.file_path}" class="journal_file_path">
          </div>
          <div class="hit">
            <button type="button" class="heart-icon" onclick="toggleHeart(this)">❤️</button>
            <a href="">${journal.hit}</a>
          </div>
          <a href="" class="review_title">${journal.title}</a>
          <div>
            <a href="" class="review_content">${journal.subtitle}</a>
            <a href="" class="nickname">${journal.nick}</a>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

</article>
<jsp:include page="footer.jsp"/>
</body>
</html>
