<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
  </style>
  <title>Title</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<article class="content">

</article>
<jsp:include page="footer.jsp"/>
</body>
</html>
