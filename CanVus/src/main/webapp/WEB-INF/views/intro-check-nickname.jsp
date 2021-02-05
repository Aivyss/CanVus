<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/resources/css/intro.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
  	<script defer="defer" type="text/javascript" src="/resources/js/app.js">
 	</script>
 	<script type="text/javascript">
		function doubleCheck(){
			alert('오류메시지 작성');
		}
 	</script>
    <title>Intro</title>
</head>
<body>
    <div class="container">
        <div class="contact-box">
            <div class="left">
            </div>
            <div class="right">
                <h2>Fill in the info</h2>
                <input type="text" class="field" placeholder="닉네임을 입력해주세요">
                <input type="button" value="중복검사" class = "btn" onclick="doubleCheck()">
                <textarea class="field area" placeholder="Message"></textarea>
               
                <div class="upload-btn_wrap">
				  <button type="button" title="파일찾기">
				  	<span>프로필 사진</span>  
				  </button>
				  <img id="preview" alt="로컬에 있는 이미지가 보여지는 영역" src="" width="200">
				  <input type="file" id="getfile" class="input_file btn" accept=".png, .jpg" title="파일찾기">
				</div>
            </div>
        </div>
    </div>
</body>
</html>