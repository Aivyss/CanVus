function executeEntrance() {
    const pwWrttenByUser = $("#pwCheck").val();

    if (pwWrttenByUser == null || pwWrttenByUser == undefined || pwWrttenByUser.length <= 0) {
        alert("パスワードを入力てください。");
        return false;
    }

    const data = {
        "pwWrttenByUser": pwWrttenByUser,
        "room_Id": room_Id
    };

    $.ajax({
        url: "/drawing/passwordCheck",
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function (result) {
            if (result["result"] == "success") {
                console.log("성공");
                //sessionStorage.setItem('pwWrttenByUser', pwWrttenByUser);
                location.href = "/drawing/room/?room_Id=" + room_Id;

            } else {
                alert("パスワードが違いますので、入室ができませんでした。");
            }
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

$(() => {
    //*********** 이벤트 파트 ***************//
    // 들어오자마자 모달을 띄워준다.
    if (wrttenPw == null || wrttenPw == undefined || wrttenPw.length <=0) {
        $('#entrance-modal').modal('show');
    }

    $('#execute-entrance').on('click', () => {
        executeEntrance();
    });

    $('#pwCheck').keydown(function (key) {
        if (key.keyCode == 13) {
            executeEntrance();
        }
    });

    $('#cancel-entrance').on('click', ()=>{
        location.href="/";
    });
});