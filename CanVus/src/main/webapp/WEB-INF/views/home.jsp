<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<title>Home</title>
		<meta name="google-signin-client_id" content="1073968802049-evh62jql0f6gblp8din0t6rqv0sobg17.apps.googleusercontent.com">
		<script defer src="https://apis.google.com/js/platform.js"></script>
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="/resources/js/app.js"></script>
        <link rel="stylesheet" href="/resources/css/style.css">
	</head>
	
	<body>
	<!--▽ 로그인을 위한 가림패널 ▽ -->
	<div id="mask" style="z-index:100;">
    </div>
    
    <div id="content_div" style="z-index:150; display:none;">
		  <img id="loginLogo" src="/resources/images/CanVus.PNG"> <!-- 나중에 div에 이미지 넣는게 더 나으니 부탁함. -->
          <div>最高の絵を描きましょう。</div>
          <div id="gLogin">
	          <div id="my-signin2" onclick="ClickLogin()"></div>
          </div>
          <script src="https://apis.google.com/js/platform.js?onload=renderButton" defer></script>
    </div>
	<!--▲ 로그인을 위한 가림패널 ▲ -->	
	
	
	<!-- 플로팅 배너를 위한 div -->
	<div class="header">
		<img class="Logo" src="/resources/images/CanVus.PNG">
		<button class="searchBtn"></button>
		<input type="text" class="searchCntnr">
	</div>	
		
		
		
		<h1>테스트란</h1>
		<ul>
			<li><a href="/payment/module">결제창으로 이동</a></li>
			<li><a href="/user/loginForm">로그인 창으로 이동</a></li>
			<li><a href="/search/imageSearch">이미지 서칭</a></li>
			<li><a href="main">메인이동</a></li>
		</ul>
				
				
				
				
				
         <script type="text/javascript">
	         var clicked = false;//Global Variable
	
	         function ClickLogin() {
	             // Automatic Login deny!
	             clicked = true;
	         }
	
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
	         }
	
	         function onFailure(error) {
	             console.log(error);
	         }
	         function renderButton() {
	             gapi.signin2.render('my-signin2', {
	                 'scope': 'profile email',
	                 'width': 200,
	                 'height': 30,
	                 'longtitle': false,
	                 'theme': 'dark',
	                 'onsuccess': onSuccess,
	                 'onfailure': onFailure
	             });
	         }
        </script>
	
		</body>
</html>
