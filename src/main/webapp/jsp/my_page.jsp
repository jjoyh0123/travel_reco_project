<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <style>


      body {

          font-family: Arial, sans-serif;
          background-color: #f9f9f9;
          padding: 20px;
          min-height: 100vh;
      }

      .header {
          background-color: #ff7f50;
          color: white;
          padding: 15px 20px;
          font-size: 22px;
          font-weight: bold;
          border-radius: 8px;
          display: flex;
          justify-content: space-between;
          align-items: center;
          max-width: 900px;
          margin: 0 auto;
      }

      .logo {
          height: 50px;
          margin-bottom: 20px;
      }

      .nav {
          background: white;
          padding: 10px;
          border-radius: 8px;
          display: flex;
          justify-content: space-around;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
          max-width: 900px;
          margin: 0 auto 20px;
      }

      .nav a {
          text-decoration: none;
          color: black;
          font-weight: bold;
      }

      .nav a:hover {
          color: #ff7f50;
      }

      .new_trip {
          background-color: #ff7f50;
          color: white;
          text-align: center;
          padding: 12px;
          font-size: 18px;
          border-radius: 8px;
          margin: 10px auto 20px;
          max-width: 900px;
      }

      .trip_container {
          border: 1px solid #ddd;
          border-radius: 8px;
          padding: 15px;
          background: white;
          margin-bottom: 15px;
          display: flex;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
          max-width: 900px;
          margin: 0 auto 20px;
      }

      .trip_img img {
          width: 100%;
          height: auto;
          border-radius: 8px;
      }

      .menu {
          position: relative;
      }

      .popup_menu {
          display: none;
          position: absolute;
          top: 30px;
          right: 0;
          background: white;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
          border-radius: 8px;
          padding: 10px;
          z-index: 10;
      }

      .popup_menu ul {
          padding: 0;
          margin: 0;
          list-style: none;
      }

      .popup_menu ul li {
          padding: 10px;
          cursor: pointer;
          font-size: 16px;
      }

      .popup_menu ul li:hover {
          background-color: #f0f0f0;
      }

      .popup_menu ul li.delete {
          color: red;
          font-weight: bold;
      }

      .share_menu {
          display: none;
          position: absolute;
          top: 40px;
          right: 0;
          width: 200px;
          background: white;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
          border-radius: 8px;
          padding: 10px;
          z-index: 10;
      }
  </style>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>


<div class="container px-3">

  <!-- 닉네임 표시 -->
  <div class="header mb-3">
    <c:choose>
      <c:when test="${not empty sessionScope.nick}">
        <div>${sessionScope.nick} 님!</div>
        <a href="${pageContext.request.contextPath}/Controller?type=profile_update" class="btn btn-light">
          <i class="bi bi-gear-fill"></i> 프로필 관리
        </a>
      </c:when>
      <c:otherwise>
        <div>Guest 님!</div>
      <a href="${pageContext.request.contextPath}/Controller?type=profile_update" class="btn btn-light">
        <i class="bi bi-gear-fill"></i> 프로필 관리
      </c:otherwise>
    </c:choose>
  </div>

  <!-- 네비게이션 -->
  <nav class="nav mb-3">
    <a href="${pageContext.request.contextPath}/Controller?type=my_trip_plan">나의 여행</a>
    <a href="${pageContext.request.contextPath}/Controller?type=my_trip_review">여행 후기</a>
    <a href="${pageContext.request.contextPath}/Controller?type=my_review_history">내가 쓴 리뷰</a>
  </nav>

  <!-- 새 여행 만들기 -->
  <div class="new_trip">새 여행 만들기 +</div>

  <!-- 컨텐츠 출력 -->
  <div class="content-section">
    <c:choose>
      <c:when test="${param.type == 'my_trip_plan'}">
        <h3 class="mb-3 text-center">나의 여행 목록</h3>
        <c:forEach var="trip" items="${myTrips}">
          <div class="trip_container">
            <div class="trip_img col-3">
              <img src="" alt="여행지사진">
            </div>
            <div class="trip_info col-7">
              <strong>여행 이름: ${trip.nick}</strong><br>
              이메일: ${trip.email}<br>
              여행 기간: 2.26 - 2.28<br>
              지역: 부산
            </div>
            <div class="menu col-2 text-end">
              <button class="btn btn-light" onclick="toggleMenu(this)">• • •</button>
              <div class="popup_menu">
                <ul>
                  <li onclick="toggleShareMenu(this)">공유하기</li>
                  <li>후기작성</li>
                  <li class="delete" onclick="deleteContainer(this)">삭제</li>
                </ul>
              </div>
              <div class="share_menu">
                <strong>공유하기</strong>
                <div class="mb-2">카카오톡 공유 기능</div>
                <div>링크 복사하기</div>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:when>
    </c:choose>
  </div>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function toggleMenu(menuElement) {
    const popupMenu = menuElement.nextElementSibling;
    document.querySelectorAll(".popup_menu").forEach(menu => {
      if (menu !== popupMenu) menu.style.display = "none";
    });
    popupMenu.style.display = popupMenu.style.display === "block" ? "none" : "block";
  }

  function toggleShareMenu(shareElement) {
    const shareMenu = shareElement.closest(".menu").querySelector(".share_menu");
    document.querySelectorAll(".share_menu").forEach(menu => {
      if (menu !== shareMenu) menu.style.display = "none";
    });
    shareMenu.style.display = shareMenu.style.display === "block" ? "none" : "block";
  }

  function deleteContainer(deleteElement) {
    const tripContainer = deleteElement.closest(".trip_container");
    if (tripContainer) tripContainer.remove();
  }

  document.addEventListener("click", function (event) {
    if (!event.target.closest(".menu")) {
      document.querySelectorAll(".popup_menu, .share_menu").forEach(menu => menu.style.display = "none");
    }
  });
</script>
</body>
</html>
