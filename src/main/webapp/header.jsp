<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  session.setAttribute("userId", "temporaryUserId");
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
          color: coral;
      }

      .header-right-section {
          display: flex;
          align-items: center;
      }

      .header-right-section a {
          margin-right: 20px;
      }

      .header-right-section a:last-child {
          margin-right: 0;
      }

      .profile {
          background-image: none; /*프로필 사진*/
          margin-left: 10px;
      }

  </style>
</head>
<body>
<header>
  <div class="header-left-section">
    <a href="index.jsp"><img src="./www/logo.png" alt="로고"></a>&nbsp;&nbsp;
    <h3>Zenzen Club</h3><%--이미지로 변경 필요--%>
  </div>
  <div class="header-right-section">
    <button class="btn btn-outline-secondary">고객지원</button>
    <c:choose>
      <c:when test="${not empty sessionScope.userId}"><%-- 유저가 로그인 했는지 검증하는 부분 --%>
        <div class="dropdown">
          <button class="btn rounded-circle p-4 profile" type="button" data-bs-toggle="dropdown"
                  aria-expanded="false" style="border: 1px solid coral">
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
        <button class="btn btn-outline-secondary">로그인</button>
      </c:otherwise>
    </c:choose>
  </div>
</header>
</body>
</html>
