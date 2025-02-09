<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>여행 계획 확인</title>
  <style>
      body {
          font-family: Arial, sans-serif;
          background-color: #f8f9fa;
          padding: 20px;
      }

      .container {
          max-width: 600px;
          margin: 0 auto;
          background-color: #fff;
          border: 1px solid #ddd;
          border-radius: 10px;
          padding: 20px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      h2 {
          text-align: center;
          margin-bottom: 20px;
      }

      .details {
          margin-bottom: 20px;
      }

      .details p {
          font-size: 16px;
          margin: 10px 0;
      }

      .buttons {
          text-align: center;
      }

      button {
          padding: 10px 20px;
          font-size: 16px;
          margin: 10px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
      }

      .btn-confirm {
          background-color: #007bff;
          color: white;
      }

      .btn-confirm:hover {
          background-color: #0056b3;
      }

      .btn-cancel {
          background-color: #dc3545;
          color: white;
      }

      .btn-cancel:hover {
          background-color: #a71d2a;
      }
  </style>
</head>
<body>
<div class="container">
  <h2>여행 계획 확인</h2>

  <!-- Travel details -->
  <div class="details">
    <p><strong>출발 날짜:</strong> ${sessionScope.startDate}</p>
    <p><strong>도착 날짜:</strong> ${sessionScope.endDate}</p>
    <p><strong>여행지:</strong>
      <c:choose>
        <c:when test="${param.area_code == '01'}">경기</c:when>
        <c:when test="${param.area_code == '02'}">강원</c:when>
        <c:when test="${param.area_code == '03'}">충북</c:when>
        <c:when test="${param.area_code == '04'}">충남</c:when>
        <c:when test="${param.area_code == '05'}">전북</c:when>
        <c:when test="${param.area_code == '06'}">전남</c:when>
        <c:when test="${param.area_code == '07'}">경북</c:when>
        <c:when test="${param.area_code == '08'}">경남</c:when>
        <c:when test="${param.area_code == '09'}">서울</c:when>
        <c:when test="${param.area_code == '10'}">인천</c:when>
        <c:when test="${param.area_code == '11'}">대전</c:when>
        <c:when test="${param.area_code == '12'}">대구</c:when>
        <c:when test="${param.area_code == '13'}">울산</c:when>
        <c:when test="${param.area_code == '14'}">부산</c:when>
        <c:when test="${param.area_code == '15'}">광주</c:when>
        <c:when test="${param.area_code == '16'}">제주</c:when>
        <c:otherwise>알 수 없음</c:otherwise>
      </c:choose>
    </p>
    <p><strong>지역 코드:</strong> ${param.area_code}</p>
  </div>

  <!-- Buttons -->
  <div class="buttons">
    <form action="Controller" method="post">
      <input type="hidden" name="type" value="confirmation">
      <input type="hidden" name="area_code" value="${param.area_code}">
      <button type="submit" class="btn-confirm">확인</button>
    </form>
    <button class="btn-cancel" onclick="window.history.back()">취소</button>
  </div>
</div>
</body>
</html>
