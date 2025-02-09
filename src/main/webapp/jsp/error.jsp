<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
  Error!
  <script>
    setTimeout(function(){
      location.href = "${pageContext.request.contextPath}/Controller?type=index"
    }, 2000);
  </script>
</body>
</html>
