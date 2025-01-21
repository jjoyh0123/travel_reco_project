<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>여행 기간 선택</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
  <link rel="stylesheet" href="www/css/styles.css">
  <style>
      body {
          font-family: 'Arial', sans-serif;
          background-color: #f8f9fa;
          margin: 0;
          padding: 0;
      }

      .date-picker-container {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          height: 100vh;
          text-align: center;
          background-color: white;
      }

      h2 {
          font-size: 24px;
          font-weight: bold;
          margin-bottom: 10px;
      }

      p {
          color: gray;
          font-size: 14px;
          margin-bottom: 20px;
      }

      #dateRange {
          width: 80%;
          max-width: 400px;
          padding: 10px;
          font-size: 16px;
          border: 1px solid #ddd;
          border-radius: 5px;
          margin-bottom: 20px;
      }

      #selectDates {
          background-color: #007BFF;
          color: white;
          padding: 10px 20px;
          font-size: 16px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          transition: background-color 0.3s ease;
      }

      #selectDates:hover {
          background-color: #0056b3;
      }
  </style>
</head>
<body>
<div class="date-picker-container">
  <h2>여행 기간이 어떻게 되시나요?</h2>
  <p>* 여행 일자는 최대 <strong>10일</strong>까지 설정 가능합니다.</p>
  <p>현재 여행 기간(여행지 도착 날짜, 여행지 출발 날짜)으로 입력해 주세요.</p>
  <input type="text" id="dateRange" name="dateRange" placeholder="YYYY-MM-DD ~ YYYY-MM-DD">
  <button id="selectDates">선택</button>
</div>

<script src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script>
  $(function () {
    $('#dateRange').daterangepicker({
      locale: {
        format: 'YYYY-MM-DD',
        separator: ' ~ ',
        applyLabel: '확인',
        cancelLabel: '취소',
        daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
      },
      maxSpan: { days: 10 },
      autoUpdateInput: false
    });

    $('#dateRange').on('apply.daterangepicker', function (ev, picker) {
      const startDate = picker.startDate.format('YYYY-MM-DD');
      const endDate = picker.endDate.format('YYYY-MM-DD');
      $(this).val(`${startDate} ~ ${endDate}`);
      sessionStorage.setItem('startDate', startDate);
      sessionStorage.setItem('endDate', endDate);
    });

    $('#dateRange').on('cancel.daterangepicker', function () {
      $(this).val('');
    });

    $('#selectDates').on('click', function () {
      const dateRange = $('#dateRange').val();
      if (dateRange) {
        window.location.href = 'Controller?type=destinationPicker';
      } else {
        alert('여행 기간을 선택해주세요.');
      }
    });
  });
</script>
</body>
</html>
