<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이메일로 로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

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
          display: flex;
          justify-content: center;
          align-items: center;
      }

      .login-container {
          background-color: #fff;
          border-radius: 8px;
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
          width: 400px;
          padding: 30px;
          text-align: center;
      }

      .login-container h1 {
          font-size: 24px;
          margin-bottom: 20px;
          font-weight: bold;
      }

      .login-container form {
          display: flex;
          flex-direction: column;
          gap: 15px;
      }

      .login-container input[type="email"],
      .login-container input[type="password"] {
          width: 100%;
          padding: 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-size: 14px;
          box-sizing: border-box;
          color: black;
      }

      .login-container button {
          background-color: #ff7f50;
          color: white;
          border: none;
          padding: 12px;
          border-radius: 4px;
          font-size: 16px;
          cursor: pointer;
      }

      .login-container button:hover {
          background-color: #ff7f50;
      }

      .login-container .links {
          margin-top: 10px;
          display: flex;
          justify-content: space-between;
          font-size: 14px;
          color: #888;
      }

      .login-container .links a {
          text-decoration: none;
          color: #555;
      }

      .login-container .links a:hover {
          text-decoration: underline;
      }
  </style>
</head>

<body>
<jsp:include page="/jsp/header.jsp"/>
<article class="content">

<!-- 오류 메시지 스크립트 -->
<%
  String errorMessage = (String) request.getAttribute("errorMessage");
%>
<script>
  <% if (errorMessage != null) { %>
  alert("<%= errorMessage %>");
  <% } %>
</script>

<!-- 로그인 컨테이너 -->
<div class="login-container">
  <h1>이메일로 로그인</h1>
  <form action="${pageContext.request.contextPath}/Controller?type=email_login" method="post">
    <input type="email" name="email" placeholder="이메일 주소" required>
    <input type="password" name="pw" placeholder="비밀번호" required>
    <button type="submit">로그인</button>
  </form>

  <!-- 오류 메시지 표시 -->
  <c:if test="${not empty error && error != null}">
    <p style="color: red; font-size: 14px;">${error}</p>
  </c:if>

  <div class="links">
    <a href="${pageContext.request.contextPath}/Controller?type=login">로그인 화면가기</a>
    <a href="${pageContext.request.contextPath}/Controller?type=sign_up">회원가입</a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</article>
</body>
</html>
