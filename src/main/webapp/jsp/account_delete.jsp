<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<h1>회원 탈퇴가 완료되었습니다.</h1>
<p>그동안 서비스를 이용해 주셔서 감사합니다.</p>

<script>
  function handleWithdrawal() {
    if (confirm("정말로 회원 탈퇴를 진행하시겠습니까?")) {
      // 탈퇴 요청을 서버로 전송 (GET 방식 또는 POST 방식)
      window.location.href = "${pageContext.request.contextPath}/Controller?type=accountDelete";
    }
  }
</script>
</body>
</html>
