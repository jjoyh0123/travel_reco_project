<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Destination Picker</title>
  <style>
      .destination-picker-container {
          text-align: center;
          padding: 20px;
          font-family: Arial, sans-serif;
      }

      .destination-grid {
          display: grid;
          grid-template-columns: repeat(4, 1fr);
          gap: 15px;
          margin-top: 20px;
      }

      .destination {
          padding: 20px;
          background-color: #f1f1f1;
          border: 1px solid #ddd;
          border-radius: 10px;
          cursor: pointer;
          transition: transform 0.2s ease;
          text-align: center;
          font-size: 16px;
      }

      .destination:hover {
          background-color: #007BFF;
          color: white;
          transform: scale(1.05);
      }
  </style>
</head>
<body>
<div class="destination-picker-container">
  <h2>어디로 여행을 떠나시나요?</h2>
  <div class="destination-grid">
    <div class="destination" data-code="01" data-name="경기">경기</div>
    <div class="destination" data-code="02" data-name="강원">강원</div>
    <div class="destination" data-code="03" data-name="충북">충북</div>
    <div class="destination" data-code="04" data-name="충남">충남</div>
    <div class="destination" data-code="05" data-name="전북">전북</div>
    <div class="destination" data-code="06" data-name="전남">전남</div>
    <div class="destination" data-code="07" data-name="경북">경북</div>
    <div class="destination" data-code="08" data-name="경남">경남</div>
    <div class="destination" data-code="09" data-name="서울">서울</div>
    <div class="destination" data-code="10" data-name="인천">인천</div>
    <div class="destination" data-code="11" data-name="대전">대전</div>
    <div class="destination" data-code="12" data-name="대구">대구</div>
    <div class="destination" data-code="13" data-name="울산">울산</div>
    <div class="destination" data-code="14" data-name="부산">부산</div>
    <div class="destination" data-code="15" data-name="광주">광주</div>
    <div class="destination" data-code="16" data-name="제주">제주</div>
  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const destinations = document.querySelectorAll(".destination");

    destinations.forEach((destination) => {
      destination.addEventListener("click", function() {
        const selectedCode = this.getAttribute("data-code");
        const selectedName = this.getAttribute("data-name");

        alert(`선택된 여행지:` + selectedName);
        console.log(selectedCode);

        // Redirect with areaCode as a parameter
        window.location.href = "Controller?type=confirm&area_code=" + selectedCode;
            // + "&start_date="+ startDate + "&end_date=" + endDate;
        // window.location.href = 'Controller?type=destinationPicker';
      });
    });
  });
</script>
</body>
</html>
