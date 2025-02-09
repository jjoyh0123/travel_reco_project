<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>1:1 문의</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
      body {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0;
          background-color: #F5F5F7;
      }
      .content{
          width: 900px;
          min-height: 600px;
          flex-grow: 1;
          margin-bottom: 20px;
      }

      .inquiry-container {
          background-color: #fff;
          border-radius: 12px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
          padding: 40px;
          width: 700px;
          max-width: 90%;
          text-align: center;
      }

      .inquiry-container h1 {
          font-size: 24px;
          margin-bottom: 10px;
          font-weight: bold;
      }

      .inquiry-container p {
          font-size: 12px;
          color: #666;
          margin-bottom: 20px;
      }

      .inquiry-container input[type="email"],
      .inquiry-container textarea {
          width: 100%;
          padding: 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-size: 14px;
          box-sizing: border-box;
          margin-bottom: 15px;
      }

      .inquiry-container textarea {
          height: 150px;
          resize: none;
      }

      .inquiry-container label {
          font-size: 13px;
          display: block;
          margin-bottom: 5px;
          text-align: left;
          font-weight: bold;
      }

      .required-text {
          color: #007bff;
          font-weight: bold;
      }

      .inquiry-container .btn-submit {
          width: 100%;
          padding: 12px;
          border: none;
          background-color: #ff7f50;
          color: white;
          font-size: 16px;
          border-radius: 4px;
          cursor: pointer;
      }

      .inquiry-container .btn-submit:disabled {
          background-color: #ddd;
          cursor: not-allowed;
      }

      .checkbox-area {
          text-align: left;
          font-size: 12px;
          margin-bottom: 20px;
      }

      .checkbox-area input {
          margin-right: 5px;
      }

      .checkbox-area p {
          margin: 0;
          color: #666;
          font-size: 12px;
      }

      .checkbox-area input[type="checkbox"] {
          margin-right: 8px;
          vertical-align: middle; /* 체크박스와 텍스트가 수직 정렬됨 */

      }


      .checkbox-wrapper {
          display: flex;
          align-items: center;
          font-size: 14px;
          font-weight: bold;
      }

      .checkbox-wrapper input[type="checkbox"] {
          margin-right: 8px;
      }

      .required-text {
          color: #007bff; /* 파란색 */
          font-weight: bold;

      }


  </style>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
<article class="content">

<div class="inquiry-container">
  <h1>이메일 문의하기</h1>
  <p class="p1_title">저희 zenZen Club 서비스에 대한 불편한 점, 개선할 점 등을 메일로 보내주세요.</p>

  <form id="inquiryForm" action="${pageContext.request.contextPath}/Controller?type=inquiry_submit" method="post">
    <label for="email">이메일 *</label>
    <input type="email" id="email" name="email" placeholder="이메일 주소를 입력하세요" required>

    <label for="title">제목 *</label>
    <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>

    <label for="content">내용 *</label>
    <textarea id="content" name="content" placeholder="문의 내용을 입력하세요" maxlength="1000" required></textarea>

    <div class="checkbox-area">
      <label class="checkbox-wrapper">
      <input type="checkbox" id="agree" name="agree" required>
        개인정보 수집 및 이용 동의 <span class="required-text">(필수)</span>
      </label>

      <p>
        1. 수집항목: 이메일<br>
        2. 수집목적: 문의자 확인, 문의에 대한 회신 등의 처리<br>
        3. 보유기간: 목적 달성 후 파기, 단, 관계법령에 따라 또는 회사 정책에 따른 정보보유사유가 발생하여 보존할 필요가 있는
        경우에는 필요한 기간 동안 해당 정보를 보관합니다. 전자상거래 등에서의 소비자 보호에 관한 법률, 전자금융거래법,
        통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우, 이 기간 동안 법령의 규정에 따라 개인정보를 보관 하며
        다른 목적으로는 절대 이용하지 않습니다. (개인정보처리방침 참고)<br>
        4. 귀하는 회사의 정보수집에 대해 동의하지 않거나 거부할 수 있습니다. 다만, 이때 원활한 문의 및 서비스 이용 등이 제한될 수 있습니다.

      </p>
    </div>

    <button type="submit" class="btn-submit" id="submitButton" disabled>메일 보내기</button>
  </form>
</div>

<script>
  const agreeCheckbox = document.getElementById('agree');
  const submitButton = document.getElementById('submitButton');

  // 동의 체크박스 상태에 따라 버튼 활성화/비활성화
  agreeCheckbox.addEventListener('change', function () {
    submitButton.disabled = !agreeCheckbox.checked;
  });

  // 폼 제출 이벤트 핸들러
  function handleFormSubmit() {
    alert("문의 접수가 완료되었습니다.");
    return true; // 폼이 정상적으로 제출되도록 반환
  }
</script>
</article>
</body>
</html>
