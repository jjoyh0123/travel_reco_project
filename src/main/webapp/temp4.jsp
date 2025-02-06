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
  <form class="mb-4 border p-3 rounded" method="get" action="/Controller">
    <input type="hidden" name="type" value="temp4">
    <input type="hidden" id="hiddenAreaCode" name="areaCode" value="${param.areaCode}">
    <div class="row g-3">
      <!-- 지역 선택 -->
      <div class="col-md-4">
        <div class="col-md-4">
          <select class="form-select" id="areaCodeSelect" onchange="area_change(this.form)">
            <option value="">전체 지역</option>
            <option value="1">서울</option>
            <option value="2">인천</option>
            <option value="3">대전</option>
            <option value="4">대구</option>
            <option value="5">광주</option>
            <option value="6">부산</option>
            <option value="7">울산</option>
            <option value="8">세종특별자치시</option>
            <option value="31">경기도</option>
            <option value="32">강원특별자치도</option>
            <option value="33">충청북도</option>
            <option value="34">충청남도</option>
            <option value="35">경상북도</option>
            <option value="36">경상남도</option>
            <option value="37">전북특별자치도</option>
            <option value="38">전라남도</option>
            <option value="39">제주도</option>
          </select>
        </div>

      </div>

      <!-- 검색어 입력 -->
      <div class="col-md-6">
        <input type="text" class="form-control" name="keyword"
               placeholder="검색어 입력" value="${param.keyword}">
      </div>

      <!-- 검색 버튼 -->
      <div class="col-md-2">
        <button type="submit" class="btn btn-primary w-100">검색</button>
      </div>
    </div>
  </form>


  <h2 class="mb-4">관광지 목록</h2>

  <!-- 목록 표시 -->
  <div class="row">
    <c:forEach items="${ar}" var="vo">
      <div class="col-md-4">
        <div class="card place-card" data-contentid="${vo.content_id}" onclick="fetchOverview(this)">
          <img src="${vo.thumnail}" class="card-img-top place-img" alt="${vo.title}">
          <div class="card-body">
            <h5 class="card-title">${vo.title}</h5>
            <p class="card-text">
              위치: (${vo.mapx}, ${vo.mapy})<br>
              콘텐츠 ID: ${vo.content_id}
            </p>
            <p id="overview"></p>
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
             href="?cPage=${page.startPage-1}&areaCode=${param.areaCode}&keyword=${param.keyword}">이전</a>
        </li>
      </c:if>

      <!-- 페이지 번호 -->
      <c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
        <li class="page-item ${p == page.nowPage ? 'active' : ''}">
          <a class="page-link"
             href="/Controller?type=temp4&cPage=${p}&areaCode=${param.areaCode}&keyword=${param.keyword}">${p}</a>
        </li>
      </c:forEach>
      <!-- 다음 블록 -->
      <c:if test="${page.endPage < page.totalPage}">
        <li class="page-item">
          <a class="page-link"
             href="/Controller?type=temp4&cPage=${page.endPage+1}&areaCode=${param.areaCode}&keyword=${param.keyword}">다음</a>
        </li>
      </c:if>
    </ul>
  </nav>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  function area_change(frm) {
    document.getElementById("hiddenAreaCode").value = document.getElementById("areaCodeSelect").value;
    frm.submit();
  }

  function fetchOverview(element) {
    let contentId = $(element).data("contentid");
    let apiUrl = "http://apis.data.go.kr/B551011/KorService1/detailCommon1?" +
        "serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D" +
        "&numOfRows=1&pageNo=1&MobileOS=ETC&MobileApp=AppTest" +
        "&contentId=" + contentId + "&overviewYN=Y";

    $.ajax({
      url: apiUrl,
      type: "GET",
      dataType: "xml",
      success: function (data) {
        let overview = $(data).find("overview").text() || "설명 없음";
        $(element).find("#overview").html(overview);
      },
      error: function (xhr, status, error) {
        console.error("Error fetching overview:", error);
        alert("정보를 불러오는 데 실패했습니다.");
      }
    });
  }
</script>


</body>
</html>