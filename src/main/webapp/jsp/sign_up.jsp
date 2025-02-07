<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
      body {
          background-color: #f7f8fa;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
          margin: 0;
      }

      .signup-container {
          background-color: #fff;
          border-radius: 8px;
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
          width: 400px;
          padding: 30px;
      }

      .signup-container h1 {
          font-size: 24px;
          margin-bottom: 20px;
          font-weight: bold;
          text-align: center;
      }

      .btn-orange {
          background-color: #ff7f50;
          color: white;
      }

      .btn-orange:hover {
          background-color: #ff7f50;
      }

      .form-check-label {
          font-size: 14px;
      }

  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<%
  String errorMessage = (String) request.getAttribute("errorMessage");
  String signupSuccess = (String) request.getAttribute("signupSuccess");
%>

<script>
  <% if (errorMessage != null) { %>
  alert("<%= errorMessage %>");
  <% } %>

  <% if ("true".equals(signupSuccess)) { %>
  alert("회원가입이 성공적으로 완료되었습니다!");
  window.location.href = "jsp/index.jsp";  // 가입 후 메인 페이지로 이동
  <% } %>
</script>


<div class="signup-container">
  <h1>이메일로 회원가입</h1>
  <form action="${pageContext.request.contextPath}/Controller?type=sign_up" method="post">
    <div class="mb-3">
      <label for="email" class="form-label">이메일 주소</label>
      <div class="input-group">
        <input type="email" class="form-control" id="email" name="email" placeholder="이메일 주소" required>
        <button type="button" class="btn btn-orange" onclick="checkEmail()">중복확인</button>
      </div>
      <!-- 이메일 중복 확인 후 메시지 출력 -->
      <p id="emailMessage" class="message"></p>
    </div>

    <div class="mb-3">
      <label for="nickname" class="form-label">닉네임</label>
      <div class="input-group">
        <input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임" required>
        <button type="button" class="btn btn-orange" onclick="checkNick()">중복확인</button>
      </div>
      <p id="nicknameMessage" class="message"></p>
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
      <p id="passwordMessage" class="message"></p>
    </div>
    <div class="mb-3 form-check">
      <input type="checkbox" class="form-check-input" id="showPassword" onclick="togglePassword()">
      <label class="form-check-label" for="showPassword">비밀번호 보기</label>
    </div>
    <button type="submit" id="signupButton" class="btn btn-orange w-100" disabled>회원가입</button>
  </form>
  <div class="mt-3 text-center">
    <a href="emailLogin.jsp" class="text-decoration-none">이메일 로그인 화면가기</a>
  </div>
</div>
<script>
  let emailChecked = false;
  let nicknameChecked = false;
  let passwordValid = false;

  function togglePassword() {
    const passwordField = document.getElementById("password");
    passwordField.type = passwordField.type === "password" ? "text" : "password";
  }

  // 이메일 중복확인
  function checkEmail() {
    const email = document.getElementById("email").value;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
      alert("올바른 이메일 주소를 입력해주세요.");
      return;
    }

    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/Controller?type=checkEmail",
      data: { email: email },
      dataType: "json",
      success: function (response) {
        const emailMessage = document.getElementById("emailMessage");
        if (response.status === "success") {
          emailChecked = true;
          emailMessage.textContent = "사용 가능한 이메일입니다.";
          emailMessage.style.color = "blue";
        } else {
          emailChecked = false;
          emailMessage.textContent = "이미 사용 중인 이메일입니다.";
          emailMessage.style.color = "red";
        }
        updateSignupButtonState();
      },
      error: function () {
        alert("서버 오류가 발생했습니다.");
      }
    });
  }

  // 닉네임 중복확인
  function checkNick() {
    const nickname = document.getElementById("nickname").value;
    const koreanNumberRegex = /^[가-힣]+$/;

    if (!nickname) {
      alert("닉네임을 입력해주세요.");
      return;
    }

    if (!koreanNumberRegex.test(nickname)) {
      alert("닉네임은 한글만 입력 가능합니다.");
      return;
    }


    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/Controller?type=checkNick",
      data: { nickname: nickname },
      dataType: "json",
      success: function (response) {
        const nicknameMessage = document.getElementById("nicknameMessage");
        if (response.status === "success") {
          nicknameChecked = true;
          nicknameMessage.textContent = "사용 가능한 닉네임입니다.";
          nicknameMessage.style.color = "blue";
        } else {
          nicknameChecked = false;
          nicknameMessage.textContent = "이미 사용 중인 닉네임입니다.";
          nicknameMessage.style.color = "red";
        }
        updateSignupButtonState();
      },
      error: function () {
        alert("서버 오류가 발생했습니다.");
      }
    });
  }

  // 비밀번호 유효성 검사 (4자리 이상)
  document.getElementById("password").addEventListener("input", function () {
    const password = this.value;
    const passwordMessage = document.getElementById("passwordMessage");

    if (password.length > 4) {
      passwordValid = true;
      passwordMessage.textContent = "";
    } else {
      passwordValid = false;
      passwordMessage.textContent = "비밀번호는 4자리 이상이어야 합니다.";
      passwordMessage.style.color = "red";
    }

    updateSignupButtonState();
  });

  // 회원가입 버튼 활성화 상태 업데이트
  function updateSignupButtonState() {
    const signupButton = document.getElementById("signupButton");
    if (emailChecked && nicknameChecked && passwordValid) {
      signupButton.disabled = false;
    } else {
      signupButton.disabled = true;
    }
  }
</script>
</body>
</html>
