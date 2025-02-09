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
    <div class="destination" data-area-code="1" data-area-name="서울">서울</div>
    <div class="destination" data-area-code="2" data-area-name="인천">인천</div>
    <div class="destination" data-area-code="3" data-area-name="대전">대전</div>
    <div class="destination" data-area-code="4" data-area-name="대구">대구</div>
    <div class="destination" data-area-code="5" data-area-name="광주">광주</div>
    <div class="destination" data-area-code="6" data-area-name="부산">부산</div>
    <div class="destination" data-area-code="7" data-area-name="울산">울산</div>
    <div class="destination" data-area-code="8" data-area-name="세종">세종</div>
    <div class="destination" data-area-code="31" data-area-name="경기">경기</div>
    <div class="destination" data-area-code="32" data-area-name="강원">강원</div>
    <div class="destination" data-area-code="33" data-area-name="충북">충북</div>
    <div class="destination" data-area-code="34" data-area-name="충남">충남</div>
    <div class="destination" data-area-code="35" data-area-name="경북">경북</div>
    <div class="destination" data-area-code="36" data-area-name="경남">경남</div>
    <div class="destination" data-area-code="37" data-area-name="전북">전북</div>
    <div class="destination" data-area-code="38" data-area-name="전남">전남</div>
    <div class="destination" data-area-code="39" data-area-name="제주">제주</div>
  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const destinations = document.querySelectorAll(".destination");

    destinations.forEach((destination) => {
      destination.addEventListener("click", function() {
        const selected_area_code = this.getAttribute("data-area-code");
        const selected_area_name = this.getAttribute("data-area-name");

        alert("선택된 여행지는 " + selected_area_name + " 입니다.");

        sessionStorage.setItem('area_code', selected_area_code);
        location.href = "${pageContext.request.contextPath}/Controller?type=planning&action=planning";
      });
    });
  });
</script>
</body>
</html>
