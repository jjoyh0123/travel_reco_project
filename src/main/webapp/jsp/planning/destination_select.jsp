<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Destination Picker</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/planning/destination_select.css">
</head>
<body>
<div class="destination-picker-container">
  <h2>어디로 여행을 떠나시나요?</h2>
  <div class="destination-grid">
    <div class="destination" data-area-code="01" data-area-name="경기">경기</div>
    <div class="destination" data-area-code="02" data-area-name="강원">강원</div>
    <div class="destination" data-area-code="03" data-area-name="충북">충북</div>
    <div class="destination" data-area-code="04" data-area-name="충남">충남</div>
    <div class="destination" data-area-code="05" data-area-name="전북">전북</div>
    <div class="destination" data-area-code="06" data-area-name="전남">전남</div>
    <div class="destination" data-area-code="07" data-area-name="경북">경북</div>
    <div class="destination" data-area-code="08" data-area-name="경남">경남</div>
    <div class="destination" data-area-code="09" data-area-name="서울">서울</div>
    <div class="destination" data-area-code="10" data-area-name="인천">인천</div>
    <div class="destination" data-area-code="11" data-area-name="대전">대전</div>
    <div class="destination" data-area-code="12" data-area-name="대구">대구</div>
    <div class="destination" data-area-code="13" data-area-name="울산">울산</div>
    <div class="destination" data-area-code="14" data-area-name="부산">부산</div>
    <div class="destination" data-area-code="15" data-area-name="광주">광주</div>
    <div class="destination" data-area-code="16" data-area-name="제주">제주</div>
  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const destinations = document.querySelectorAll(".destination");

    destinations.forEach((destination) => {
      destination.addEventListener("click", function () {
        const selected_area_code = this.getAttribute("data-area-code");
        const selected_area_name = this.getAttribute("data-area-name");

        alert("선택된 여행지는 " + selected_area_name + " 입니다.");

        sessionStorage.setItem('area_cde', selected_area_code);
        location.href = "Controller?type=planning&action=confirm";
      });
    });
  });
</script>
</body>
</html>
