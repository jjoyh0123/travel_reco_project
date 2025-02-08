<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <style>
      .footer {
          display: flex;
          flex-direction: column;
          align-items: center;
          padding: 20px;
          background-color: #f8f9fa;
          bottom: 0;
          width: 100%;
      }

      .footer img {
          height: 60px;
          margin-bottom: 20px;
      }

      .footer p {
          margin: 0 0 5px 0;
          color: #bbb;
          font-size: 12px;
      }

      .footer a {
          text-decoration: none;
          color: #555;
      }

      .footer a:hover {
          color: #000;
      }

      .footer_content {
          margin: 0 auto;
          width: 80%;
      }

      #hidden_place {
          width: 100%;
          height: 10px;
      }

      #hidden_button {
          width: 100%;
          height: 100%;
          border: none;
          background-color: #f8f9fa;
      }

  </style>
</head>
<body>
<footer class="footer">
  <div class="footer_content">
    <img src="${pageContext.request.contextPath}/www/logo.png" alt="로고"/>
    <p>주소: 서울 강남구 테헤란로 132, 8층 쌍용교육센터</p>
    <p>info@example.com</p>
    <br/>
    <p><a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객지원</a> | <a href="#">1:1 문의</a></p>
    <br/>
    <br/>
    <p>Copyright &copy; Zenzen Club All Rights Reserved.</p>
  </div>
  <div id="hidden_place">
    <button type="button" id="hidden_button" onclick="window.location.href = 'Controller?type=admin'"></button>
  </div>
</footer>
</body>
</html>