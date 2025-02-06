<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>탈퇴 완료</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
      body {
          background-color: #f8f9fa;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
          margin: 0;
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      }

      .container {
          background-color: #ffffff;
          border-radius: 12px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
          padding: 30px 40px;
          text-align: center;
          max-width: 500px;
          width: 100%;
      }

      h1 {
          font-size: 28px;
          font-weight: bold;
          color: #343a40;
          margin-bottom: 20px;
      }

      p {
          font-size: 16px;
          color: #6c757d;
          margin-bottom: 30px;
      }

      .btn-orange {
          background-color: #ff7f50;
          color: white;
          font-weight: bold;
          padding: 10px 20px;
          border-radius: 8px;
          text-decoration: none;
          transition: background-color 0.3s ease;
      }

      .btn-orange:hover {
          background-color: #ff6347;
      }

      .logo {
          width: 80px;
          margin-bottom: 20px;
      }
  </style>
</head>
<body>

<div class="container">
  <img src="${pageContext.request.contextPath}/www/logo.png" alt="Logo" class="logo">
  <h1>회원 탈퇴가 완료되었습니다.</h1>
  <p>그동안 이용해 주셔서 감사합니다. <br>언제든 다시 방문해 주세요!</p>
  <a href="${pageContext.request.contextPath}/Controller?type=index" class="btn-orange">홈으로 이동</a>
</div>

<script>
  // 페이지 로드 후 5초 후에 자동으로 홈으로 이동하는 기능
  setTimeout(function() {
    window.location.href = "${pageContext.request.contextPath}/Controller?type=index";
  }, 5000);
</script>

</body>
</html>
