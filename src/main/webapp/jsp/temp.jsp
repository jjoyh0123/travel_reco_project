<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <title>Title</title>
  <style>
      body {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0;
      }

      #top_plan {
          font-weight: bold;
          border: 1px solid coral;
          background-color: coral;
          width: 350px;
          border-radius: 5px;
          margin-bottom: 40px;
          text-align: center;
          margin-left: 440px;
      }

      #top_plan > a {
          font-size: 25px;
          color: white;
          text-decoration: none;
      }

      .top3_plan {
          margin-top: -20px;
          display: flex;
          gap: 20px; /* 이미지들 간 간격을 주기 위한 설정 */
      }

      .top3_review {
          background: #f8f9fa;
          border-radius: 5px;
      }

      .heart-icon {
          font-size: 15px;
          opacity: 0.2; /* 기본 상태는 투명 */
          cursor: pointer;
          transition: opacity 0.3s, color 0.3s;
          margin-left: 270px;
          border-style: none;
      }

      .top3_img > a {
          list-style: none;
          text-decoration: none;
          display: flex;
          width: 35px;
      }

      .hit {
          height: 30px;
          text-align: right;
          padding-right: 15px;
      }

      .hit > a {
          text-decoration: none;
      }

      .nickname {
          display: flex;
          justify-content: flex-end;
          text-decoration: none;
          color: black;
          font-weight: bold;
      }

      .event_banner {
          border: 1px solid lightgray;
          height: 200px;
          width: 1200px;
          text-align: center;
          margin-top: 100px;
          margin-left: 20px;
      }

      .travel_review {
          display: flex;
          margin-top: -30px;
          gap: 20px; /* 이미지들 간 간격을 주기 위한 설정 */
      }

      .review_item {
          width: 100%;
          background: #f8f9fa;
          border-radius: 5px;
      }

      .review_title {
          font-weight: bold;
          font-size: 20px;
          text-decoration: none; /* 링크 밑줄 제거 */
          text-align: left;
          color: black;
      }

      .review_content {
          font-size: 15px;
          text-decoration: none; /* 링크 밑줄 제거 */
          color: gray;
          margin-left: 5px;
      }

      .review_img {
          border: 1px solid lightgray;
          width: 400px;
          height: 350px;
          border-radius: 25px;
          margin-bottom: 30px;
          margin-top: 40px;
          overflow: hidden; /* 부모 div 를 벗어나는 부분 숨김 */
          position: relative; /* 자식 요소 배치 */

          /* 자식 요소를 세로 정렬 */
          display: flex;
          flex-wrap: wrap; /* 자동 줄바꿈 */
          align-items: center; /* 중앙 정렬 */
          justify-content: center; /* 가로 중앙 정렬 */
      }

      .image-indicators {
          width: 100%;
          height: 10px;
          display: flex;
          justify-content: center;
          margin-top: 10px;
      }

      .indicator {
          width: 10px;
          height: 10px;
          margin: 0 5px;
          background-color: gray;
          border-radius: 50%;
          cursor: pointer;
          transition: transform 0.2s, background-color 0.2s;
      }

      /* 현재 활성화된 아이콘 스타일 */
      .indicator.active {
          transform: scale(1.5); /* 크기 확대 */
          background-color: black; /* 활성화된 상태 */
      }

      .review_img > div {
          flex: 1 1 auto; /* 공간을 균등하게 분배 */
          text-align: center; /* 내용 중앙 정렬 */
      }

      .review_banner {
          font-weight: bold;
          margin-top: 30px;
          border: 1px solid coral;
          background-color: coral;
          width: 350px;
          border-radius: 5px;
          margin-bottom: 10px;
          text-align: center;
          margin-left: 440px;
      }

      .review_banner > a {
          font-size: 25px;
          color: white;
          text-decoration: none;
      }

      #review_total_button {
          height: 30px;
          text-align: right;
          display: flex;
          justify-content: flex-end;
          width: 1250px;
      }

      #review_total_button button {
          border: none; /* 테두리 제거 */
          outline: none; /* 외곽선 제거 */
          color: gray;
      }

      .top3_img img {
          width: 100%;
          height: 100%;
          object-fit: contain;
      }

      .board_review {
          margin: 15px;
      }

      .board_plan {
          margin-top: 10px;
          display: flex;
          width: 1300px;
          height: 1300px;
          border-radius: 15px;
          flex-wrap: wrap; /* 아이템들이 자동으로 줄바꿈되도록 */
      }

      .board_item {
          display: flex;
          flex-direction: column;
          text-align: left;
          list-style: none; /* 점 제거 */
          padding: 0;
          width: 400px;
          background: #f8f9fa;
          border-radius: 5px;
      }

      .board_total_content {
          height: auto;
          width: auto;
          display: flex;
      }

      .board_content {
          font-size: 15px;
          text-decoration: none; /* 링크 밑줄 제거 */
          color: black;

      }

      .board_title {
          display: flex;
          font-weight: bold;
          font-size: 20px;
          text-decoration: none; /* 링크 밑줄 제거 */
          text-align: left;
          color: black;
      }

      .board_img {
          border: 1px solid lightgray;
          width: 140px;
          height: 140px;
          background-color: white;
          border-radius: 25px;
          margin-bottom: 10px;
          margin-right: 10px;

      }

      .board_img > img {
          object-fit: cover;
          width: 140px;
          height: 150px;
      }

      .board_img > a {
          list-style: none;
          text-decoration: none;
          display: flex;
          width: 35px;
      }

      .loc_name {
          display: flex;
          text-decoration: none;
          color: grey;
      }

      #hot_place {
          margin-top: 30px;
          border: 1px solid coral;
          background-color: coral;
          width: 350px;
          border-radius: 5px;
          margin-bottom: 40px;
          text-align: center;
          margin-left: 440px;
      }

      #hot_place > a {
          font-size: 25px;
          text-decoration: none;
          color: white;
          font-weight: bold;
      }

      #local_total_button {
          display: flex;
          justify-content: flex-end;
          height: 30px;
          text-align: right;
      }

      #local_total_button button {
          border: none; /* 테두리 제거 */
          outline: none; /* 외곽선 제거 */
          color: gray;
      }

      .event_img {
          width: 1200px;
          height: 200px;
      }

      .review {
          display: flex;
          flex-wrap: wrap;
          gap: 10px; /* 아이템 간의 간격 설정 */
          width: 1250px;
          margin-left: 16px;
          justify-content: space-between;
      }

      .travel_review {
          width: calc(33.33% - 10px); /* 한 줄에 3개씩 배치 */
          box-sizing: border-box;
          margin-bottom: 20px; /* 세로 간격 */
          display: flex;
          flex-direction: column;
          align-items: center;
      }

      .hidden {
          display: none; /* 해당 요소 숨기기 */
      }

      .top3_img > img {
          width: 100%;
          height: 100%;
          object-fit: cover;
      }

      .api_title {
          width: 230px;
      }

      .api_addr1 > a {
          text-align: center;
      }

      .journal_lh {
          justify-content: flex-end;
          display: flex;
      }

      .journal_file_path {
          width: 300px;
          height: 300px;
      }

      .image-slider img {
          object-fit: cover;
          flex-shrink: 0;
      }

      .image_option {
          height: 100%
      }

  </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<input type="hidden" id="user_idx" name="user_idx" value="${sessionScope.user_idx}">
