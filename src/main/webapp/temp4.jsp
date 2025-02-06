<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>관광지 목록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
      .place-card {
          margin-bottom: 20px;
      }

      .place-img {
          height: 200px;
          object-fit: cover;
      }
  </style>
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">관광지 목록</h2>

  <!-- 목록 표시 -->
  <div class="row">
    <c:forEach items="${ar}" var="vo">
      <div class="col-md-4">
        <div class="card place-card">
          <img src="${vo.thumnail}" class="card-img-top place-img" alt="${vo.title}">
          <div class="card-body">
            <h5 class="card-title">${vo.title}</h5>
            <p class="card-text">
              위치: (${vo.map_x}, ${vo.map_y})<br>
              콘텐츠 ID: ${vo.content_id}
            </p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

  <!-- 페이징 네비게이션 -->
  <nav aria-label="Page navigation">
    <ul class="pagination justify-content-center">
      <!-- 이전 블록 -->
      <c:if test="${page.startPage > 1}">
        <li class="page-item">
          <a class="page-link"
             href="?cPage=${page.startPage-1}&areaCode=${areaCode}">이전</a>
        </li>
      </c:if>

      <!-- 페이지 번호 -->
      <c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
        <li class="page-item ${p == page.nowPage ? 'active' : ''}">
          <a class="page-link"
             href="/Controller?type=temp4&cPage=${p}&areaCode=${areaCode}">${p}</a>
        </li>
      </c:forEach>

      <!-- 다음 블록 -->
      <c:if test="${page.endPage < page.totalPage}">
        <li class="page-item">
          <a class="page-link"
             href="/Controller?type=temp4&cPage=${page.endPage+1}&areaCode=${areaCode}">다음</a>
        </li>
      </c:if>
    </ul>
  </nav>
</div>
</body>
</html>