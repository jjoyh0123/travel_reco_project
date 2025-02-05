<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>프로필관리</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <style>

      .logo {
          height: 50px;
          position: absolute;
          top: 20px;
          left: 20px;
      }

      .container {
          display: grid;
          grid-template-columns: 1fr;
          gap: 20px;
          width: 90%;
          max-width: 1000px;
          /* background: white; */
          padding: 0;
          border-radius: 15px;
          margin: 100px auto 50px auto;
      }
      .header {
          background-color: #ff7f50;
          color: white;
          padding: 20px;
          display: flex;
          align-items: center;
          justify-content: space-between;
          font-size: 22px;
          font-weight: bold;
          border-radius: 10px;
      }



      h1 {
          color: #1A1A1A;
          margin-top: 0px;
          padding: 20px;
      }


      .profile-form {
          padding: 10px 200px 0 470px;
          max-width: 600px;
          margin: 0 100px  100px;
      }


      .form-group input{
          width: 300px;
          height: 30px;
          border-radius: 5px;
          border: 1px solid;
          margin-bottom: 5px;
          gap: 3px;

      }

      /* 버튼 영역 */
      .profile-form .button-group {
          display: flex;
          gap: 10px;
          border-radius: 5px;
      }

      .profile-form .userDelete_btn{
          width: 305px;
          height: 30px;
          margin-top: 20px;
      }

      .profile-form .cancel_btn , .save_btn {
          width: 145px;
          height: 35px;
          margin-top: 15px;

      }

  </style>
</head>
<body>
<header>
  <a href="${pageContext.request.contextPath}/Controller"><img src="${pageContext.request.contextPath}/www/logo.png" class="logo" alt="로고"></a>
</header>
<div class="container">
  <!-- 닉네임 표시 조건 추가 -->
  <div class="header">
    <c:choose>
      <!-- 세션에 닉네임이 있을 경우 닉네임 출력 -->
      <c:when test="${not empty sessionScope.nick}">
        <div class="nickname-area">

          <div id="nicknameDisplay">
            <span id="nicknameText">${sessionScope.nick} 님!</span>
          </div>
        </div>
      </c:when>
    </c:choose>
  </div>
</div>
<div class="profile-form">
  <h1>프로필 설정</h1>
  <form id="updateProfile" action="${pageContext.request.contextPath}/Controller?type=updateProfile" method="post" onsubmit="validateProfileForm();">
      <div class="form-group">
        <label for="email">이메일주소</label><br/>
        <input type="text" id="email" name="email" value="${sessionScope.email}" disabled>
      </div>
      <div class="form-group">
        <label for="nickname">닉네임</label><br/>
        <input type="text" id="nickname" name="nickname" value="${sessionScope.nick}" required>
        <div id="nickname-message" class="error-message" style="display:none; color:red;"></div>
      </div>
      <div class="form-group">
        <label for="password">패스워드 변경</label><br/>
        <input type="password" id="password" name="password" value="${sessionScope.password}" required>
        <div id="password-message" class="error-message" style="display:none; color:red;"></div>
      </div>
    <div class="form-group">
      <label for="passwordConfirm">패스워드 변경 확인</label><br/>
      <input type="password" id="passwordConfirm" name="password" value="${sessionScope.password}" required>
      <div id="passwordConfirm-message" class="error-message" style="display:none; color:red;"></div>
    </div>

      <div class="button-group">
        <button type="button" class="userDelete_btn" onclick="if(confirm('정말 회원탈퇴 하시겠습니까?')) { window.location.href='${pageContext.request.contextPath}/'; }">회원탈퇴</button><br/>
      </div>
      <div class="button-group">
        <button type="button" class="cancel_btn" onclick="window.history.back();">취소</button>
        <button type="submit" class="save_btn" onclick="if (confirm('저장하시겠습니까?')) { window.location.href='${pageContext.request.contextPath}/Controller?type=updateProfile'; }">저장</button>
      </div>
    </form>
  </div>

<script>
  let isNicknameValid = false;
  let isPasswordValid = false;

  function validateNickname() {
    const nickname = document.getElementById("nickname").value;
    const nicknameMessage = document.getElementById("nickname-message");

    const nicknameRegex = /^[가-힣]+$/;

    if (nickname.length < 3) {
      nicknameMessage.textContent = "닉네임은 최소 3글자 이상이어야 합니다.";
      nicknameMessage.style.display = "block";
      nicknameMessage.style.color = "red";
      isNicknameValid = false;
      return false;
    }

    if (!nicknameRegex.test(nickname)) {
      nicknameMessage.textContent = "닉네임은 한글만 입력 가능합니다.";
      nicknameMessage.style.display = "block";
      nicknameMessage.style.color = "red";
      isNicknameValid = false;
      return false;
    }

    nicknameMessage.style.display = "none";
    isNicknameValid = true;
    return true;
  }

  function validatePassword() {
    const password = document.getElementById("password").value;
    const passwordConfirm = document.getElementById("passwordConfirm").value;
    const passwordMessage = document.getElementById("password-message");

    if (password.length < 4) {
      passwordMessage.textContent = "패스워드는 4자리 이상이어야 합니다.";
      passwordMessage.style.display = "block";
      passwordMessage.style.color = "red";
      isPasswordValid = false;
      return false;
    }

    if (password !== passwordConfirm) {
      passwordMessage.textContent = "패스워드가 일치하지 않습니다.";
      passwordMessage.style.display = "block";
      passwordMessage.style.color = "red";
      isPasswordValid = false;
      return false;
    }

    passwordMessage.style.display = "none";
    isPasswordValid = true;
    return true;
  }

  // 실시간 검증 이벤트 등록
  document.getElementById("nickname").addEventListener("input", validateNickname);
  document.getElementById("password").addEventListener("input", validatePassword);
  document.getElementById("passwordConfirm").addEventListener("input", validatePassword);

  // 폼 제출 시 전체 검증 확인
  document.getElementById("updateProfile").addEventListener("submit", function(event) {
    validateNickname();
    validatePassword();

    if (!isNicknameValid || !isPasswordValid) {
      event.preventDefault();  // 폼 제출 막기
      alert("입력 정보를 확인해주세요.");
    }
  });



</script>
</body>
</html>