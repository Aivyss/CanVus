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
	<script src="/resources/js/app.js"></script>
	<script type="text/javascript">

	</script>
    <title>Document</title>
</head>
<body>
    <div class="container">
        <div class="contact-box">
            <div class="left">	<!-- 인트로 배경화면 -->
            </div>
            <div class="right">
                <h2>Contact Us</h2>
                <input type="text" class="field" placeholder="ID">
                <input type="password" class="field" placeholder="Password">
                
            	<button class="btn">Sign Up</button>
                <button class="btn">LogIn</button>
                <button class="btn" onclick="ClickLogin()">Google Login</button>	<!-- 구글 로그인은 몰어볼 것. -->
          
		        <div id="content_div" style="z-index:150; display:none;">
		          <div id="gLogin">
			          <div id="my-signin2" onclick="ClickLogin()"></div>
		          </div>
		          <script src="https://apis.google.com/js/platform.js?onload=renderButton" defer></script>
		    	</div>
            </div>
        </div>
    </div>

</body>
</html>