<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
  </script>
  <style>
      body {
          margin: 0;
          padding: 0;
          display: flex;
          justify-content: center;
          align-items: center;
          flex-direction: column;
          min-height: 100vh;
      }

      .main_container{
          display: flex;
          align-items: flex-start;
          gap:20px;
          margin-top: 50px;
      }

      .content{
          margin-top: 100px;
          text-align: center;
          align-self: flex-start;
          padding-left: 50px;
          font-weight: bold;

      }

      .gif_content01{
          width: 550px;
          height: 400px;
          background-color: #ffff;
          border-radius: 30px;
          box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.2);
          display: flex;
          justify-content: center;
          align-items: center;
          margin-top: 20px;
          margin-bottom: 70px;

      }

      .gif_content02{
          width: 1100px;
          height: 400px;
          background-color: #ffff;
          border-radius: 30px;
          box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.2);
          display: flex;
          justify-content: center;
          align-items: center;
          margin-bottom: 50px;
      }


      .gif_content img{
          max-width: 100%;
          height: auto;
      }

      .content p {
          font-size: 1.2rem;
          margin-bottom: 20px;
          font-weight: bold;
      }

      .content h5{
          color: darkgray;
          text-align: center;
          margin-bottom: 20px;
      }

      .plan_btn01{
          font-size: 20px;
          border-radius: 30px;
          background-color : #FF7F50;
          color: #ffffff;
          border: none;
          padding: 20px;
          margin: 20px 20px 20px 20px;
          box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.2);
      }

      .plan_btn02{
          font-size: 20px;
          border-radius: 30px;
          background-color : #ffffff;
          color: #000000;
          border: none;
          padding: 20px;
          margin: 20px 20px 20px 20px;
          box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.2);
      }

  </style>
  <title>메인 홈 페이지</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="main_container">
<article class="content">
  <h3>for all your travel planning</br>
    needs</h3>
  <h5>Create detailed itineraries, explore user-shared</br>
    guides, and manage your bookings seamlessly —</br>
    all in one place.</h5>
  <button type="button" class="plan_btn01">계획 추천받기</button>
  <button type="button" class="plan_btn02">계획 세우기</button>
  메인 내용
<a href="/Controller?type=notice">dfdf</a>
</article>
  <div class="gif_content01">
    Gif로 홈페이지 사용법 및 best planner 이벤트 소개
  </div>

</div>

<div class="gif_content02">
  Gif로 홈페이지 사용법 및 best planner 이벤트 소개
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>