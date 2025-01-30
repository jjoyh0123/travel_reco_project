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
  alert("회원가입이 성공적으로 완료되었습니다! 로그인화면으로 이동됩니다.");
  window.location.href = "jsp/login.jsp";  // 가입 후 메인 페이지로 이동
  <% } %>
</script>


<div class="signup-container">
  <h1>이메일로 회원가입</h1>
  <form action="/TeamProject2_war_exploded/Controller?type=signup" method="post">
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
    </div>
    <div class="mb-3 form-check">
      <input type="checkbox" class="form-check-input" id="showPassword" onclick="togglePassword()">
      <label class="form-check-label" for="showPassword">비밀번호 보기</label>
    </div>
    <button type="submit" class="btn btn-orange w-100">회원가입</button>
  </form>
  <div class="mt-3 text-center">
    <a href="emailLogin.jsp" class="text-decoration-none">로그인 화면가기</a>
  </div>
</div>
<script>
  // 비밀번호 보기 토글
  function togglePassword() {
    const passwordField = document.getElementById("password");
    passwordField.type = passwordField.type === "password" ? "text" : "password";
  }

  // 이메일 중복 확인
  function checkEmail() {
    const email = document.getElementById("email").value;

    if (!email) {
      alert("이메일을 입력해주세요.");
      return;
    }

    $.ajax({
      type: "POST",
      url: "/TeamProject2_war_exploded/Controller?type=checkEmail",  // Action 매핑 URL
      data: { email: email },
      dataType: "json",
      success: function(response) {
        const emailMessage = document.getElementById("emailMessage");
        emailMessage.textContent = response.message;

        // 메시지 색상 설정
        if (response.status === "success") {
          emailMessage.className = "message success";
          emailMessage.style.color = "blue";
        } else {
          emailMessage.className = "message error";
          emailMessage.style.color = "red";
        }
      },
      error: function() {
        alert("서버 오류가 발생했습니다.");
      }
    });
  }

  // 닉네임 중복확인
  function checkNick() {
    const nickname = document.getElementById("nickname").value;

    if (!nickname) {
      alert("닉네임을 입력해주세요.");
      return;
    }

    $.ajax({
      type: "POST",
      url: "/TeamProject2_war_exploded/Controller?type=checkNick",  // Action 매핑 URL
      data: { nickname: nickname },
      dataType: "json",
      success: function(response) {
        const emailMessage = document.getElementById("nicknameMessage");
        nicknameMessage.textContent = response.message;

        // 메시지 색상 설정
        if (response.status === "success") {
          emailMessage.className = "message success";
          emailMessage.style.color = "blue";
        } else {
          emailMessage.className = "message error";
          emailMessage.style.color = "red";
        }
      },
      error: function() {
        alert("서버 오류가 발생했습니다.");
      }
    });
  }
</script>
</body>
</html>

