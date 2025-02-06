<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<head>
  <meta charset="UTF-8">
  <title>여행 후기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <style>
      body {
          font-family: Arial, sans-serif;
          margin: 0;
          padding: 0;
          background-color: #f9f9f9;
          display: flex;
          justify-content: center;
          align-items: flex-start;
          min-height: 100vh;
          flex-direction: column;
      }

      .container {
          display: grid;
          grid-template-columns: 1fr;
          gap: 20px;
          width: 90%;
          max-width: 1000px;
          /* background: white; */
          padding: 0;
          border-radius: 15px;
          /* box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); */
          margin: 100px auto;
      }

      .header {
          background-color: #ff7f50;
          color: white;
          padding: 20px;
          display: flex;
          align-items: center;
          justify-content: space-between;
          font-size: 22px;
          font-weight: bold;
          border-radius: 10px;
      }

      .logo {
          height: 50px;
          position: absolute;
          top: 20px;
          left: 20px;
      }

      .nav {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          text-align: center;
          padding: 15px;
          background: white;
          font-size: 20px;
          border-radius: 10px;
      }

      .nav a {
          text-decoration: none;
          color: black;
      }

      .nav a:hover{
          color: #ff7f50;
          text-decoration: none;
      }

      .nav a:nth-child(2),
      .nav a:nth-child(3) {
          border-left: 1px solid #999;
          padding-left: 20px;
      }


      .new-trip {
          background-color: #ff7f50;
          color: white;
          padding: 15px;
          text-align: center;
          font-size: 20px;
          cursor: pointer;
          border-radius: 10px;
      }

      .trip-container {
          position: relative;
          background: white;
          border-radius: 10px;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
          display: grid;
          grid-template-columns: 1fr 2fr 0.03fr;
          align-items: center;
          font-size: 22px;
      }


      .trip-img {
          border-right: 1px solid #ccc; /* 회색 선 추가 */
          text-align: center;
      }

      .trip-img img {
          width: 100%;
          height: 100%;
          object-fit: cover;
          display: block;
          border-top-left-radius: 10px;
          border-bottom-left-radius: 10px;
      }


      .trip-info {
          text-align: center;
      }

      .new-trip a{
          color: #ffff;
          text-decoration: none;
      }

      .menu {
          cursor: pointer;
          font-size: 5px;
          /*text-align: center;*/
      }

      .rank {
          position: absolute;
          z-index: 1;
          color: white;
          margin: 0;
          font-size: 2em;
          font-style: italic;
          text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.8);
      }

      .menu {
          position: absolute;
          top: 10px;
          right: 15px;
          font-size: 15px;
          cursor: pointer;
      }

      /* 팝업 */
      /* 팝업 메뉴 기본적으로 숨김 */
      .popup-menu {
          display: none;
          position: absolute;
          top: 25px;
          right: 0;
          width: 150px;
          background: white;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
          border-radius: 10px;
          padding: 10px;
          z-index: 10;
      }

      .popup-menu ul {
          list-style: none;
          padding: 0;
          margin: 0;
      }

      .popup-menu ul li {
          padding: 8px 15px;
          cursor: pointer;
          font-size: 16px;
      }

      .popup-menu ul li:hover {
          background-color: #f0f0f0;
      }

      .popup-menu ul li.delete {
          color: red;
          font-weight: bold;
      }

      .share-menu {
          font-size: 11px;
          color: darkgray;
          display: none;
          position: absolute;
          width: 200px;
          background: white;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
          border-radius: 10px;
          padding: 10px;
          z-index: 10;
          margin-top: 10px;
      }

      .share-menu ul {
          list-style: none;
          padding: 0;
          margin: 0;
      }

      .share-menu ul li {
          padding: 8px 15px;
          cursor: pointer;
      }

      .share-menu ul li:hover {
          background-color: #f0f0f0;
      }

      .share-option {
          display: flex;
          align-items: center;
          color: black;
          padding: 10px;
          gap: 12px;
          cursor: pointer;
          border-radius: 8px;
          transition: background-color 0.3s ease;
      }

      .share-option img {
          width: 30px;
          height: 30px;
      }

      .share-option:hover {
          background-color: #f0f0f0;
      }


      .nickname img {
          width: 20px;
          height: 20px;
      }


      .nickname-area {
          display: inline-flex;
          align-items: center;
          gap: 8px;
      }

      #nicknameDisplay span {
          font-size: inherit;
          color: #fff; /* 헤더 배경색과 조화되도록 설정 (필요에 따라 조정) */
      }

      #nicknameDisplay button,
      #nicknameEdit button {
          padding: 4px 8px;
          font-size: 14px;
          cursor: pointer;
      }


      .bi-gear-fill {
          color: #ffffff;
      }

      .profile_link {
          display: inline-flex;
          align-items: center;
          gap: 4px;
          color: white;
          text-decoration: none;
          font-size: 15px;
      }

      .profile_text {
          color: #ffffff;
          opacity: 0.8;
      }


  </style>
