<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>카카오톡 로그인</title>
  <style>

      #login_back_btn{
        width: 50%;
        height: 30px;
        border: none;
        margin-bottom: 50px;
        font-size: 20px;
        background-color: #f8f9fa;
    }

  </style>
</head>
<body>
<header>
  <a href="index.jsp"><button type="button" id="login_back_btn"> < 로그인</button></a>
</header>

<button onclick="kakaoLogin()" style="background-color: #FEE500; border: none; padding: 10px; width: 50%; font-size: 16px; border-radius: 5px; display: flex; align-items: center; justify-content: center;">
  <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_small.png" alt="Kakao" style="margin-right: 8px;">
  카카오로 시작하기
</button>

<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
  Kakao.init('570783d413c5ecc9a78e787d39346cc3');
  function kakaoLogin() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8080/LoginAction' // 리디렉션 URL
    });
  }
</script>
<div id="naverIdLogin"></div>

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
<script>
  const naverLogin = new naver.LoginWithNaverId({
    clientId: "3D8EiG7G3qcCakrlLlcj", // 네이버에서 발급받은 Client ID
    callbackUrl: "http://localhost:8080/naverLoginCallback", // 네이버 개발자 센터에 등록한 Callback URL
    isPopup: false, // 팝업 방식 사용 여부
    loginButton: { color: "green", type: 3, height: 48 } // 로그인 버튼 디자인
  });
  naverLogin.init();
</script>

</body>
</html>
