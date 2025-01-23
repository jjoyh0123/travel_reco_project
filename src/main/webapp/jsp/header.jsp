<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // session.setAttribute("userId", "temporaryUserId");
%>
<html>
<head>
  <style>
      body {
          display: flex;
          justify-content: center;
          margin: 0;
      }

      header {
          display: flex;
          width: 80%;
          justify-content: space-between;
          align-items: center;
          padding-top: 10px;
      }

      .header-left-section {
          display: flex;
          align-items: center;
      }

      .header-left-section img {
          height: 50px;
      }

      .header-left-section h3 {
          margin-left: 10px;
          color: #ff7f50;
      }

      .header-right-section {
          display: flex;
          align-items: center;
          gap:10px;

      }

      .header-right-section a {
          margin-right: 20px;
      }

      .header-right-section a:last-child {
          margin-right: 0;
      }

      .profile {
          background-image: none; /*프로필 사진*/
          padding: 0;
      }

      .btn.btn-outline-secondary{
          border-radius:20px;
      }

      .header-right-section .btn-outline-secondary{
          all : unset;
          border-radius: 0;
          font-weight: bold;
          cursor: pointer;
          padding: 0;
      }

      .header-right-section .btn-outline-secondary:hover{
          color:#ff7f50;
          background-color: transparent;
      }

      .dropdown img {
          width: 30px;
          height: 30px;
      }


      .btn.btn-outline-secondary.login-btn{
          border-radius: 20px;
          background-color: #ff7f50;
          color: #ffffff;
          text-decoration: none;
          padding: 10px;
      }

      .header-right-section a {
          text-decoration: none;
      }

  </style>
</head>
<body>
<header>
  <div class="header-left-section">
    <a href="index.jsp"><img src="../www/logo.png" alt="로고"></a>&nbsp;&nbsp;
    <h3>Zenzen Club</h3><%--이미지로 변경 필요--%>
  </div>
  <div class="header-right-section">
    <button class="btn btn-outline-secondary" onclick="location.href='Controller?type=customer_service'">고객지원</button>
    <c:choose>
      <c:when test="${not empty sessionScope.userId}"><%-- 유저가 로그인 했는지 검증하는 부분 --%>
        <div class="dropdown">
          <button class="btn rounded-circle p-2 profile" type="button" data-bs-toggle="dropdown"
                  aria-expanded="false" style="border: none;">
            <img src="./www/profile.svg" alt="프로필" class="profile_icon">
          </button>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="#">마이페이지</a></li>
            <li><a class="dropdown-item" href="#">1:1문의</a></li>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li><a class="dropdown-item" href="#">로그아웃</a></li>
          </ul>
        </div>
      </c:when>
      <c:otherwise>
        <button class="btn btn-outline-secondary login-btn">로그인</button>
      </c:otherwise>
    </c:choose>
  </div>
</header>
</body>
</html>
