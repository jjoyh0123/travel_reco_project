<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Image Upload</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>Image Upload</h1>
<form id="upload_form" enctype="multipart/form-data">
  <input type="text" name="type" placeholder="type: journal or review"><br> <%-- value journal / review --%>
  <input type="text" name="user_idx" placeholder="user_idx"><br>
  <input type="text" name="plan_idx" placeholder="plan_idx, when type journal"><br>
  <input type="text" name="place_idx" placeholder="place_idx when type review"><br>
  <input type="file" name="file" multiple><br><br>
  <input type="button" value="Upload" onclick="upload_images()">
</form>

<div id="result"></div>

<script>
  function upload_images() {
    var form = $('#upload_form')[0];
    var form_data = new FormData(form);

    $.ajax({
      url: 'http://${applicationScope.publicIP}:8080/Controller?type=upload_image',
      type: 'POST',
      data: form_data,
      processData: false,
      contentType: false,
      success: function (response) {
        if (response.status === 'success') {
          // 결과 메시지 표시
          const result_div = document.getElementById('result');
          result_div.innerHTML = '';
          let image_names_html = '<ul>';
          for (let i = 0; i < response.image_names.length; i++) {
            image_names_html += '<li>' + 'http://${applicationScope.publicIP}' + response.image_names[i] + '</li>';
          }
          image_names_html += '</ul>';
          result_div.innerHTML = `<p>${response.message}</p><p>업로드된 파일 목록:</p>` + image_names_html;
        } else {
          // alert('Error: ' + response.message);
          result_div.innerHTML = `<p>${response.status}</p>`;
          result_div += `<p>${response.message}</p>`;
        }
      },
      error: function (xhr, status, error) {
        alert('Error: ' + error);
      }
    });
  }
</script>
</body>
</html>