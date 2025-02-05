<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>로그인</title>
  <style>
      /* 네비게이션 바 스타일 */
      .navbar {
          width: 100%;
          background-color: #F6F5F4;
          position: relative;
          height: 30px;
          top: 0;
          left: 0;
          text-align: center;
          margin-bottom: 150px;
      }

      #back_btn{
          position: absolute;
          left: 10px;
          top: 0;
      }

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
          justify-content: center;
          align-items: center;
          height: auto;
          margin: 0;
          background-color: #f9f9f9;
      }

      #logo_name {
          font-size: 30px;
          text-align: center;
          color: #ff7f50;
          font-weight: bold;
          background-color: #f9f9f9;
          margin-bottom: 30px;
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
          background-color: #f9f9f9;
          color: #1A1A1A;
          font-size: 16px;
          border-radius: 5px;
          transition: background-color 0.3s;
      }


  </style>
</head>
<body>
<!-- 네비게이션 바 추가 -->
<div class="navbar">
  <a href="${pageContext.request.contextPath}/jsp/index.jsp" id="back_btn">&lt;</a>
  <a id="login_name">로그인</a>
</div>


<p id="logo_name">zenzenclub</p>

<div class="social-buttons">
  <button class="social-button kakao" aria-label="카카오 로그인" onclick="location.href='${pageContext.request.contextPath}/Controller?type=kakaoLogin'">
    <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-kakao.svg" alt="카카오 로그인"  />
    <span>카카오로 시작하기</span>
  </button>

  <button class="social-button naver" aria-label="네이버 로그인" onclick="location.href='${pageContext.request.contextPath}/Controller?type=naverLogin'">
    <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-naver.svg" alt="네이버 로그인" />
    <span>네이버로 시작하기</span>
  </button>

  <button class="social-button google" aria-label="구글 로그인" onclick="location.href='${pageContext.request.contextPath}/Controller?type=googleLogin'">
    <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-google.svg" alt="구글 로그인" />
    <span>Google로 시작하기</span>
  </button>

  <button class="social-button apple" aria-label="애플 로그인" onclick="location.href='${pageContext.request.contextPath}/Controller?type=appleLogin'">
    <img src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-apple.svg" alt="애플 로그인" />
    <span>Apple로 시작하기</span>
  </button>

  <a href="${pageContext.request.contextPath}/jsp/emailLogin.jsp" id="email_login">이메일로 시작하기 &gt;</a>
</div>
</body>
</html>
