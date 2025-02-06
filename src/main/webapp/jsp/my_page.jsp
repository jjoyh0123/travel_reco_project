<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
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


      .new_trip {
          background-color: #ff7f50;
          color: white;
          padding: 15px;
          text-align: center;
          font-size: 20px;
          cursor: pointer;
          border-radius: 10px;
      }

      .trip_container {
          position: relative;
          background: white;
          border-radius: 10px;
          box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
          display: grid;
          grid-template-columns: 1fr 2fr 0.03fr;
          align-items: center;
          font-size: 22px;
      }


      .trip_img {
          border-right: 1px solid #ccc; /* 회색 선 추가 */
          text-align: center;
      }

      .trip_img img {
          width: 100%;
          height: 100%;
          object-fit: cover;
          display: block;
          border-top-left-radius: 10px;
          border-bottom-left-radius: 10px;
      }


      .trip_info {
          text-align: center;
      }

      .new_trip a{
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
      .popup_menu {
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

      .popup_menu ul {
          list-style: none;
          padding: 0;
          margin: 0;
      }

      .popup_menu ul li {
          padding: 8px 15px;
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

      .share_menu ul {
          list-style: none;
          padding: 0;
          margin: 0;
      }

      .share_menu ul li {
          padding: 8px 15px;
          cursor: pointer;
      }

      .share_menu ul li:hover {
          background-color: #f0f0f0;
      }

      .share_option {
          display: flex;
          align-items: center;
          color: black;
          padding: 10px;
          gap: 12px;
          cursor: pointer;
          border-radius: 8px;
          transition: background-color 0.3s ease;
      }

      .share_option img {
          width: 30px;
          height: 30px;
      }

      .share_option:hover {
          background-color: #f0f0f0;
      }


      .nickname img {
          width: 20px;
          height: 20px;
      }


      .nickname_area {
          display: inline-flex;
          align-items: center;
          gap: 8px;
      }

      #nickname_display span {
          font-size: inherit;
          color: #fff;
      }

      #nickname_display button {
          padding: 4px 8px;
          font-size: 14px;
          cursor: pointer;
          color: #fff;
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
        <div class="nickname_area">

          <div id="nickname_display">
            <span id="nickname_text">${sessionScope.nick} 님!</span>
            <a href="${pageContext.request.contextPath}/jsp/updateProfile.jsp" class="profile_link ">
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
    <!-- 세션에 저장된 type 값을 활용해 링크 설정 -->
    <a href="${pageContext.request.contextPath}/Controller?type=my_trip_plan">나의 여행</a>
    <a href="${pageContext.request.contextPath}/Controller?type=my_trip_review">여행 후기</a>
    <a href="${pageContext.request.contextPath}/Controller?type=my_review_history">내가 쓴 리뷰</a>
  </div>



  <div class="new_trip"><a href="">새 여행 만들기 +</a>
  </div>

  <div class="trip_container">
    <div class="trip_img">
      <p class="rank">1</p>
      <img src="" alt="여행지사진">
    </div>
    <div class="trip_info">
      <strong>여행 이름 / 후기 이름</strong><br>
      여행 기간: 2.26 - 2.28<br>
      지역: 부산
    </div>
    <div class="menu" onclick="toggleMenu(this)">• • •
      <div class="popup_menu">
        <ul>
          <li onclick="toggleShareMenu(this)">공유하기</li>
          <li>후기작성</li>
          <li class="delete">삭제</li>
        </ul>
      </div>
      <div class="share_menu">
        <strong>공유하기</strong>
        <div class="share_option" onclick="shareKakao()">
          <img src="${pageContext.request.contextPath}/www/kakaoGo_img.png" alt="카카오톡 공유">카카오톡으로 링크보내기
        </div>
        <div class="share_option" onclick="copyLink()">
          <img src="${pageContext.request.contextPath}/www/linkGo_img.png" alt="링크복사">링크 복사하기
        </div>
      </div>
    </div>
  </div>
  <div class="trip_container">
    <div class="trip_img">
      <p class="rank">2</p>
      <img src="" alt="여행지사진">
    </div>
    <div class="trip_info">
      <strong>여행 이름</strong><br>
      여행 기간: 12.6 - 12.8<br>
      지역: 도쿄
    </div>
    <div class="menu" onclick="toggleMenu(this)">• • •
      <div class="popup_menu">
        <ul>
          <li onclick="toggleShareMenu(this)">공유하기</li>
          <li>후기작성</li>
          <li class="delete">삭제</li>
        </ul>
      </div>
    </div>
  </div>
</div>
</body>

<script>
  // 메뉴 토글 기능
  function toggleMenu(menuElement) {
    const popupMenu = menuElement.querySelector(".popup_menu");

    // 다른 열린 메뉴들은 닫기
    document.querySelectorAll(".popup_menu").forEach(menu => {
      if (menu !== popupMenu) {
        menu.style.display = "none";
      }
    });

    // 현재 메뉴의 display 상태 토글
    popupMenu.style.display = popupMenu.style.display === "block" ? "none" : "block";
  }

  // 공유 메뉴 토글 기능
  function toggleShareMenu(shareElement) {
    const shareMenu = shareElement.closest(".menu").querySelector(".share_menu");

    // 다른 열린 공유 메뉴 닫기
    document.querySelectorAll(".share_menu").forEach(menu => {
      if (menu !== shareMenu) {
        menu.style.display = "none";
      }
    });

    // 현재 공유 메뉴 display 상태 토글
    shareMenu.style.display = shareMenu.style.display === "block" ? "none" : "block";
  }

  // 카카오톡 공유 기능 예시
  function shareKakao() {
    alert("카카오톡 공유 기능이 호출되었습니다!");
    // 실제 카카오톡 API 연동 필요
  }

  // 링크 복사 기능 예시
  function copyLink() {
    const linkToCopy = "https://example.com/my-trip";  // 복사할 링크 예시
    navigator.clipboard.writeText(linkToCopy).then(() => {
      alert("링크가 복사되었습니다!");
    }).catch(() => {
      alert("링크 복사에 실패했습니다.");
    });
  }

  // 페이지 외부 클릭 시 메뉴 닫기 기능
  document.addEventListener("click", function (event) {
    const isMenuClick = event.target.closest(".menu");
    if (!isMenuClick) {
      document.querySelectorAll(".popup_menu, .share_menu").forEach(menu => {
        menu.style.display = "none";
      });
    }
  });
</script>


</html>