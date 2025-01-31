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
<form id="uploadForm" enctype="multipart/form-data">
  <input type="hidden" name="content_type" value="journal">
  <input type="hidden" name="user_idx" value="123">
  <input type="hidden" name="journal_idx" value="456">
  <input type="file" name="file" multiple><br><br>
  <input type="button" value="Upload" onclick="uploadImages()">
</form>

<div id="result"></div>

<script>
  function uploadImages() {
    var form = $('#uploadForm')[0];
    var formData = new FormData(form);  

    $.ajax({
      url: 'http://3.39.251.247:8080/Controller?type=upload',
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        if (response.status === 'success') {
          // 결과 메시지 표시
          const resultDiv = document.getElementById('result');
          let fileNamesHtml = '<ul>';
          for (let i = 0; i < response.fileNames.length; i++) {
            fileNamesHtml += '<li>' + response.fileNames[i] + '</li>';
          }
          fileNamesHtml += '</ul>';
          resultDiv.innerHTML = `<p>${response.message}</p><p>업로드된 파일 목록:</p>` + fileNamesHtml;
        } else {
          alert('Error: ' + response.message);
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