<article class="content">
  <table class="table">
    <div class="head">
      <div id="top_plan">
        <a href="">Top 3Plan</a>
      </div>
    </div>
    <div class="tbody">
      <div class="top3_plan">
        <c:forEach var="top3" items="${top3}" varStatus="status">
          <div class="top3_review">
            <div class="review_item">
              <div class="review_img">
                <c:choose>
                  <c:when test="${not empty top3.list}">
                    <c:forEach var="image" items="${top3.list}" varStatus="loop">
                      <c:if test="${loop.index < 5}"> <%-- 5개까지만 표시 --%>
                        <div class="image_option" data-image="${image.file_path}" data-index="${loop.index}"></div>
                      </c:if>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <img src="" class="journal_file_path" alt="기본 이미지">
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="image-indicators">
                <c:if test="${not empty top3.list}">
                  <c:forEach var="image" items="${top3.list}" varStatus="loop">
                    <c:if test="${loop.index < 5}"> <%-- 인디케이터도 5개까지만 --%>
                      <div class="indicator ${loop.index == 0 ? 'active' : ''}" data-index="${loop.index}"></div>
                    </c:if>
                  </c:forEach>
                </c:if>
              </div>
              <div class="journal_lh">
                <div class="like">
                  <button type="button" class="heart-icon" data-journalidx="${top3.idx}" onclick="toggleHeart(this)">
                    ❤️
                  </button>
                </div>
                <div class="hit">
                  <a href="">${top3.hit}</a>
                </div>
              </div>
              <a href="" class="review_title">${top3.title}</a>
              <div>
                <a href="" class="review_content">${top3.subtitle}</a>
                <a href="" class="nickname">${top3.nick}</a>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>


      <div class="event_banner">
        <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner event_img">
            <c:forEach var="event" items="${eventImage}">
              <c:if test="${not empty event.file_path}">
                <div class="carousel-item active">
                  <img src="${applicationScope.publicIP}:4000/${event.file_path}" class="d-block w-100"
                       alt="${event.file_path}">
                </div>
              </c:if>
            </c:forEach>

          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying"
                  data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying"
                  data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
      <div class="review_banner">
        <a href="">여행 후기</a>
      </div>
      <div id="review_total_button">
        <button type="button" onclick="review_total()">전체보기</button>
      </div>
      <div class="review">
        <c:forEach var="journal" items="${journal}">
          <div class="travel_review">
            <div class="review_item">
              <div class="review_img">
                <c:choose>
                  <c:when test="${not empty journal.list}">
                    <c:forEach var="image" items="${journal.list}" varStatus="loop">
                      <c:if test="${loop.index < 5}"> <%-- 5개까지만 표시 --%>
                        <div class="image_option" data-image="${image.file_path}" data-index="${loop.index}"></div>
                      </c:if>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <img src="" class="journal_file_path" alt="기본 이미지">
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="image-indicators">
                <c:if test="${not empty journal.list}">
                  <c:forEach var="image" items="${journal.list}" varStatus="loop">
                    <c:if test="${loop.index < 5}"> <%-- 인디케이터도 5개까지만 --%>
                      <div class="indicator ${loop.index == 0 ? 'active' : ''}" data-index="${loop.index}"></div>
                    </c:if>
                  </c:forEach>
                </c:if>
              </div>
              <div class="journal_lh">
                <div class="like">
                  <button type="button" class="heart-icon" data-journalidx="${journal.idx}" onclick="toggleHeart(this)">
                    ❤️
                  </button>
                </div>
                <div class="hit">
                  <a href="">${journal.hit}</a>
                </div>
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
    </div>
    <div id="hot_place">
      <a href="">hot place</a>
    </div>
    <div id="local_total_button">
      <button type="button" onclick="window.location.href='Controller?type=local'">지역전체보기</button>
    </div>
    <div class="board_plan">
      <c:forEach var="api" items="${requestScope.ar}">
        <div class="board_review" id="board_review">
          <div class="board_item">
            <div class="board_total_content">
              <div class="board_img">
                <img src="${api.firstimage2}" alt="thumbnail">
              </div>
              <div>
                <button type="button" class="btn transparent-btn" data-bs-toggle="modal"
                        data-bs-target="#staticBackdrop">
                  <br/>
                </button>
                <div class="api_title">
                  <a href="" class="board_title">${api.title}</a>
                </div>
                <p></p>
                <div class="api_addr1">
                  <a href="" class="board_content">${api.addr1}</a>
                </div>
                <a href="" class="loc_name"></a>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </table>
