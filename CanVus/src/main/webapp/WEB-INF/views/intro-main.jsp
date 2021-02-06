<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/resources/css/intro.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
 
  	<script defer src="https://apis.google.com/js/platform.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	
    <title>Document</title>
</head>
<body>
	<div class="nav">
		<div>
			<img class="nav-image" alt="네비 기본사진" src="/resources/images/CanVus.PNG">
			<input class ="serch-image" type="text" placeholder="검색어 입력">
		</div>
		<div class="when-logged-in">
			
		</div>
	</div>
	
    <div class="container">
        <div class="contact-box">
            <div class="left">	<!-- 인트로 배경화면 부분 -->
            </div>
            <div class="right">
                <h2>Contact Us</h2>
                <button class="btn" onclick="clickLogin()">Google Login</button>	<!-- 구글 로그인은 몰어볼 것. -->
          
          
		        <div id="content_div" style="z-index:1; display:none;">
		          <div id="gLogin">
			          <div id="my-signin2" onclick="clickLogin()"></div>
		          </div>
		          <script src="https://apis.google.com/js/platform.js?onload=renderButton" defer></script>
		    	</div>
            </div>
        </div>
    </div>
    
    
<script type="text/javascript">
		var clicked = false;//Global Variable
		
	    function clickLogin() {
	        // Automatic Login deny!
	        clicked = true;
	        console.log('hi')
	    }
	    console.log(clicked)
	
	    function onSuccess() {
	        console.log("onSuccess 함수 작동");
	        
	        if (clicked) {
	            console.log("클릭한 경우라서 허용");
	            var auth2 = gapi.auth2.getAuthInstance();
	            
	            if (auth2.isSignedIn.get()) {
	                var profile = auth2.currentUser.get().getBasicProfile();
	                console.log('ID: ' + profile.getId());
	                console.log('Full Name: ' + profile.getName());
	                console.log('Given Name: ' + profile.getGivenName());
	                console.log('Family Name: ' + profile.getFamilyName());
	                console.log('Image URL: ' + profile.getImageUrl());
	                console.log('Email: ' + profile.getEmail());
	            }
	        } else {
	            console.log("클릭으로 로그인한 경우가 아니므로 비허용.");
	        }
	
	        const idToken = auth2.currentUser.get().getAuthResponse().id_token;
	
	        console.log(idToken);
	
	        var form = document.createElement("form");
	        form.setAttribute("charset", "UTF-8");
	        form.setAttribute("method", "Post"); // Get 또는 Post 입력
	        form.setAttribute("action", "/user/loginProcess");
	
	        var hiddenField = document.createElement("input");
	
	        hiddenField.setAttribute("type", "hidden");
	        hiddenField.setAttribute("name", "idToken");
	        hiddenField.setAttribute("value", idToken);
	        form.appendChild(hiddenField);
	
	        document.body.appendChild(form);
	
	        form.submit();
	    }
	
	    function onFailure(error) {
	        console.log(error);
	    }
	    function renderButton() {
	        gapi.signin2.render('#my-signin2', {
	            'scope': 'profile email',
	            'width': 200,
	            'height': 30,
	            'longtitle': false,
	            'theme': 'dark',
	            'onsuccess': onSuccess,
	            'onfailure': onFailure
	        });
	    }

		//화면 페이드아웃
		
		 	$(".container").click(function(){
		 		$(".share-pop").stop().fadeToggle(500);
		 	return false; //중요
		 });
		 //공유하기 팝업 외에 영역 클릭
		     $(document).click(function(e){ //문서 body를 클릭했을때
		 		if(e.target.className =="share-pop"){return false} //내가 클릭한 요소(target)를 기준으로 상위요소에 .share-pop이 없으면 (갯수가 0이라면)
		 		$(".share-pop").stop().fadeOut(500);
		 });

		 //
		 $('.serch-image').click(function(){
			alert('이미지검색');
		})
		</script>
</body>
</html>