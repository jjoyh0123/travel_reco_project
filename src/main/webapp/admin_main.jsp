<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 페이지</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
  </script>
  <style>
      body {
          display: flex;
          flex-direction: column;
      }

      .breadcrumb-container {
          background-color: lightgray;
          padding: 10px;
      }

      .main-content {
          display: flex;
          flex-grow: 1;
      }

      aside {
          width: 200px;
          background-color: #f8f9fa;
      }

      .content {
          flex-grow: 1;
          padding: 20px;
      }

      .wrapper {
          flex-grow: 1;
          display: flex;
          flex-direction: column;
          width: 80%;
          margin: 0 auto;
          height: 100%;
      }

      #admin-content {
          margin-top: auto;
      }

      .menu {
          height: 500px;
      }
  </style>
</head>
<body>
<div class="wrapper">
  <%--추가 내용 들어갈 수 있음--%>
  <article id="admin-content">
    <div class="breadcrumb-container">
      <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="#">Home</a></li>
          <c:choose>
            <c:when test="${param.tab == '사용자 관리'}">
              <li class="breadcrumb-item active" aria-current="page">사용자 관리</li>
            </c:when>
            <c:when test="${param.tab == '게시물 관리'}">
              <li class="breadcrumb-item active" aria-current="page">게시물 관리</li>
            </c:when>
            <c:when test="${param.tab == '공지사항'}">
              <li class="breadcrumb-item active" aria-current="page">공지사항</li>
            </c:when>
            <c:when test="${param.tab == '이벤트 관리'}">
              <li class="breadcrumb-item active" aria-current="page">이벤트 관리</li>
            </c:when>
            <c:when test="${param.tab == 'Best Plan 선정'}">
              <li class="breadcrumb-item active" aria-current="page">Best Plan 선정</li>
            </c:when>
            <c:when test="${param.tab == '1:1 문의'}">
              <li class="breadcrumb-item active" aria-current="page">1:1 문의</li>
            </c:when>
            <c:otherwise>

            </c:otherwise>
          </c:choose>
        </ol>
      </nav>
    </div>
    <div class="main-content">
      <aside class="navbar flex-column">
        <a class="navbar-brand" href="#">관리자 메뉴</a>
        <div class="navbar-nav menu">
          <a class="nav-link" href="?tab=사용자 관리">사용자 관리</a>
          <a class="nav-link" href="?tab=게시물 관리">게시물 관리</a>
          <a class="nav-link" href="?tab=공지사항">공지사항</a>
          <a class="nav-link" href="?tab=이벤트 관리">이벤트 관리</a>
          <a class="nav-link" href="?tab=Best Plan 선정">Best Plan 선정</a>
          <a class="nav-link" href="?tab=1:1 문의">1:1 문의</a>
        </div>
      </aside>
      <div class="content">
        <ol class="list-group list-group-numbered">
          <c:forEach var="item" items="${items}">
            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">${item.title}</div>
                  ${item.content}
              </div>
              <span class="badge text-bg-primary rounded-pill">${item.badge}</span>
            </li>
          </c:forEach>
        </ol>
        <nav aria-label="Page navigation example">
          <ul class="pagination justify-content-center">
            <c:if test="${currentPage == 1}">
              <li class="page-item disabled"><a class="page-link">Previous</a></li>
            </c:if>
            <c:if test="${currentPage != 1}">
              <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}">Previous</a></li>
            </c:if>
            <c:forEach var="page" begin="1" end="${totalPages}">
              <li class="page-item"><a class="page-link" href="?page=${page}">${page}</a></li>
            </c:forEach>
            <c:if test="${currentPage == totalPages}">
              <li class="page-item disabled"><a class="page-link">Next</a></li>
            </c:if>
            <c:if test="${currentPage != totalPages}">
              <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}">Next</a></li>
            </c:if>
          </ul>
        </nav>
      </div>
    </div>
  </article>
</div>
</body>
</html>