</head>
<body>
<header>
  <a href="${pageContext.request.contextPath}/Controller"><img src="${pageContext.request.contextPath}/www/logo.png" class="logo" alt="로고"></a>
</header>
<div class="container">
  <!-- 닉네임 표시 조건 추가 -->
  <div class="header">
    <c:choose>
      <%-- 세션에 닉네임이 있을 경우 닉네임 출력 --%>
      <c:when test="${not empty sessionScope.nick}">
        <div class="nickname-area">

          <div id="nicknameDisplay">
            <span id="nicknameText">${sessionScope.nick} 님!</span>
            <a href="${pageContext.request.contextPath}/jsp/updateProfile.jsp" class="profile_link">
              <i class="bi bi-gear-fill"></i><span class="profile_text">프로필 관리</span></a>
          </div>
        </div>
      </c:when>

      <%-- 세션에 닉네임이나 사용자 정보가 없을 경우 'Guest' 라는 이름을 출력 --%>
      <c:otherwise>
        <div class="nickname">Guest 님!</div>
      </c:otherwise>


    </c:choose>
  </div>

  <div class="nav">
    <a href="${pageContext.request.contextPath}/jsp/my_trip_plan.jsp">나의 여행</a>
    <a href="${pageContext.request.contextPath}/jsp/my_trip_review.jsp">여행 후기</a>
    <a href="${pageContext.request.contextPath}/jsp/my_review_history.jsp">내가 쓴 리뷰</a>
  </div>
  <div class="new-trip"><a href="">새 여행 만들기 +</a>
  </div>
  <div class="trip-container">
    <div class="trip-img">
      <p class="rank">1</p>
      <img src="" alt="여행지사진">
    </div>
    <div class="trip-info">
      <strong>여행 후기</strong><br>
    </div>
<%--    <div class="menu" onclick="toggleMenu(this)">• • •
      <div class="popup-menu">
        <ul>
          <li onclick="toggleShareMenu(this)">공유하기</li>
          <li>후기작성</li>
          <li class="delete">삭제</li>
        </ul>
      </div>
      <div class="share-menu">
        <strong>공유하기</strong>
        <div class="share-option" onclick="shareKakao()">
          <img src="${pageContext.request.contextPath}/www/kakaoGo_img.png" alt="카카오톡 공유">카카오톡으로 링크보내기
        </div>
        <div class="share-option" onclick="copyLink()">
          <img src="${pageContext.request.contextPath}/www/linkGo_img.png" alt="링크복사">링크 복사하기
        </div>
      </div>
    </div>
  </div>
  <div class="trip-container">
    <div class="trip-img">
      <p class="rank">2</p>
      <img src="" alt="여행지사진">
    </div>
    <div class="trip-info">
      <strong>여행 후기</strong><br>

    </div>
    <div class="menu" onclick="toggleMenu(this)">• • •
      <div class="popup-menu">
        <ul>
          <li onclick="toggleShareMenu(this)">공유하기</li>
          <li>후기작성</li>
          <li class="delete">삭제</li>
        </ul>
      </div>
    </div>--%>
  </div>
</div>
</body>
<script>

</script>
</html>