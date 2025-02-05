<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
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
          font-size: 20px;
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

      #editNicknameBtn {
          width: 20px;
          height: 20px;
      }


  </style>
</head>
<body>
<header>
  <a href="${pageContext.request.contextPath}/Controller"><img src="${pageContext.request.contextPath}/www/logo.png"
                                                               class="logo" alt="로고"></a>
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
            <a href="${pageContext.request.contextPath}/jsp/updateProfile.jsp">
              <img src="${pageContext.request.contextPath}/www/seeting_img.jpg" alt="프로필수정" id="editNicknameBtn"
                   style="cursor:pointer;"></a>
          </div>
        </div>
      </c:when>

      <%-- 세션에 닉네임이나 사용자 정보가 없을 경우 'Guest' 출력 --%>
      <c:otherwise>
        <div class="nickname">Guest 님!</div>
      </c:otherwise>


    </c:choose>
  </div>

  <div class="nav">
    <a href="#">나의 여행</a>
    <a href="#">여행 후기</a>
    <a href="#">내가 쓴 리뷰</a>
  </div>
  <div class="new-trip">새 여행 만들기 +</div>
  <div class="trip-container">
    <div class="trip-img">
      <p class="rank">1</p>
      <img src="" alt="여행지사진">
    </div>
    <div class="trip-info">
      <strong>여행 이름 / 후기 이름</strong><br>
      여행 기간: 2.26 - 2.28<br>
      지역: 부산
    </div>
    <div class="menu" onclick="toggleMenu(this)">• • •
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
      <strong>여행 이름</strong><br>
      여행 기간: 12.6 - 12.8<br>
      지역: 도쿄
    </div>
    <div class="menu" onclick="popup-menu">• • •
      <div class="popup-menu">
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
  document.addEventListener("DOMContentLoaded", function () {


    // 인라인 편집 관련 요소 선택
    const nicknameDisplay = document.getElementById('nicknameDisplay');
    const nicknameEdit = document.getElementById('nicknameEdit');
    const nicknameText = document.getElementById('nicknameText');
    const nicknameInput = document.getElementById('nicknameInput');

    const editNicknameBtn = document.getElementById('editNicknameBtn');

    const cancelNicknameBtn = document.getElementById('cancelNicknameBtn');

    // '수정' 버튼 클릭 시 편집 영역으로 전환
    editNicknameBtn.addEventListener('click', function () {
      nicknameEdit.style.display = 'inline-flex';
      nicknameInput.focus();
    });

    // '취소' 버튼 클릭 시 원래 영역으로 복귀
    cancelNicknameBtn.addEventListener('click', function () {
      nicknameEdit.style.display = 'none';
      nicknameDisplay.style.display = 'inline-flex';
      // 입력값을 원래 값으로 복원 (님! 제거)
      nicknameInput.value = nicknameText.textContent.replace(" 님!", "");
    });

    // '저장' 버튼 클릭 시 AJAX로 변경 내용 전송
    saveNicknameBtn.addEventListener('click', function () {
      const newNickname = nicknameInput.value.trim();
      if (newNickname === "") {
        alert("닉네임을 입력하세요.");
        nicknameInput.focus();
        return;
      }

      // AJAX 요청: updateProfileAction.jsp (Java Action)로 POST 전송
      fetch('${pageContext.request.contextPath}/updateProfileAction.jsp', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'nickname=' + encodeURIComponent(newNickname)
      })
          .then(response => response.text())
          .then(result => {
            if (result.trim() === "success") {
              alert("프로필이 성공적으로 업데이트되었습니다.");
              // 헤더 닉네임 업데이트
              nicknameText.textContent = newNickname + " 님!";
              nicknameEdit.style.display = 'none';
              nicknameDisplay.style.display = 'inline-flex';
            } else {
              alert("프로필 업데이트에 실패하였습니다.");
            }
          })
          .catch(error => {
            console.error("업데이트 오류:", error);
            alert("프로필 업데이트 중 오류가 발생하였습니다.");
          });
    });
  });

  // 메뉴 토글 함수
  function toggleMenu(menuElement) {
    // 모든 다른 메뉴 닫기
    document.querySelectorAll(".popup-menu").forEach(menu => {
      if (menu !== menuElement.querySelector(".popup-menu")) {
        menu.style.display = "none";
      }
    });

    let popupMenu = menuElement.querySelector(".popup-menu");
    let shareMenu = menuElement.querySelector(".share-menu");

    // 현재 클릭한 메뉴만 토글
    if (popupMenu.style.display === "block") {
      popupMenu.style.display = "none";
      shareMenu.style.display = "none"; // 공유하기 메뉴도 닫기
    } else {
      popupMenu.style.display = "block";
    }
  }

  // 공유 메뉴 토글 함수
  function toggleShareMenu(shareElement) {
    let shareMenu = shareElement.closest(".menu").querySelector(".share-menu");

    // 모든 공유하기 메뉴 닫기
    document.querySelectorAll(".share-menu").forEach(menu => {
      if (menu !== shareMenu) menu.style.display = "none";
    });

    // 현재 클릭한 공유하기 메뉴만 토글
    shareMenu.style.display = (shareMenu.style.display === "block") ? "none" : "block";
  }

  function shareKakao() {
    alert("카카오톡 공유 기능이 구현될 예정입니다.");
  }

  function copyLink() {
    const dummy = document.createElement("textarea");
    dummy.value = window.location.href;
    document.body.appendChild(dummy);
    dummy.select();
    document.execCommand("copy");
    document.body.removeChild(dummy);
    alert("링크가 복사되었습니다!");
  }

  // 화면의 다른 곳을 클릭하면 모든 메뉴 닫기
  document.addEventListener("click", function (event) {
    let isClickInsideMenu = event.target.closest(".menu");
    if (!isClickInsideMenu) {
      document.querySelectorAll(".popup-menu, .share-menu").forEach(menu => {
        menu.style.display = "none";
      });
    }
  });

  // 모든 메뉴 요소에 이벤트 바인딩
  document.querySelectorAll(".menu").forEach(menu => {
    menu.addEventListener("click", function (event) {
      event.stopPropagation(); // 이벤트 버블링 방지
      toggleMenu(this);
    });
  });

  // 공유하기 메뉴 항목에 이벤트 바인딩
  document.querySelectorAll(".popup-menu ul li").forEach(item => {
    if (item.textContent.includes("공유하기")) {
      item.addEventListener("click", function (event) {
        event.stopPropagation(); // 이벤트 버블링 방지
        toggleShareMenu(this);
      });
    }
  });
</script>
</html>