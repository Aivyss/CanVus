$(() => {
    $('#pwCheck').on('click', () => {
        const data={
            "pwWrttenByUser" : $("#inputPassword5").val(),
            "room_Id" : room_Id
        };

        $.ajax({

            url : "/drawing/passwordCheck",
            type : "POST",
            dataType : "json",
            contentType : "application/json",
            data : JSON.stringify(data),
            success : function(result) {
                if(result["result"] == "success") {
                    console.log("성공");
                    sessionStorage.setItem('pwWrttenByUser', $("#inputPassword5").val());
                    location.href="/drawing/room/?room_Id="+room_Id;

                }else {
                    alert("비밀번호가 틀렸습니다");
                }
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    });
});