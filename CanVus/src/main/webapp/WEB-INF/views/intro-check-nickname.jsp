<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/resources/css/intro.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
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
				 <!--  <div style="position: relative; left:10px; top: -70px; z-index: 1;">		썸내일 연습해보기 위한 것.
					  <a target="_blank" href="img_forest.jpg">
						  <img src="img_forest.jpg" alt="Forest">
					  </a>
				  </div> -->
				  
				  <div style="position: relative; left:2px; top: -70px; z-index: 1;">		<!-- 이미지 맨 앞으로 나오게 하기 위해서(z-index) 나중에 style sheet으로 옮길 것. -->
				  	<img id="preview" alt="로컬에 있는 이미지가 보여지는 영역" src="" width="200">
				  </div>
				  
				  <input type="file" id="getfile" class="input_file btn" accept=".png, .jpg" title="파일찾기">
				</div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
		function doubleCheck(){
			alert('오류메시지 작성');
		}

		/*https://programmingsummaries.tistory.com/367*/
	 	var file = document.querySelector('#getfile');
	 	console.log(file);

	 	file.onchange = function () {
	 	    var fileList = file.files ;

	 	    // 읽기
	 	    var reader = new FileReader();
	 	    reader.readAsDataURL(fileList [0]);

	 	    //로드 한 후
	 	    reader.onload = function  () {
	 	        //로컬 이미지를 보여주기
	 	        document.querySelector('#preview').src = reader.result;
	 	    };
	 	};
 	</script>
</body>
</html>