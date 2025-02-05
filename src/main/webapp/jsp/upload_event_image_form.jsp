<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Image Upload</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>Image Upload</h1>
<form id="uploadForm" enctype="multipart/form-data">
  <input type="hidden" name="type" value="delete">
  <input type="hidden" name="idx" value="3">
  <input type="file" name="file" multiple><br><br>
  <input type="button" value="Upload" onclick="uploadImages()">
</form>

<button type="button" onclick="switch_type()">switch</button>

<div id="result"></div>

<script>
  function uploadImages() {
    let form = $('#uploadForm')[0];
    let formData = new FormData(form);
    let param = {
      url: 'http://${applicationScope.publicIP}:8080/Controller?type=upload_event_image',
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        if (response.status === 'success') {
          // 결과 메시지 표시
          const resultDiv = document.getElementById('result');
          let file_name_html = '<ul>';
          file_name_html += '<li>';
          if (response.message === "파일 업로드 완료!") {
            file_name_html += '<li>' + 'http://${applicationScope.publicIP}:4000/' + response.upload_image_path + '</li>';
          } else {
            file_name_html += '<li>' + response.upload_image_path + '</li>';
          }
          file_name_html += '</ul>';
          resultDiv.innerHTML = `<p>${response.message}</p><p>업로드된 파일 경로:</p>` + file_name_html;
        } else {
          alert('Error: ' + response.message);
        }
      },
      error: function (xhr, status, error) {
        alert('Error: ' + error);
      }
    }
    console.log(param);
    console.log("${applicationScope.publicIP}");

    $.ajax(param);
  }

  function switch_type() {
    let $type = $("input[name='type']");
    if ($type.val() === 'delete') {
      $type.val("modify");
    } else {
      $type.val("delete");
    }
    console.log("switch to " + $type.val());
  }
</script>
</body>
</html>