<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
  페이지 이탈 테스트
  <script>
    window.addEventListener('beforeunload', send_leave_info_to_server);
    window.addEventListener('popstate', send_leave_info_to_server);

    function send_leave_info_to_server() {
      const data = {
        type: "leave",
        user_idx: "test123"
      };
      const blob = new Blob([JSON.stringify(data)], {type: 'application/json'});
      navigator.sendBeacon('${pageContext.request.contextPath}/Controller?type=test', blob);
    }
  </script>
</body>
</html>
