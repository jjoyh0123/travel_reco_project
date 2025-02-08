<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>여행 기간 선택</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/planning/date_select.css">
</head>
<body>
<div class="date-picker-container">
  <h2>여행 기간이 어떻게 되시나요?</h2>
  <p>* 여행 일자는 최대 <strong>10일</strong>까지 설정 가능합니다.</p>
  <p>현재 여행 기간(여행지 도착 날짜, 여행지 출발 날짜)으로 입력해 주세요.</p>
  <input type="text" id="date_range" name="date_range" placeholder="YYYY-MM-DD ~ YYYY-MM-DD">
  <button id="select_dates">선택</button>
</div>

<script src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script>
  let start_date = null;
  let end_date = null;

  $(function() {
    $('#date_range').daterangepicker({
      locale: {
        format: 'YYYY-MM-DD',
        separator: ' ~ ',
        applyLabel: '확인',
        cancelLabel: '취소',
        daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
      },
      maxSpan: { days: 9 },
      autoUpdateInput: false
    }).on('apply.daterangepicker', function (ev, picker) {
      start_date = picker.startDate.format('YYYY-MM-DD');
      end_date = picker.endDate.format('YYYY-MM-DD');
      $(this).val(start_date + ' ~ ' + end_date);
    }).on('cancel.daterangepicker', function() {
      $(this).val('');
    });

    $('#select_dates').on('click', function() {
      let date_range = $('#date_range').val();
      if (date_range) {
        sessionStorage.setItem('start_date', start_date);
        sessionStorage.setItem('end_date', end_date);
        window.location.href = "${pageContext.request.contextPath}/Controller?type=planning&action=destination_select";
      } else {
        alert('여행 기간을 선택해주세요.');
      }
    });
  });
</script>
</body>
</html>
