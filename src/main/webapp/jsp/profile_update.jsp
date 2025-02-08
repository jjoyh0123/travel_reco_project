<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>프로필관리</title>

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

  <style>
      .container {
          display: grid;
          grid-template-columns: 1fr;
          gap: 20px;
          width: 90%;
          max-width: 1000px;
          padding: 0;
          border-radius: 15px;
          margin: 100px auto 50px auto;
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

      .profile-form {
          display: flex;
          flex-direction: column;
          align-items: center;
          width: 90%;
          max-width: 1000px;
          margin: 50px auto;
          padding: 20px;
          border-radius: 10px;

      }

      .form-group {
          width: 100%;
          margin-bottom: 20px;
      }

      .form-group label {
          font-weight: bold;
          margin-bottom: 5px;
          display: inline-block;
      }

      .form-group input {
          width: 100%;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 5px;
          box-sizing: border-box;
      }

      .button-group button {
          font-size: 16px;
          font-weight: bold;
          border-radius: 5px;
          border: none;
          cursor: pointer;

      }

      .btn-outline-danger {
          width: 513.63px; /* 원하는 너비로 조정 */
          height: 40px; /* 원하는 높이로 조정 */
          background: #ced4da;
          color: #fff;
          border: 1px solid #6c757d;

      }

      .btn-outline-danger:hover {
          background-color: #adb5bd;
          color: white;
          border: none;
      }

      .btn-secondary {
          width: 250px;
          height: 40px;
          background-color: #ced4da;
          color: white;


      }

      #deleteAccountButton {
          border: none;
      }

      .btn-secondary:hover {
          background-color: #adb5bd;
      }

      .save_btn {
          width: 250px;
          height: 40px;
          background-color: #ced4da;
          color: white;
      }

      .save_btn:hover {
          background-color: #ff7f50;
      }
  </style>

</head>

<body>
<header>
  <jsp:include page="/jsp/header.jsp"/>
</header>

<div class="container">
  <!-- 닉네임 표시 조건 추가 -->
  <div class="header">
    <c:choose>
      <!-- 세션에 닉네임이 있을 경우 닉네임 출력 -->
      <c:when test="${not empty sessionScope.nick}">
        <div class="nickname-area">
          <div id="nicknameDisplay">
            <span id="nicknameText">${sessionScope.nick} 님!</span>
          </div>
        </div>
      </c:when>
    </c:choose>
  </div>
</div>

<div class="profile-form">
    <h1 class="text-center mb-4">프로필 설정</h1>

  <!-- 프로필 수정 폼에 ID 추가 -->
  <form id="updateProfile" action="${pageContext.request.contextPath}/Controller?type=profile_update" method="post">
    <div class="form-group">
      <label for="email">이메일 주소</label>
      <input type="text" id="email" name="email" value="${sessionScope.email}" disabled>
    </div>
    <div class="form-group">
      <label for="nickname">닉네임</label>
      <input type="text" id="nickname" name="nickname" value="${sessionScope.nick}" required>
      <div id="nickname-message" class="error-message text-danger mt-1" style="display:none;"></div>
    </div>
    <div class="form-group">
      <label for="password">패스워드 변경</label>
      <input type="password" id="password" name="password" value="${sessionScope.password}" required>
    </div>
    <div class="form-group">
      <label for="passwordConfirm">패스워드 변경 확인</label>
      <input type="password" id="passwordConfirm" name="password_check" value="${sessionScope.password}" required>
      <div id="password-message" class="error-message text-danger mt-1" style="display:none;"></div>
    </div>

    <!-- 버튼 그룹 -->
    <div class="button-group mt-4">
      <button type="button" class="btn btn-secondary" onclick="window.history.back();">취소</button>
      <button type="submit" class="save_btn">저장</button>
    </div>
  </form>

  <!-- 회원탈퇴 버튼 -->
  <button type="button" class="btn btn-outline-danger mt-4" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
    회원탈퇴
  </button>

  <!-- 회원탈퇴 확인 모달 -->
  <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">회원탈퇴 확인</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p>정말로 회원탈퇴를 진행하시겠습니까?</p>
          <div class="form-group">
            <label for="deletePassword">비밀번호 입력</label>
            <input type="password" id="deletePassword" class="form-control" placeholder="비밀번호를 입력하세요" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-danger" onclick="submitDeleteForm();">탈퇴하기</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 회원탈퇴 폼 -->
  <form id="deleteAccountForm" action="${pageContext.request.contextPath}/Controller?type=userDelete" method="post" style="display:none;">
    <input type="hidden" id="passwordField" name="password">
  </form>

  <script>
    let isNicknameValid = false;
    let isPasswordValid = false;

    // 닉네임 검증 함수
    function validateNickname() {
      const nickname = document.getElementById("nickname").value;
      const nicknameMessage = document.getElementById("nickname-message");

      const nicknameRegex = /^[가-힣]+$/;

      if (nickname.length < 3) {
        nicknameMessage.textContent = "닉네임은 최소 3글자 이상이어야 합니다.";
        nicknameMessage.style.display = "block";
        nicknameMessage.style.color = "red";
        isNicknameValid = false;
        return false;
      }

      if (!nicknameRegex.test(nickname)) {
        nicknameMessage.textContent = "닉네임은 한글만 입력 가능합니다.";
        nicknameMessage.style.display = "block";
        nicknameMessage.style.color = "red";
        isNicknameValid = false;
        return false;
      }

      nicknameMessage.style.display = "none";
      isNicknameValid = true;
      return true;
    }

    // 비밀번호 검증 함수
    function validatePassword() {
      const password = document.getElementById("password").value;
      const passwordConfirm = document.getElementById("passwordConfirm").value;
      const passwordMessage = document.getElementById("password-message");

      if (password.length < 4) {
        passwordMessage.textContent = "패스워드는 4자리 이상이어야 합니다.";
        passwordMessage.style.display = "block";
        passwordMessage.style.color = "red";
        isPasswordValid = false;
        return false;
      }

      if (password !== passwordConfirm) {
        passwordMessage.textContent = "패스워드가 일치하지 않습니다.";
        passwordMessage.style.display = "block";
        passwordMessage.style.color = "red";
        isPasswordValid = false;
        return false;
      }

      passwordMessage.style.display = "none";
      isPasswordValid = true;
      return true;
    }

    // 회원탈퇴 폼 제출 함수
    function submitDeleteForm() {
      const password = document.getElementById("deletePassword").value;

      if (!password) {
        alert("비밀번호를 입력하세요.");
        return;
      }

      document.getElementById("passwordField").value = password;
      document.getElementById("deleteAccountForm").submit();
    }

    // 프로필 수정 폼 유효성 검사
    document.getElementById("updateProfile").addEventListener("submit", function (event) {
      validateNickname();
      validatePassword();

      if (!isNicknameValid || !isPasswordValid) {
        event.preventDefault();
        alert("입력 정보를 확인해주세요.");
      }
    });

    // 실시간 검증 이벤트 등록
    document.getElementById("nickname").addEventListener("input", validateNickname);
    document.getElementById("password").addEventListener("input", validatePassword);
    document.getElementById("passwordConfirm").addEventListener("input", validatePassword);
  </script>

</body>
</html>
