<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <title></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <link rel="stylesheet" href="../css/summernote-lite.css"/>
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
          min-width: 200px;
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
          height: 70%;
      }

      .menu {
          margin-top: 0;
          margin-bottom: auto;
      }

      .form-control {
          font-size: 12px;
          border: none;
      }

      .form-group {
          font-size: 20px;
      }

      .group {
          display: flex;
          justify-content: flex-end;
      }

      .group .form-control {
          width: auto;
      }

      input {
          border: none;
      }

      .hide {
          display: none;
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
          <a class="nav-link" href="?type=admin&tab=faq">FAQ</a>
        </div>
      </aside>
      <div class="content">
        <form action="Controller?type=adminView" method="post">
          <input type="hidden" id="idx" name="idx" value="${vo.idx}">
          <input type="hidden" id="status" name="status" value="${vo.status}">
          <div class="form-group">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="${vo.title}">
          </div>

          <c:choose>
            <c:when test="${param.tab == 'notice'}">
              <c:if test="${vo.reg_date != null || vo.update_date != null || vo.hit != null}">
                <div class="group">
                  <div class="form-control">
                    <c:if test="${vo.reg_date != null}">
                      <label for="reg_date">작성일:</label>
                      <input type="text" id="reg_date" name="reg_date" value="${vo.reg_date}" readonly>
                    </c:if>
                    <c:if test="${vo.update_date != null}">
                      <label for="update_date">수정일:</label>
                      <input type="text" id="update_date" name="update_date" value="${vo.update_date}" readonly>
                    </c:if>
                    <c:if test="${vo.hit != null}">
                      <label for="hit">조회수:</label>
                      <input type="text" id="hit" name="hit" value="${vo.hit}" readonly>
                    </c:if>
                  </div>
                </div>
              </c:if>
            </c:when>
            <c:when test="${param.tab == 'faq'}">
              <c:if test="${vo.reg_date != null}">
                <div class="group">
                  <div class="form-control">
                    <label for="reg_date">작성일:</label>
                    <input type="text" id="reg_date" name="reg_date" value="${vo.reg_date}" readonly>
                  </div>
                </div>
              </c:if>
            </c:when>
          </c:choose>


          <!-- Content textarea -->
          <div class="form-group">
            <label for="content" class="hide">내용:</label>
            <textarea id="content" name="content">${vo.content}</textarea>
          </div>
          <div class="button-group">
            <c:if test="${param.tab == 'notice'}">
              <button type="button" class="btn btn-secondary"
                      onclick="window.location.href='Controller?type=admin&tab=notice'">목록
              </button>
              <c:if test="${vo.idx == null}">
                <button type="button" class="btn btn-success" onclick="submitForm(this.form)">작성</button>
              </c:if>
              <c:if test="${vo.idx != null}">
                <button type="submit" class="btn btn-primary">수정</button>
              </c:if>
              <c:if test="${vo.status == '0'}">
                <button type="button" class="btn btn-danger" onclick="deleteAction(this.form)">삭제</button>
              </c:if>
              <c:if test="${vo.status == '1'}">
                <button type="button" class="btn btn-success" onclick="restoreAction(this.form)">복구</button>
              </c:if>
            </c:if>
            <c:if test="${param.tab == 'faq'}">
              <button type="button" class="btn btn-secondary"
                      onclick="window.location.href='Controller?type=admin&tab=faq'">목록
              </button>
            </c:if>
          </div>

        </form>
      </div>
    </div>
  </article>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="../js/summernote-lite.js"></script>
<script src="../js/lang/summernote-ko-KR.js"></script>
<script>
  $(function () {
    $("#content").summernote({
      lang: "ko-KR",
      width: '100%',
      height: 600,
      maxHeight: 600,
      minHeight: 600,
    });
    $("#content").summernote("lineHeight", 1.0);
  });

  function submitForm(form) {
    let title = $("#title").val().trim();
    let content = $("#content").val().trim();

    if (title === "") {
      alert("제목을 입력해 주세요.");
      return;
    }

    if (content === "") {
      alert("내용을 입력해 주세요.");
      return;
    }

    $(form).submit();
  }

  function deleteAction(form) {
    if (confirm("정말 삭제하시겠습니까?")) {
      form.action = "Controller?type=adminUpdate";
      form.method = "post";
      form.submit();
    }
  }

  function restoreAction(form) {
    if (confirm("정말 복구하시겠습니까?")) {
      form.action = "Controller?type=adminUpdate";
      form.method = "post";
      form.submit();
    }
  }


</script>
</body>
</html>