</article>
<jsp:include page="footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>

  $(document).ready(function () {
    // 공통적으로 첫 번째 이미지 설정
    $(".review_img").each(function () {
      let firstImage = $(this).find(".image_option").first().data("image");
      if (firstImage) {
        $(this).css("background-image", 'url(' + firstImage + ')');
      }
    });

    // Hover 시 이미지 변경 및 indicator 업데이트
    $(".image_option").hover(function () {
      let newImageUrl = $(this).data("image");
      let index = $(this).attr("data-index");

      // 현재 속한 부모 컨테이너 찾기 (top3_review 또는 travel_review)
      let $container = $(this).closest(".top3_review, .travel_review");

      // 배경 이미지 변경
      $container.find(".review_img").css("background-image", 'url(' + newImageUrl + ')');

      // 모든 인디케이터에서 active 제거 후 현재 것만 추가
      $container.find(".indicator").removeClass("active");
      $container.find(".indicator[data-index='" + index + "']").addClass("active");
    });
  });


  function review_total() {
    window.location.href = "jsp/journal_review.jsp";
  }

  function toggleHeart(button) {
    const journalidx = button.getAttribute('data-journalidx');  // 버튼에서 journalidx 값 가져오기
    const user_idx = $('#user_idx').val();
    $.ajax({
      url: '/Controller?type=like',
      type: 'POST',
      data: {
        journalidx: journalidx,
        user_idx: user_idx
      },
      success: function (response) {
        console.log("AJAX Response:", response);  // 응답 디버깅

        if (response.success) {
          if (response.newStatus === 1) {
            button.style.opacity = '1';
            button.style.color = 'red';  // 좋아요 활성화
          } else {
            button.style.opacity = '0.2';
            button.style.color = '';  // 좋아요 비활성화
          }
        } else {
          alert('처리 중 오류가 발생했습니다.');
        }
      },
      error: function (xhr, status, error) {
        console.error('AJAX 요청 오류:', status, error);
        alert('서버 요청에 실패했습니다.');
      }
    });
  }

</script>
</body>
</html>