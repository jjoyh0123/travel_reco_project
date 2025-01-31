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

      .navbar {
          justify-content: flex-start;
          height: 100%;
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
          height: 70%;
      }

      .pagination {
          margin-top: 10px;
      }

      .nav-pills, .nav-tabs {
          position: relative;
          min-height: 40px;
      }

      .search-bar {
          position: absolute;
          bottom: -15px;
          right: 0;
      }

      .tab-user {
          display: flex;
          justify-content: space-between;
      }

      .tab-user p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
      }

      .tab-user p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-user p:nth-child(2) {
          flex: 0 0 35%;
      }

      .tab-user p:nth-child(3) {
          flex: 0 0 20%;
      }

      .tab-user p:nth-child(4) {
          flex: 0 0 20%;
      }

      .tab-user p:nth-child(5) {
          flex: 0 0 10%;
      }

      .tab-user p:nth-child(6) {
          flex: 0 0 5%;
      }

      .tab-badge {
          display: flex;
          justify-content: space-between;
      }

      .tab-badge p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
      }

      .tab-badge p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-badge p:nth-child(2) {
          flex: 0 0 10%;
      }

      .tab-badge p:nth-child(3) {
          flex: 0 0 35%;
      }

      .tab-badge p:nth-child(4) {
          flex: 0 0 15%;
      }

      .tab-badge p:nth-child(5) {
          flex: 0 0 25%;
      }

      .tab-badge p:nth-child(6) {
          flex: 0 0 5%;
      }

      .tab-post {
          display: flex;
          justify-content: space-between;
      }

      .tab-post p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
      }

      .tab-post p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-post p:nth-child(2) {
          flex: 0 0 15%;
      }

      .tab-post p:nth-child(3) {
          flex: 0 0 20%;
      }

      .tab-post p:nth-child(4) {
          flex: 0 0 35%;
      }

      .tab-post p:nth-child(5) {
          flex: 0 0 10%;
      }

      .tab-post p:nth-child(6) {
          flex: 0 0 10%;
      }

      .tab-notice {
          display: flex;
          justify-content: space-between;
      }

      .tab-notice p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
      }

      .tab-notice p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-notice p:nth-child(2) {
          flex: 0 0 20%;
      }

      .tab-notice p:nth-child(3) {
          flex: 0 0 25%;
      }

      .tab-notice p:nth-child(4) {
          flex: 0 0 15%;
      }

      .tab-notice p:nth-child(5) {
          flex: 0 0 15%;
      }

      .tab-notice p:nth-child(6) {
          flex: 0 0 10%;
      }

      .tab-notice p:nth-child(7) {
          flex: 0 0 5%;
      }

      .tab-support {
          display: flex;
          justify-content: space-between;
      }

      .tab-support p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
      }

      .tab-support p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-support p:nth-child(2) {
          flex: 0 0 10%;
      }

      .tab-support p:nth-child(3) {
          flex: 0 0 20%;
      }

      .tab-support p:nth-child(4) {
          flex: 0 0 25%;
      }

      .tab-support p:nth-child(5) {
          flex: 0 0 20%;
      }

      .tab-support p:nth-child(6) {
          flex: 0 0 10%;
      }

      .tab-support p:nth-child(7) {
          flex: 0 0 5%;
      }

      .tab-post2 {
          display: flex;
          justify-content: space-between;
      }

      .tab-post2 p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
      }

      .tab-post2 p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-post2 p:nth-child(2) {
          flex: 0 0 15%;
      }

      .tab-post2 p:nth-child(3) {
          flex: 0 0 15%;
      }

      .tab-post2 p:nth-child(4) {
          flex: 0 0 35%;
      }

      .tab-post2 p:nth-child(5) {
          flex: 0 0 10%;
      }

      .tab-post2 p:nth-child(6) {
          flex: 0 0 10%;
      }

      .tab-post2 p:nth-child(7) {
          flex: 0 0 5%;
      }

      .tab-best {
          display: flex;
          justify-content: space-between;
      }

      .tab-best p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
      }

      .tab-best p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-best p:nth-child(2) {
          flex: 0 0 10%;
      }

      .tab-best p:nth-child(3) {
          flex: 0 0 10%;
      }

      .tab-best p:nth-child(4) {
          flex: 0 0 25%;
      }

      .tab-best p:nth-child(5) {
          flex: 0 0 25%;
      }

      .tab-best p:nth-child(6) {
          flex: 0 0 20%;
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
            <c:when test="${param.tab == 'user'}">
              <li class="breadcrumb-item active" aria-current="page">사용자 관리</li>
            </c:when>
            <c:when test="${param.tab == 'post'}">
              <li class="breadcrumb-item active" aria-current="page">게시물 관리</li>
            </c:when>
            <c:when test="${param.tab == 'notice'}">
              <li class="breadcrumb-item active" aria-current="page">공지사항</li>
            </c:when>
            <c:when test="${param.tab == 'event'}">
              <li class="breadcrumb-item active" aria-current="page">이벤트 관리</li>
            </c:when>
            <c:when test="${param.tab == 'best_plan'}">
              <li class="breadcrumb-item active" aria-current="page">Best Plan 선정</li>
            </c:when>
            <c:when test="${param.tab == 'support'}">
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
          <a class="nav-link" href="?type=admin&tab=user">사용자 관리</a>
          <a class="nav-link" href="?type=admin&tab=post">게시물 관리</a>
          <a class="nav-link" href="?type=admin&tab=notice">공지사항</a>
          <a class="nav-link" href="?type=admin&tab=event">이벤트 관리</a>
          <a class="nav-link" href="?type=admin&tab=best_plan">Best Plan 선정</a>
          <a class="nav-link" href="?type=admin&tab=support">1:1 문의</a>
        </div>
      </aside>
      <div class="content">
        <c:choose>
          <c:when test="${param.tab == 'user'}"><%-- 유저 / 뱃지 관리 --%>
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a class="nav-link <c:if test='${param.tab2 == null || param.tab2 == "user"}'>active</c:if>"
                   aria-current="page" href="?type=admin&tab=user&tab2=user">사용자 관리</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test='${param.tab2 == "badge"}'>active</c:if>" aria-current="page"
                   href="?type=admin&tab=user&tab2=badge">뱃지 관리</a>
              </li>
              <form class="d-flex search-bar" role="search">
                <input type="hidden" name="type" value="admin"/>
                <input type="hidden" name="tab" value="${param.tab}"/>
                <input type="hidden" name="tab2" value="${param.tab2}"/>
                <input class="form-control me-2" type="search" name="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
              </form>
            </ul>
          </c:when>
          <c:when test="${param.tab == 'post'}">
            <%-- 지역 선택 --%>
            <ul class="nav nav-pills">
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == null || param.tab2 == 'areacode'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode">전체</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode1'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode1">서울</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode2'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode2">인천</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode3'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode3">대전</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode4'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode4">대구</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode5'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode5">광주</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode6'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode6">부산</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode7'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode7">울산</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode8'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode8">세종특별자치시</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode31'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode31">경기도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode32'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode32">강원특별자치도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode33'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode33">충청북도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode34'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode34">충청남도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode35'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode35">경상북도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode36'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode36">경상남도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode37'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode37">전북특별자치도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode38'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode38">전라남도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode39'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode39">제주도</a>
              </li>
              <form class="d-flex search-bar" role="search">
                <input type="hidden" name="type" value="admin"/>
                <input type="hidden" name="tab" value="${param.tab}"/>
                <input type="hidden" name="tab2" value="areacode"/>
                <input class="form-control me-2" type="search" name="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
              </form>
            </ul>
          </c:when>
          <c:when test="${param.tab == 'notice'}">
            <ul class="nav justify-content-end">
              <li>
                <button class="btn btn-primary" type="button">공지사항 작성</button>
              </li>
            </ul>
          </c:when>
          <c:when test="${param.tab == 'support'}">
            <ul class="nav nav-pills">
              <form class="d-flex search-bar" role="search">
                <input type="hidden" name="type" value="admin"/>
                <input type="hidden" name="tab" value="${param.tab}"/>
                <input class="form-control me-2" type="search" name="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
              </form>
            </ul>
          </c:when>
        </c:choose>

        <c:choose>
          <c:when test="${param.tab == 'user'}">
            <c:choose>
              <c:when test="${param.tab2 == null || param.tab2 == 'user'}">
                <ol class="list-group">
                  <li class="list-group-item tab-user">
                    <p>회원번호</p>
                    <p>이메일</p>
                    <p>닉네임</p>
                    <p>비밀번호</p>
                    <p>상태</p>
                    <p>수정</p></li>
                  <c:set var="startIndex" value="${(page.nowPage-1) * page.numPerPage}"/>
                  <c:forEach var="item" items="${ar}" varStatus="status">
                    <li class="list-group-item tab-user">
                      <p>${item.idx}</p>
                      <p>${item.email}</p>
                      <p>${item.nick}</p>
                      <p>${item.pw}</p>
                      <p>${item.status}</p>
                      <p>
                        <button type="button">&#x2699;</button>
                      </p>
                    </li>
                  </c:forEach></ol>
              </c:when>
              <c:when test="${param.tab2 == 'badge'}">
                <ol class="list-group">
                  <li class="list-group-item tab-badge">
                    <p>배지번호</p>
                    <p>회원번호</p>
                    <p>타입</p>
                    <p>등급</p>
                    <p>달성일자</p>
                    <p>수정</p></li>
                  <c:set var="startIndex" value="${(page.nowPage-1) * page.numPerPage}"/>
                  <c:forEach var="item" items="${ar}" varStatus="status">
                    <li class="list-group-item tab-badge">
                      <p>${item.idx}</p>
                      <p>${item.user_idx}</p>
                      <p>${item.type}</p>
                      <p>${item.grade}</p>
                      <p>${item.date}</p>
                      <p>
                        <button type="button">&#x2699;</button>
                      </p>
                    </li>
                  </c:forEach>
                </ol>
              </c:when>
            </c:choose>
          </c:when>

          <c:when test="${param.tab == 'post'}">
            <c:if test="${param.tab2 == null || param.tab2.contains('areacode')}">
              <ol class="list-group">
                <li class="list-group-item tab-post">
                  <p>게시물번호</p>
                  <p>여행일정번호</p>
                  <p>제목</p>
                  <p>내용</p>
                  <p>조회수</p>
                  <p>상태</p>
                </li>
                <c:set var="startIndex" value="${(page.nowPage-1) * page.numPerPage}"/>
                <c:forEach var="item" items="${ar}" varStatus="status">
                  <li class="list-group-item tab-post">
                    <p>${item.idx}</p>
                    <p>${item.plan_idx}</p>
                    <p>${item.title}</p>
                    <p>${item.subtitle}</p>
                    <p>${item.hit}</p>
                    <p>${item.status}</p>
                  </li>
                </c:forEach>
              </ol>
            </c:if>
          </c:when>
          <c:when test="${param.tab == 'notice'}">
            <ol class="list-group">
              <li class="list-group-item tab-notice">
                <p>등록번호</p>
                <p>제목</p>
                <p>내용</p>
                <p>작성일</p>
                <p>수정일</p>
                <p>조회수</p>
                <p>상태</p>
              </li>
              <c:set var="startIndex" value="${(page.nowPage-1) * page.numPerPage}"/>
              <c:forEach var="item" items="${ar}" varStatus="status">
                <li class="list-group-item tab-notice">
                  <p>${item.idx}</p>
                  <p>${item.title}</p>
                  <p>${item.content}</p>
                  <p>${item.reg_date}</p>
                  <p>${item.update_date}</p>
                  <p>${item.hit}</p>
                  <p>${item.status}</p>
                </li>
              </c:forEach>
            </ol>
          </c:when>
          <c:when test="${param.tab == 'support'}">
            <ol class="list-group">
              <li class="list-group-item tab-support">
                <p>등록번호</p>
                <p>유저번호</p>
                <p>제목</p>
                <p>내용</p>
                <p>등록일</p>
                <p>타입</p>
                <p>상태</p>
              </li>
              <c:set var="startIndex" value="${(page.nowPage-1) * page.numPerPage}"/>
              <c:forEach var="item" items="${ar}" varStatus="status">
                <li class="list-group-item tab-support">
                  <p>${item.idx}</p>
                  <p>${item.user_idx}</p>
                  <p>${item.title}</p>
                  <p>${item.content}</p>
                  <p>${item.reg_date}</p>
                  <p>${item.type}</p>
                  <p>${item.status}</p></li>
              </c:forEach>
            </ol>
          </c:when>
          <c:when test="${param.tab == 'best_plan'}">
            <ol class="list-group">
              <li class="list-group-item tab-best">
                <p>순위</p>
                <p>게시물번호</p>
                <p>후기번호</p>
                <p>설정일</p>
                <p>해제일</p>
                <p>상태</p>
              </li>
              <c:forEach var="item" items="${best}" varStatus="status">
                <li class="list-group-item tab-best">
                  <p>${item.tier}</p>
                  <p>${item.idx}</p>
                  <p>${item.journal_idx}</p>
                  <p>${item.act_date}</p>
                  <p>${item.deact_date}</p>
                  <p>${item.status}</p>
                </li>
              </c:forEach>
            </ol>
            <ul class="nav nav-pills">
              <li class="nav-item">
                <a class="nav-link disabled" aria-disabled="true">기간선택</a>
              </li>
              <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                        aria-expanded="false">
                  <c:choose>
                    <c:when test="${param.tab3 == null || param.tab3 == '3'}">
                      3개월
                    </c:when>
                    <c:when test="${param.tab3 == '6'}">
                      6개월
                    </c:when>
                    <c:when test="${param.tab3 == '12'}">
                      1년
                    </c:when>
                  </c:choose>
                </button>
                <c:choose>
                  <c:when test="${param.tab2 == null}">
                    <c:set var="tab2" value="recommend"/>
                  </c:when>
                  <c:otherwise>
                    <c:set var="tab2" value="${param.tab2}"/>
                  </c:otherwise>
                </c:choose>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="?type=admin&tab=best_plan&tab3=3&tab2=${tab2}">3개월</a></li>
                  <li><a class="dropdown-item" href="?type=admin&tab=best_plan&tab3=6&tab2=${tab2}">6개월</a></li>
                  <li><a class="dropdown-item" href="?type=admin&tab=best_plan&tab3=12&tab2=${tab2}">1년</a></li>
                </ul>
              </div>
              <form class="d-flex search-bar" role="search">
                <div class="dropdown">
                  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                          aria-expanded="false">
                    <c:choose>
                      <c:when test="${param.tab2 == null || param.tab2 == 'recommend'}">
                        추천순
                      </c:when>
                      <c:when test="${param.tab2 == 'late'}">
                        최신순
                      </c:when>
                    </c:choose>
                  </button>
                  <c:choose>
                    <c:when test="${param.tab3 == null}">
                      <c:set var="tab3" value="3"/>
                    </c:when>
                    <c:otherwise>
                      <c:set var="tab3" value="${param.tab3}"/>
                    </c:otherwise>
                  </c:choose>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="?type=admin&tab=best_plan&tab2=recommend&tab3=${tab3}">추천순</a>
                    </li>
                    <li><a class="dropdown-item" href="?type=admin&tab=best_plan&tab2=late&tab3=${tab3}">최신순</a></li>
                  </ul>
                </div>

                <input type="hidden" name="type" value="admin"/>
                <input type="hidden" name="tab" value="${param.tab}"/>
                <input class="form-control me-2" type="search" name="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
              </form>
            </ul>
            <ol class="list-group">
              <li class="list-group-item tab-post2">
                <p>게시물번호</p>
                <p>여행일정번호</p>
                <p>제목</p>
                <p>내용</p>
                <p>조회수</p>
                <p>상태</p>
                <p>설정</p>
              </li>
              <c:set var="startIndex" value="${(page.nowPage-1) * page.numPerPage}"/>
              <c:forEach var="item" items="${ar}" varStatus="status">
                <li class="list-group-item tab-post2">
                  <p>${item.idx}</p>
                  <p>${item.plan_idx}</p>
                  <p>${item.title}</p>
                  <p>${item.subtitle}</p>
                  <p>${item.hit}</p>
                  <p>${item.status}</p>
                  <p>
                    <button type="button">&#x2699;</button>
                  </p>
                </li>
              </c:forEach>
            </ol>
          </c:when>
        </c:choose>

        <c:choose>
          <c:when
              test="${param.tab == 'user' || param.tab == 'post' || param.tab == 'notice' || param.tab == 'support' || param.tab == 'best_plan'}">
            <nav aria-label="Page">
              <ul class="pagination justify-content-center">
                <c:if test="${page.startPage < page.pagePerBlock}">
                  <li class="page-item disabled"><a class="page-link">&lt;</a></li>
                </c:if>
                <c:if test="${page.startPage > page.pagePerBlock}">
                  <li class="page-item">
                    <a class="page-link" href="?type=admin&cPage=${page.startPage - page.pagePerBlock}">&lt;</a>
                  </li>
                </c:if>
                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                  <c:if test="${page.nowPage == i}">
                    <li class="page-item active"><a class="page-link" href="?type=admin&cPage=${i}">${i}</a></li>
                  </c:if>
                  <c:if test="${page.nowPage != i}">
                    <li class="page-item"><a class="page-link" href="?type=admin&cPage=${i}">${i}</a></li>
                  </c:if>
                </c:forEach> <c:if test="${page.endPage == page.totalPage}">
                <li class="page-item disabled"><a class="page-link">&gt;</a></li>
              </c:if>
                <c:if test="${page.endPage < page.totalPage}">
                  <li class="page-item">
                    <a class="page-link" href="?type=admin&cPage=${page.startPage + page.pagePerBlock}">&gt;</a>
                  </li>
                </c:if>
              </ul>
            </nav>
          </c:when>
        </c:choose>

      </div>
    </div>
  </article>
</div>
</body>
</html>
