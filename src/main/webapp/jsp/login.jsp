<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .navbar a {
      color: #1A1A1A;
      text-decoration: none;
      font-size: 18px;
    }

    .navbar a:hover {
      border-radius: 4px;
    }

    body {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 0;
      background-color: #F5F5F7;
    }

    .content {
      width: 900px;
      min-height: 600px;
      flex-grow: 1;
      margin-bottom: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .social-buttons {
      display: flex;
      flex-direction: column;
      gap: 20px;
      align-items: center;
    }

    .social-button {
      display: flex;
      align-items: center;
      background-color: #ffffff;
      border: 1px solid #e1e1e1;
      border-radius: 5px;
      padding: 10px 20px;
      width: 250px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-weight: bold;
      padding-left: 40px;
      font-family: '맑은 고딕 Semilight', sans-serif;
    }

    .social-button img {
      width: 24px;
      height: 24px;
      margin-right: 10px;
    }

    .social-button span {
      font-size: 16px;
      color: #1A1A1A;
    }

    .social-button:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .social-button.kakao {
      border-color: #f7e600;
      background-color: #fee500;
      color: #1A1A1A;
    }

    .social-button.naver {
      border-color: #1ec800;
      background-color: #1ec800;
    }

    .social-button.naver span {
      color: white;
    }

    .social-button.google {
      border-color: #555555;
      background-color: #ffffff;
      color: #1A1A1A;
    }

    .social-button.apple {
      border-color: #555555;
      background-color: #ffffff;
      color: #1A1A1A;
    }

    #email_login {
      text-decoration: none;
      padding: 10px 20px;
      background-color: #F5F5F7;
      color: #1A1A1A;
      font-size: 16px;
      border-radius: 5px;
      transition: background-color 0.3s;
    }


  </style>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
<article class="content">

  <!-- 조건에 따라 소셜 버튼 또는 프로필 사진 출력 -->
  <div class="social-buttons">
    <c:if test="${empty sessionScope.profileImg}">
      <!-- 비로그인 상태: 소셜 로그인 버튼들 출력 -->
      <button class="social-button kakao" aria-label="카카오 로그인"
              onclick="location.href='${pageContext.request.contextPath}/Controller?type=kakao_login'">
        <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-kakao.svg" alt="카카오 로그인"/>
        <span>카카오로 시작하기</span>
      </button>

      <button class="social-button naver" aria-label="네이버 로그인"
              onclick="location.href='${pageContext.request.contextPath}/Controller?type=naver_login'">
        <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-naver.svg" alt="네이버 로그인"/>
        <span>네이버로 시작하기</span>
      </button>

      <button class="social-button google" aria-label="구글 로그인"
              onclick="location.href='${pageContext.request.contextPath}/Controller?type=google_login'">
        <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-google.svg" alt="구글 로그인"/>
        <span>Google로 시작하기</span>
      </button>

      <button class="social-button apple" aria-label="애플 로그인"
              onclick="location.href='${pageContext.request.contextPath}/Controller?type=apple_login'">
        <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-apple.svg" alt="애플 로그인"/>
        <span>Apple로 시작하기</span>
      </button>

      <a href="${pageContext.request.contextPath}/Controller?type=email_login" id="email_login">이메일로 시작하기 &gt;</a>
    </c:if>

    <c:if test="${not empty sessionScope.profileImg}">
      <!-- 로그인 상태: 프로필 사진 출력 -->
      <div class="profile" onclick="location.href='${pageContext.request.contextPath}/Controller?type=my_page'">
        <img src="${sessionScope.profileImg}" alt="프로필 사진"/>
      </div>
    </c:if>
  </div>
</article>
<script>
  function fake() {
    <%--window.open("${pageContext.request.contextPath}/Controller?type=my_page");--%>
    <%--fake.jsp--%>
    <%--window.size == ""--%>
    <%--<div>--%>
    <%--  <img src="" art="">--%>
    <%--</div>--%>
    <%--setTimeout(function(){--%>
    <%--  window.close();--%>
    <%--},300)--%>
    <%--setTimeout(function(){--%>
    <%--  location.href--%>
    <%--},500)--%>
  }
</script>
</body>
</html>
