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
          margin: 40px 0;
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
      }

       #notice_img .carousel-inner img {
           width: 100%; /* 부모 요소의 너비를 기준으로 맞춤 */
           max-width: 600px; /* 최대 너비 설정 */
           height: auto; /* 비율 유지 */
           margin: 0 auto; /* 가운데 정렬 */
       }

       #notice_board{
           margin-bottom: 70px;
       }

       .accordion-body{
           background-color: white;
       }
       #FAQ{
           margin-bottom: 70px;
       }

      /* 아코디언 버튼 클릭 시 파란색 변경을 방지 */
      .accordion-button:focus {
          box-shadow: none;  /* 클릭 후 파란색 그림자 없애기 */
      }

      /* 아코디언 버튼 활성화 시 배경색 변경 방지 */
      .accordion-button:not(.collapsed) {
          background-color: #f8f9fa;  /* 기본 배경색 설정 */
      }



  </style>

  <title>고객지원</title>

</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
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
<%--      <img src="/www/myro1.png" alt="예제 이미지">--%>
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
    <c:forEach var="noticeVO" items="${noticeVO}" varStatus="index">
      <div class="accordion-item">
        <h2 class="accordion-header" id="panelsStayOpen-heading${index.index}">
          <button class="accordion-button" type="button" data-bs-toggle="collapse"
                  data-bs-target="#panelsStayOpen-collapse${index.index}" aria-expanded="${index.index == 0 ? 'true' : 'false'}"
                  aria-controls="panelsStayOpen-collapse${index.index}">
              ${noticeVO.title}
          </button>
        </h2>
        <div id="panelsStayOpen-collapse${index.index}" class="accordion-collapse collapse ${index.index == 0 ? 'show' : ''}"
             aria-labelledby="panelsStayOpen-heading${index.index}">
          <div class="accordion-body">
              ${noticeVO.content}
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

<%--  공지사항 아코디언 끝 --%>
</div>
<%--공지사항 끝--%>

<%--자주 묻는 질문--%>
<div id="FAQ">
  <h3>자주 묻는 질문 (FAQ)</h3>
  <hr>

  <%--  FAQ 아코디언 --%>

  <div class="accordion" id="accordionPanelsStayOpenExample">
    <c:forEach var="faqVO" items="${faqVO}" varStatus="index">
      <div class="accordion-item">
        <h2 class="accordion-header" id="panelsStayOpen-heading-${index.index}">
          <button class="accordion-button" type="button" data-bs-toggle="collapse"
                  data-bs-target="#panelsStayOpen-collapse-${index.index}" aria-expanded="-${index.index == 0 ? 'true' : 'false'}"
                  aria-controls="panelsStayOpen-collapse-${index.index}">
              ${faqVO.title}
          </button>
        </h2>
        <div id="panelsStayOpen-collapse-${index.index}" class="accordion-collapse collapse ${index.index == 0 ? 'show' : ''}"
             aria-labelledby="panelsStayOpen-heading-${index.index}">
          <div class="accordion-body">
              ${faqVO.content}
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

</div><%--  자주 묻는 질문 FAQ 끝--%>



</article>
<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>
