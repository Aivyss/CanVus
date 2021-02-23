var clicked = false;//Global Variable

// 구글 로그인 버튼을 중앙으로 배치시키는 과정

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

$(()=> {
    gapi.signin2.render('my-signin2', {
        'scope': 'profile email',
        'width': 200,
        'height': 30,
        'longtitle': false,
        'theme': 'dark',
        'onsuccess': onSuccess,
        'onfailure': onFailure
    });



    try {
        alignCenter();
    } catch (e) {
        setTimeout(alignCenter, 500);
    }

    function alignCenter() {
        try {
            // 구글 로그인 버튼을 중앙으로 배치시키는 과정
            const children = $('#my-signin2').children();
            const firstChild = children.eq(0);
            const firstchildClassName = firstChild.attr('class');
            if (firstchildClassName == undefined) {
                throw "응 안만들어졌어";
            }
            const addClass = firstChild.addClass('center-block');
        } catch (e) {
            console.log(e);
            setTimeout(alignCenter, 500);
        }
    }
});