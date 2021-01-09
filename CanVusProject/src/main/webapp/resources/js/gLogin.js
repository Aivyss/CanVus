//  ----▽ 구글 로그인 연결과 관련된 함수세트 ▽----

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
            
            document.getElementById("idToken").value = auth2.currentUser.get().id_token;
            const loginForm = document.getElementById("loginForm");
            loginForm.submit();
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
        'width': 50,
        'height': 50,
        'longtitle': true,
        'theme': 'dark',
        'onsuccess': onSuccess,
        'onfailure': onFailure
    });
}
//  ----△ 구글 로그인 연결과 관련된 함수세트 △----