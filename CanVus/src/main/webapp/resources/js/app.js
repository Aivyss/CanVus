//  ----▽ 로그인 패널과 관련된 함수세트 ▽----
$(document).ready(function () { // 홈페이지가 동작하자마자 작동하도록 해준다.

    console.log("버튼클릭 감지 및 처리");
    var maskHeight = document.body.offsetHeight;
    $("#mask").css({ 'width': '100%', 'height': '100%' });
    $('#mask').fadeTo('slow', 0.3);

    var dialog = $('#content_div');
    var left = ($(window).scrollLeft() + ($(window).width() - dialog.width()) / 2);
    var top = ($(window).scrollTop() + ($(window).height() - dialog.height()) / 2);
    dialog.css({ 'left': left, 'top': top });
    dialog.show();

    $('#mask').click(function () {
        console.log("마스크 클릭 감지 및 처리");
        $('#mask').hide();
        $('#content_div').hide();
    });
});

function resize_slide() {
    var width = $(document).width();
    var height = $(docuemnt).height();
    var dialog = $('#content_div');
    var top = $(window).scrollTop() + ($(windwo).height() - dialog.height()) / 2;
    dialog.css({ 'top': top, 'left': width / 2 - 150 });
}
//  ----△ 로그인 패널과 관련된 함수세트 △----

//로그인 처리
  var clicked = false;//Global Variable
	
	         function clickLogin() {
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
