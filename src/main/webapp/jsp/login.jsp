<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>로그인방법 선택</title>

  <style>


      #top_name {
          display: flex;
          width: 100%;
          height: 10px;
      }


      #logo_name{
          font-size: 30px;
          text-align: center;
          color: #ff7f50;
          font-weight: bold;
          background-color: #ffffff;
      }

      #back_wrap, #login_text {
          flex: 1;
          display: flex;
          align-items: center;
      }

      #back_wrap {
          justify-content: flex-start;
          text-decoration: none;
          background-color: white;
      }

      #login_text {
          justify-content: left;
          font-size: large;
      }


      .login-options{
          display: flex;
          justify-content: center;
          align-items: center;
          gap: 20px;
          flex-direction: column;
      }

      .login-options img{
          width: 350px;
          height: 70px;
          flex-direction: column;
          border-color: white;

      }

      #email_login{
          border: none;
          color: #555555;
          background-color: #ffffff;
          font-size: 15px;
      }

      .button-style{
          text-decoration: none;
      }

  </style>
</head>
<header id="top_name">
  <a href="Controller?type=index" id="back_wrap">
    <button type="button" id="back_btn"> &lt; </button>
  </a>
  <span id="login_text">로그인</span>
</header>
<body>
<p id="logo_name">zenzenclub</p>
<div class="login-options img">
  <img src="${pageContext.request.contextPath}/www/kakao_img.png" alt="카카오 로그인" id="kakao_login" onclick="location.href='${pageContext.request.contextPath}/Controller?type=kakaoLogin'">

  <img src="${pageContext.request.contextPath}/www/naver_img.png" alt="네이버 로그인" id="naver_login" onclick="location.href='${pageContext.request.contextPath}/Controller?type=naverLogin'">

  <img src="${pageContext.request.contextPath}/www/google_img.png" alt="구글 로그인" id="google_login" onclick="location.href='${pageContext.request.contextPath}/Controller?type=googleLogin'">

  <img src="${pageContext.request.contextPath}/www/apple_img.png" alt="애플 로그인" id="apple_login" onclick="location.href='${pageContext.request.contextPath}/Controller?type=appleLogin'">

  <a href="Controller?type=emailLogin" id="email_login" class="button-style">이메일로 시작하기 &gt;</a>

</div>
</body>
</html>
