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
        
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style type="text/css">
img { 
	display: block; 
	margin: 0px auto;
}
.header{
	margin-top:100px;
}

.join{
	margin-left:20px;
}

.row1{
	margin-top:50px;
	margin-right:100px;
}

.row2{
	margin: 0px auto;
	top:50px;
	left:150px; 
}


.over { 
	position:absolute; 
	top:250px; 
	left:410px; 
	width:1100px; 
	height:500px; 
	background-color: rgba( 255, 255, 255, 0.5 ); 
	align:center;  
	line-height:300px;
	z-index: 1;
}

.Logo {cursor:pointer;}

</style>
<script type="text/javascript">
function imageSearch(){
	location.href="/search/imageSearch";
}
function loginForm(){
	location.href="/user/loginForm";
}
function module(){
	location.href="/payment/module";
}
function main(){
	location.href="/main";
}
function home(){
	location.href="/";
}

function showPopup() { 
	window.open("08_2_popup.html", "a", "width=400, height=300, left=100, top=50"); 
}
</script>
	</head>
	
	<body>
	
	<!--▽ 로그인을 위한 가림패널 ▽ -->
	<div id="mask" style="z-index:100;">
    </div>
    
    <div id="content_div" style="z-index:150; display:none;">
		  <img id="loginLogo" src="/resources/images/CanVus.PNG"> <!-- 나중에 div에 이미지 넣는게 더 나으니 부탁함. -->
          <div>最高の絵を描きましょう。</div>
          <br>
          <div class="join">
			<button type="button" class="btn btn-danger wrn-btn" onclick="ClickLogin();">Join us</button>
          </div>
          <div id="gLogin">
	          <div id="my-signin2" onclick="ClickLogin()"></div>
          </div>
          <script src="https://apis.google.com/js/platform.js?onload=renderButton" defer></script>
    </div>
	<!--▲ 로그인을 위한 가림패널 ▲ -->	
	
	
	<div class="over">
	<div class="container">
	    <div class="row pt-1 pb-1">
	        <div class="col-lg-12">
	            <div class="header">
					<img class="Logo" src="/resources/images/CanVus.PNG" onclick="home();">
				</div>
			</div>
	    </div>
	</div>
	<section class="search-sec">
    <div class="container">
        <form action="#" method="post" novalidate="novalidate">
            <div class="row1">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                            <input type="text" class="form-control search-slt" placeholder="Search...">
                        </div>
                        <div class="row3 col-lg-3 col-md-3 col-sm-12 p-0">
                            <select class="form-control search-slt" id="exampleFormControlSelect1">
                                <option>Select Option</option>
                                <option>유저 검색</option>
                                <option>태그 검색</option>
                            </select>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                            <button type="button" class="btn btn-danger wrn-btn">Search</button>
                        </div>
                        <div class="row2 col-lg-3 col-md-3 col-sm-12 p-0">
                            <button type="button" class="btn btn-danger wrn-btn" onclick="imageSearch();">Search by img</button>
                        </div>
                        <div class="row2 col-lg-3 col-md-3 col-sm-12 p-0">
                            <button type="button" class="btn btn-danger wrn-btn" onclick="loginForm();">&nbsp&nbspLogin&nbsp&nbsp</button>
                        </div>
                        <div class="row2 col-lg-3 col-md-3 col-sm-12 p-0">
                            <button type="button" class="btn btn-danger wrn-btn" onclick="module();">&nbsp&nbsp결제창으로&nbsp&nbsp</button>
                        </div>
                        <div class="row2 col-lg-3 col-md-3 col-sm-12 p-0">
                            <button type="button" class="btn btn-danger wrn-btn" onclick="main();">&nbsp&nbspMain&nbsp&nbsp</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
<br>
</div>
<section>
    <div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://wallpaperaccess.com/full/1141048.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="https://wallpaperaccess.com/full/2334146.jpg" class="d-block w-100" alt="...">
            </div>
           
            <div class="carousel-item">
                <img src="https://wallpaperaccess.com/full/2334166.jpg" class="d-block w-100" alt="...">
            </div>
       
            <!--https://upload.wikimedia.org/wikipedia/commons/8/8d/Yarra_Night_Panorama%2C_Melbourne_-_Feb_2005.jpg-->
        </div>
        <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</section>

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
