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