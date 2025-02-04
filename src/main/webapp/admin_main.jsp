<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 페이지</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <style>
      table {
          width: 100%;
          border-collapse: separate;
          border-spacing: 10px; /* 각 th 및 tr 간의 간격 */
      }

      td {
          padding: 10px; /* 추가 간격 */
          text-align: left;
      }

      thead td {
          background-color: #f2f2f2;
          text-align: center;
      }

      img {
          width: 100%;
          height: auto;
      }

      td:first-child {
          width: 90%;
      }

      td:last-child {
          width: 10%;
          text-align: center;
      }

      button {
          font-size: 16px;
          padding: 5px 10px;
      }

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
          min-width: 200px;
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

      .menu {
          margin-top: 0;
          margin-bottom: auto;
      }

      .nav-pills,
      .nav-tabs {
          position: relative;
          min-height: 40px;
      }

      .search-bar {
          position: absolute;
          bottom: -15px;
          right: 0;
      }

      .tab-user,
      .tab-badge,
      .tab-post,
      .tab-notice,
      .tab-support,
      .tab-post2,
      .tab-best,
      .tab-faq {
          display: flex;
          justify-content: space-between;
      }

      .tab-user p,
      .tab-badge p,
      .tab-post p,
      .tab-notice p,
      .tab-support p,
      .tab-post2 p,
      .tab-best p,
      .tab-faq p {
          border: 1px solid #ccc;
          padding: 8px;
          margin: 0;
          box-sizing: border-box;
          overflow: hidden;
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
          flex: 0 0 9%;
      }

      .tab-user p:nth-child(6) {
          flex: 0 0 6%;
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
          flex: 0 0 24%;
      }

      .tab-badge p:nth-child(6) {
          flex: 0 0 6%;
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

      .tab-notice p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-notice p:nth-child(2) {
          flex: 0 0 20%;
          max-width: 20%;
      }

      .tab-notice p:nth-child(3) {
          flex: 0 0 25%;
          max-width: 25%;
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
          flex: 0 0 9%;
      }

      .tab-post2 p:nth-child(7) {
          flex: 0 0 6%;
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

      .tab-faq p:nth-child(1) {
          flex: 0 0 10%;
      }

      .tab-faq p:nth-child(2) {
          flex: 0 0 25%;
      }

      .tab-faq p:nth-child(3) {
          flex: 0 0 40%;
      }

      .tab-faq p:nth-child(4) {
          flex: 0 0 15%;
      }

      .tab-faq p:nth-child(5) {
          flex: 0 0 10%;
      }

      .ellipsis {
          overflow: hidden;
          text-overflow: ellipsis;
          word-wrap: break-word;
          display: -webkit-box;
          -webkit-line-clamp: 1;
          -webkit-box-orient: vertical;
          line-height: 2;
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
            <c:when test="${param.tab == 'faq'}">
              <li class="breadcrumb-item active" aria-current="page">FAQ</li>
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
          <a class="nav-link" href="?type=admin&tab=faq">FAQ</a>
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
              <c:choose>
                <c:when test="${param.tab2 == null}">
                  <c:set var="tab2" value="user"/>
                </c:when>
                <c:otherwise>
                  <c:set var="tab2" value="${param.tab2}"/>
                </c:otherwise>
              </c:choose>
              <form class="d-flex search-bar" role="search">
                <input type="hidden" name="type" value="admin"/>
                <input type="hidden" name="tab" value="${param.tab}"/>
                <input type="hidden" name="tab2" value="${tab2}"/>
                <c:choose>
                  <c:when test="${tab2 == 'user'}">
                    <c:set var="placeholderText" value="닉네임 검색"/>
                  </c:when>
                  <c:when test="${tab2 == 'badge'}">
                    <c:set var="placeholderText" value="타입 검색"/>
                  </c:when>
                </c:choose>
                <input class="form-control me-2" type="search" name="search" placeholder="${placeholderText}"
                       aria-label="Search" value="<c:out value='${param.search}'/>">
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
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode8">세종시</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode31'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode31">경기도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode32'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode32">강원도</a>
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
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode37">전라북도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode38'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode38">전라남도</a>
              </li>
              <li class="nav-item">
                <a class="nav-link <c:if test="${param.tab2 == 'areacode39'}">active</c:if>"
                   aria-current="page" href="?type=admin&tab=post&tab2=areacode39">제주도</a>
              </li>
              <c:choose>
                <c:when test="${param.tab2 == null}">
                  <c:set var="tab2" value="areacode"/>
                </c:when>
                <c:otherwise>
                  <c:set var="tab2" value="${param.tab2}"/>
                </c:otherwise>
              </c:choose>
              <form class="d-flex search-bar" role="search">
                <input type="hidden" name="type" value="admin"/>
                <input type="hidden" name="tab" value="${param.tab}"/>
                <input type="hidden" name="tab2" value="${tab2}"/>
                <input class="form-control me-2" type="search" name="search" placeholder="제목 검색" aria-label="Search"
                       value="<c:out value='${param.search}'/>">
                <button class="btn btn-outline-success" type="submit">Search</button>
              </form>
            </ul>
          </c:when>
          <c:when test="${param.tab == 'notice'}">
            <ul class="nav nav-pills justify-content-end">
              <li class="nav-item">
                <a class="nav-link disabled" aria-disabled="true">정렬선택</a>
              </li>
              <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                        aria-expanded="false">
                  <c:choose>
                    <c:when test="${param.tab3 == null || param.tab3 == 'idx'}">
                      등록번호순
                    </c:when>
                    <c:when test="${param.tab3 == 'update_date'}">
                      수정일순
                    </c:when>
                    <c:when test="${param.tab3 == 'reg_date'}">
                      등록일순
                    </c:when>
                    <c:when test="${param.tab3 == 'status'}">
                      상태순
                    </c:when>
                  </c:choose>
                </button>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="?type=admin&tab=notice&tab3=idx">등록번호순</a></li>
                  <li><a class="dropdown-item" href="?type=admin&tab=notice&tab3=reg_date">등록일순</a></li>
                  <li><a class="dropdown-item" href="?type=admin&tab=notice&tab3=update_date">수정일순</a></li>
                  <li><a class="dropdown-item" href="?type=admin&tab=notice&tab3=status">상태순</a></li>
                </ul>
              </div>
              &nbsp;
              <li>
                <button class="btn btn-primary" type="button"
                        onclick="window.location.href ='Controller?type=adminView&tab=notice'">공지사항 작성
                </button>
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
                      <p>
                        <c:forEach var="i" begin="1" end="${fn:length(item.pw)}">
                          *
                        </c:forEach>
                      </p>
                      <p>
                        <c:choose>
                          <c:when test="${item.status == 0}">정상</c:when>
                          <c:when test="${item.status == 1}">탈퇴</c:when>
                          <c:otherwise>오류</c:otherwise>
                        </c:choose>
                      </p>
                      <p>
                        <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                                data-bs-target="#userModal"
                                data-idx="${item.idx}"
                                data-email="${item.email}"
                                data-nick="${item.nick}"
                                data-pw="${item.pw}"
                                data-status="${item.status}">
                          &#x2699;
                        </button>
                      </p>
                      <div class="modal fade" id="userModal" data-bs-backdrop="static" data-bs-keyboard="false"
                           tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h1 class="modal-title fs-5" id="userModalLabel">사용자 정보 수정</h1>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"
                                      aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                              <form id="edit">
                                <div class="mb-3">
                                  <label for="idx" class="form-label">회원번호</label>
                                  <input type="text" class="form-control" id="idx" name="idx" readonly>
                                </div>
                                <div class="mb-3">
                                  <label for="email" class="form-label">이메일</label>
                                  <div class="d-flex">
                                    <input type="text" class="form-control" id="email" name="email"
                                           placeholder="example">
                                    <span>@</span>
                                    <input type="text" class="form-control" id="email-back" name="email"
                                           placeholder="domain.com">
                                  </div>
                                </div>
                                <div class="mb-3">
                                  <label for="nick" class="form-label">닉네임</label>
                                  <input type="text" class="form-control" id="nick" name="nick">
                                </div>
                                <div class="mb-3">
                                  <label for="pw" class="form-label">비밀번호</label>
                                  <input type="text" class="form-control" id="pw" name="pw">
                                </div>
                                <div class="mb-3">
                                  <label for="status" class="form-label">상태</label>
                                  <select class="form-select" id="status" name="status">
                                    <option value="0">정상</option>
                                    <option value="1">탈퇴</option>
                                  </select>
                                </div>
                              </form>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                              <button type="button" id="edit_btn" class="btn btn-primary">수정</button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </li>
                  </c:forEach>
                </ol>
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
                    <p class="ellipsis">${item.plan_idx}</p>
                    <p class="ellipsis">${item.title}</p>
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
                <li class="list-group-item tab-notice" onclick="goNotice(${item.idx})">
                  <p>${item.idx}</p>
                  <p class="ellipsis">${item.title}</p>
                  <p class="ellipsis">${item.content}</p>
                  <p class="date">${item.reg_date}</p>
                  <p class="date">${item.update_date}</p>
                  <p>${item.hit}</p>
                  <p>
                    <c:choose>
                      <c:when test="${item.status == '0'}">
                        정상
                      </c:when>
                      <c:when test="${item.status == '1'}">
                        삭제
                      </c:when>
                    </c:choose>
                  </p>
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
                  <p class="ellipsis">${item.title}</p>
                  <p class="ellipsis">${item.content}</p>
                  <p class="date">${item.reg_date}</p>
                  <p>${item.type}</p>
                  <p>
                    <c:choose>
                      <c:when test="${item.status == '0'}">
                        정상
                      </c:when>
                      <c:when test="${item.status == '1'}">
                        삭제
                      </c:when>
                    </c:choose>
                  </p>
                </li>
              </c:forEach>
            </ol>
          </c:when>
          <c:when test="${param.tab == 'event'}">
            <%--이벤트 배너 5개 이미지를 각각 보여줘야 함--%>
            <%--그리고 해당 이미지를 변경하는 기능도 있어야 함--%>
            <table>
              <thead>
              <tr>
                <td>배너 이미지</td>
                <td>수정</td>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="item" items="${ar}" varStatus="status">
                <tr>
                  <td>
                    <c:if test="${not empty item.file_path}">
                      <img src="${item.file_path}" alt="이벤트 배너 ${status.index + 1}">
                    </c:if>
                    <c:if test="${empty item.file_path}">
                      <p>이미지가 등록되지 않았습니다.</p>
                    </c:if>
                  </td>
                  <td>
                    <button type="button"
                            class="btn btn-primary" ${empty item.file_path ? '' : 'style="display:none;"'}>등록
                    </button>
                    <button type="button"
                            class="btn btn-success" ${not empty item.file_path ? '' : 'style="display:none;"'}>수정
                    </button>
                    <button type="button" class="btn btn-danger" ${empty item.file_path ? 'disabled' : ''}>삭제</button>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </c:when>
          <c:when test="${param.tab == 'best_plan'}">
            <ol class="list-group">
              <li class="list-group-item tab-best">
                <p>순위</p>
                <p>게시물번호</p>
                <p>후기번호</p>
                <p>선정일</p>
                <p>해제일</p>
                <p>상태</p>
              </li>
              <c:forEach var="item" items="${best}" varStatus="status">
                <li class="list-group-item tab-best">
                  <p>${item.tier}</p>
                  <p>${item.idx}</p>
                  <p>${item.journal_idx}</p>
                  <p class="date">${item.act_date}</p>
                  <p class="date">${item.deact_date}</p>
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
                    <c:when test="${param.search == null}">
                      <c:set var="search" value=""/>
                    </c:when>
                    <c:otherwise>
                      <c:set var="search" value="${param.search}"/>
                    </c:otherwise>
                  </c:choose>
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
                  <li><a class="dropdown-item"
                         href="?type=admin&tab=best_plan&tab3=3&tab2=${tab2}&search=${search}">3개월</a></li>
                  <li><a class="dropdown-item"
                         href="?type=admin&tab=best_plan&tab3=6&tab2=${tab2}&search=${search}">6개월</a></li>
                  <li><a class="dropdown-item"
                         href="?type=admin&tab=best_plan&tab3=12&tab2=${tab2}&search=${search}">1년</a></li>
                </ul>
              </div>
              <li class="nav-item">
                <a class="nav-link disabled" aria-disabled="true">정렬선택</a>
              </li>
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
                  <li><a class="dropdown-item"
                         href="?type=admin&tab=best_plan&tab2=recommend&tab3=${tab3}&search=${search}">추천순</a>
                  </li>
                  <li><a class="dropdown-item" href="?type=admin&tab=best_plan&tab2=late&tab3=${tab3}&search=${search}">최신순</a>
                  </li>
                </ul>
              </div>
              <form class="d-flex search-bar" role="search">
                <input type="hidden" name="type" value="admin"/>
                <input type="hidden" name="tab" value="${param.tab}"/>
                <input type="hidden" name="tab2" value="${tab2}"/>
                <input type="hidden" name="tab3" value="${tab3}"/>
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
                  <p class="ellipsis">${item.title}</p>
                  <p class="ellipsis">${item.subtitle}</p>
                  <p>${item.hit}</p>
                  <p>${item.status}</p>
                  <p>
                    <button type="button">&#x2699;</button>
                  </p>
                </li>
              </c:forEach>
            </ol>
          </c:when>
          <c:when test="${param.tab == 'faq'}">
            <ol class="list-group">
              <li class="list-group-item tab-faq">
                <p>등록번호</p>
                <p>제목</p>
                <p>내용</p>
                <p>등록일</p>
                <p>상태</p>
              </li>
              <c:set var="startIndex" value="${(page.nowPage-1) * page.numPerPage}"/>
              <c:forEach var="item" items="${ar}" varStatus="status">
                <li class="list-group-item tab-faq" onclick="goFAQ(${item.idx})">
                  <p>${item.idx}</p>
                  <p class="ellipsis">${item.title}</p>
                  <p class="ellipsis">${item.content}</p>
                  <p class="date">${item.reg_date}</p>
                  <p>
                    <c:choose>
                      <c:when test="${item.status == '0'}">
                        정상
                      </c:when>
                      <c:when test="${item.status == '1'}">
                        삭제
                      </c:when>
                    </c:choose>
                  </p>
                </li>
              </c:forEach>
            </ol>
          </c:when>
        </c:choose>

        <c:choose>
          <c:when
              test="${param.tab == 'user' || param.tab == 'post' || param.tab == 'notice' || param.tab == 'support' || param.tab == 'best_plan'|| param.tab == 'faq'}">
            <nav aria-label="Page">
              <ul class="pagination justify-content-center">
                <c:if test="${page.startPage < page.pagePerBlock}">
                  <li class="page-item disabled"><a class="page-link">&lt;</a></li>
                </c:if>
                <c:if test="${page.startPage > page.pagePerBlock}">
                  <li class="page-item">
                    <a class="page-link"
                       href="?type=admin&cPage=${page.startPage - page.pagePerBlock}&tab=${param.tab}}">&lt;</a>
                  </li>
                </c:if>
                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                  <c:if test="${page.nowPage == i}">
                    <li class="page-item active"><a class="page-link"
                                                    href="?type=admin&cPage=${i}&tab=${param.tab}">${i}</a></li>
                  </c:if>
                  <c:if test="${page.nowPage != i}">
                    <li class="page-item"><a class="page-link" href="?type=admin&cPage=${i}&tab=${param.tab}">${i}</a>
                    </li>
                  </c:if>
                </c:forEach> <c:if test="${page.endPage == page.totalPage}">
                <li class="page-item disabled"><a class="page-link">&gt;</a></li>
              </c:if>
                <c:if test="${page.endPage < page.totalPage}">
                  <li class="page-item">
                    <a class="page-link"
                       href="?type=admin&cPage=${page.startPage + page.pagePerBlock}&tab=${param.tab}">&gt;</a>
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

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  $(document).ready(function () {
    // 모달이 열릴 때 이벤트 리스너 추가
    $('#userModal').on('show.bs.modal', function (event) {
      const button = $(event.relatedTarget); // 클릭된 버튼
      const idx = button.data('idx'); // data-idx 속성 값
      const email = button.data('email'); // data-email 속성 값
      const nick = button.data('nick'); // data-nick 속성 값
      const pw = button.data('pw'); // data-pw 속성 값
      const status = button.data('status'); // data-status 속성 값

      // 모달 내부의 입력 필드에 데이터 채우기
      const modal = $(this);
      modal.find('#idx').val(idx);
      modal.find('#email').val(email.split('@')[0]); // 이메일 앞부분
      modal.find('#email-back').val(email.split('@')[1]); // 이메일 뒷부분
      modal.find('#nick').val(nick);
      modal.find('#pw').val(pw);
      modal.find('#status').val(status);
    });

    $('#edit_btn').click(function (event) {
          event.preventDefault(); // 기본 폼 제출 방지

          //유효성 검사
          let emailFront = $('#email').val();
          let emailBack = $('#email-back').val();
          let nick = $('#nick').val();
          let pw = $('#pw').val();
          let status = $('#status').val();

          if (!emailFront || emailFront.length < 4 || !emailBack || emailBack.length < 7) {
            alert("이메일을 올바르게 입력해주세요.");
            return;
          }
          if (!nick || nick.length < 4) {
            alert("닉네임을 4자 이상 입력해주세요.");
            return;
          }
          if (!pw || pw.length < 4) {
            alert("비밀번호를 4자 이상 입력해주세요.");
            return;
          }
          if (!status) {
            alert("상태를 선택해주세요.");
            return;
          }

          let formData = {
            idx: $('#idx').val(),
            email: $('#email').val() + '@' + $('#email-back').val(),
            nick: $('#nick').val(),
            pw: $('#pw').val(),
            status: $('#status').val()
          };

          $.ajax({
            type: 'POST',
            url: '/Controller?type=updateUser',
            data: formData,
            success: function (response) {

              if (response.success) {
                alert('회원 정보가 성공적으로 업데이트되었습니다.');
                location.reload(); // 페이지 새로고침
              } else {
                alert('업데이트에 실패했습니다.');
              }
            },
            error: function (xhr, status, error) {
              console.error('Error:', error);
            }
          });
        }
    )
    ;
  });
  $(document).ready(function () {
    $('.date').each(function () {
      const dateString = $(this).text();
      const formattedDate = dateString.split(' ')[0]; // 공백을 기준으로 문자열을 잘라서 첫 번째 부분만 가져옴
      $(this).text(formattedDate);
    });
  });

  function goNotice(idx) {
    window.location.href = "Controller?type=adminView&tab=notice&idx=" + idx;
  }

  function goFAQ(idx) {
    window.location.href = "Controller?type=adminView&tab=faq&idx=" + idx;
  }
</script>
</body>
</html>