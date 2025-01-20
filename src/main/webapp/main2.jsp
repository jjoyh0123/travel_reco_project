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
          background-color: #F5F5F7;
      }
      .content{
          width: 900px;
          min-height: 600px;
          flex-grow: 1;
          margin-bottom: 20px;
      }
      #box {
          height:auto;
          margin: 10px 0 50px 0;
          text-align: center;
          padding: 20px;
          display: flex;
          flex-direction: row; /* 수평 정렬 */
          gap: 20px;
      }
      .box{
          background-color: white;
      }
      #title{
          margin: 40px 0px;
      }
      h1, h2, h3{
          font-weight: bold;
      }
      #introduction_content_img {
          display: flex;
          flex-direction: column; /* 세로 정렬 */
          justify-content: flex-start; /* 세로로 위에서 아래로 정렬 */
          align-items: flex-start; /* 왼쪽 정렬 */
      }
      #introduction_content {
          text-align: left;
      }
      #introduction_img img{
          height: auto;
          margin: 10px 0 50px 0;
          width: 100%; /* div 너비에 맞춤 */
          height: auto; /* 비율 유지 */
          border-radius: 10px; /* 모서리 둥글게 */
      }
      .notice_title a {
          color: black;
          /*text-decoration: none;*/
      }
      /*.notice_title a:hover{*/
      /*    color: coral;*/
      /*}*/
      .notice_title{
          font-size: 16px;
          margin: 8px 0;
      }
      .notice_title:hover{
          background-color: #bbbbbb;
      }
       #notice_img .carousel-inner img {
           width: 100%; /* 부모 요소의 너비를 기준으로 맞춤 */
           max-width: 600px; /* 최대 너비 설정 */
           height: auto; /* 비율 유지 */
           margin: 0 auto; /* 가운데 정렬 */
       }
       #notice_img{
           margin-top: 20px;
           background-color: black;
       }
       #notice_board{
           margin-bottom: 70px;
       }
       .accordion_img{
           width: 100%; /* 부모 요소의 너비를 기준으로 맞춤 */
           height: auto; /* 비율 유지 */
           margin: 0 auto; /* 가운데 정렬 */
       }
       .accordion-body{
           background-color: #F5F5F7;
       }
       #FAQ{
           margin-bottom: 70px;
       }
       #usage{
           margin-bottom: 70px;
       }

  </style>

  <title>고객지원</title>

</head>
<body>
<jsp:include page="header.jsp"/>
<article class="content">
<%--  여기서 코딩 --%>
  <div id="title">
    <h1>Zenzen Club 고객 지원</h1>
  </div>
  <div id="introduction_title">
    <h3>Zenzen Club 기업 소개</h3>
  </div>
  <hr>
  <div id="box" class="box">
    <div id="introduction_content_img">💡</div>
    <div id="introduction_content">
      Zenzen Club은 여행자들이 보다 편하고 정확하게 일정을 만들 수 있도록 </br>
      사용자들이 여행계획을 공유하고 받아올 수 있는 기능을 서비스하는 스타트업입니다. </br></br>
      여행을 준비하는 과정은 매우 복잡하고 많은 시간이 소요되지만 </br>
      우리가 가지고 있는 기술력과 수많은 데이터 분석 등의 고도화를 통하여 </br>
      여행의 시작부터 끝까지 여행자들과 함께 하고자 합니다. </br></br>
      Zenzen Club은 성공을 위해 서로 솔직한 피드백을 주고받을 수 있는 문화, </br>
      모두가 공유하고 인지하는 목표를 하나씩 달성해나가는 문화를 함께 만들어가고 있습니다.
    </div>
  </div>

  <div id="introduction_img">
      <img src="/www/myro1.png" alt="예제 이미지">
  </div>


<%--공지사항--%>
<div id="notice_board">
  <h3 id="notice">공지사항</h3>
  <hr>
<%--  for each문(items)으로 p태그 여러개 만들기 (이모지는 img로 따로 저장해서 불러오기) --%>
<%--  공지사항에서 게시물수 몇개 보여줄지 생각하기 > 가장 최신 게시물 5개만 보여주기--%>
<%--  status를 0으로 설정해서 보여줄건 0 오래된건 1로 해서 해보기 --%>

<%--  공지사항 아코디언 --%>
  <div class="accordion" id="accordionPanelsStayOpenExample">
<%--    아코디언 1--%>
    <div class="accordion-item">
      <h2 class="accordion-header" id="panelsStayOpen-headingOne">
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
<%--          📢 2024.04.12 업데이트 안내--%>
          <c:forEach var="vd" items="${ar}">

            ${vo.title}
          </c:forEach>
        </button>
      </h2>
      <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
        <div class="accordion-body">
          아코디언 펼쳤을 떄 나오는 내용
        </div>
      </div>
    </div>

<%--    아코디언 2--%>
    <div class="accordion-item">
      <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
          Accordion Item #2
        </button>
      </h2>
      <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
        <div class="accordion-body">
          <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
      </div>
    </div>

<%--  아코디언 3--%>
    <div class="accordion-item">
      <h2 class="accordion-header" id="panelsStayOpen-headingThree">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
          Accordion Item #3
        </button>
      </h2>
      <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
        <div class="accordion-body">
          <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
      </div>
    </div>

  </div>
<%--  공지사항 아코디언 끝 --%>
</div>
<%--공지사항 끝--%>

<%--자주 묻는 질문--%>
<div id="FAQ">
  <h3>자주 묻는 질문 (FAQ)</h3>
  <hr>
<%--  아코디언 FAQ --%>
  <div class="accordion" id="accordionPanelsStayOpenExample-">
<%--    아코디언 1 --%>
    <div class="accordion-item">
      <h2 class="accordion-header" id="panelsStayOpen-headingOne1">
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne1" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne1">
          Accordion Item #1
        </button>
      </h2>
      <div id="panelsStayOpen-collapseOne1" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne1">
        <div class="accordion-body">
          <strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
      </div>
    </div>

<%--  아코디언 2--%>
    <div class="accordion-item">
      <h2 class="accordion-header" id="panelsStayOpen-headingTwo2">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo2" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo2">
          Accordion Item #2
        </button>
      </h2>
      <div id="panelsStayOpen-collapseTwo2" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo2">
        <div class="accordion-body">
          <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
      </div>
    </div>

<%--  아코디언 3--%>
    <div class="accordion-item">
      <h2 class="accordion-header" id="panelsStayOpen-headingThree3">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree3" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree3">
          Accordion Item #3
        </button>
      </h2>
      <div id="panelsStayOpen-collapseThree3" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree3">
        <div class="accordion-body">
          <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
        </div>
      </div>
    </div>

  </div>
<%--  아코디언 끝 --%>

</div>
<%--  자주 묻는 질문 FAQ 끝--%>

<%--  홈페이지 이용방법(시연 영상)--%>
<div id="usage">
  <h3>Zenzen Club 이용방법</h3>
  <hr>
  <div>
    (시연 영상)
  </div>
</div>

<%--  홈페이지 보도 자료--%>
<div id="press_releases">
  <h3>Zenzen Club 보도자료</h3>
  <hr>
  <P> 관련 기사</P>
  <p> 관련 영상</p>
</div>

<%--  홈페이지 파트너 사--%>
<div id="partner_company">
  <h3>Zenzen Club 파트너사</h3>
  <hr>
  (파트너 사 정보나 이미지 넣을 곳)
</div>
<hr>

</article>
<jsp:include page="footer.jsp"/>
</body>
</html>
