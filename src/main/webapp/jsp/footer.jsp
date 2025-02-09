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

      .close {
          color: #aaa;
          float: right;
          font-size: 28px;
          font-weight: bold;
          cursor: pointer;
      }

      #passwordInput {
          width: 80%;
          padding: 5px;
          margin-top: 10px;
          font-size: 16px;
          text-align: center;
      }

      #confirmButton {
          margin-top: 10px;
          padding: 5px 10px;
          font-size: 16px;
          cursor: pointer;
      }

      #errorMsg {
          color: red;
          font-size: 14px;
          display: none;
          margin-top: 10px;
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
    <p>
      <a href="#">이용약관</a> |
      <a href="#">개인정보처리방침</a> |
      <a href="#">고객지원</a> |
      <a href="#">1:1 문의</a>
    </p>
    <br/>
    <br/>
    <p>Copyright &copy; Zenzen Club All Rights Reserved.</p>
  </div>

  <!-- 숨겨진 버튼 -->
  <div id="hidden_place">
    <button type="button" id="hidden_button" data-bs-toggle="modal" data-bs-target="#passwordModal"></button>
  </div>
</footer>

<!-- 모달 -->
<div class="modal" id="passwordModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">관리자 인증</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <h2>비밀번호 입력</h2>
        <input type="password" id="passwordInput" maxlength="6" placeholder="6자리 숫자 입력">
        <button id="confirmButton">확인</button>
        <p id="errorMsg">비밀번호가 틀렸습니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script>
  document.getElementById("confirmButton").addEventListener("click", function () {
    var inputVal = document.getElementById("passwordInput").value;
    if (inputVal === "123456") {
      window.location.href = "Controller?type=admin";
    } else {
      document.getElementById("errorMsg").style.display = "block";
    }
  });
</script>

</body>
</html>
