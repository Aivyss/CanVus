function pagenation(title, pageNo, totalPage) {
    pageNo = parseInt(pageNo);
    totalPage = parseInt(totalPage);

    if (pageNo == 0) {
        alert("最初のページです。");
    } else if (pageNo > totalPage) {
        alert("最後のページです。");
    } else {
        location.href=`/browse/list/?title=${title}&page=${pageNo}`;
    }
}

$(() => {
    /******************************** 호이스팅 함수부 ************************************/
    function doSearchRoom(searchTitle, pageNo) {
        location.href = `/browse/list/?title=${searchTitle}&page=${pageNo}`;
    }


    /******************************* 이벤트 등록부 *************************************/
    $('#room-search-text').keydown(function (key) {
        if (key.keyCode == 13) {
            const keyword = $('#room-search-text').val();

            if (keyword.length != 0) {
                doSearchRoom(keyword, 1);
                $('#room-search-text').val("");
            }
        }
    });

    // 방입장 버튼 클릭 이벤트
    $('.entrance-btn-container').on('click', function(event) {
        let targetId = event.target.id;
        targetId = targetId.split('make-bookmark-btn-')[1];

        const password = $(`#room-pw-container-${targetId}`).val();
        const title = $(`#room-title-container-${targetId}`).text();
        if(password != null && password != undefined && password.length != 0) {
            // 모달에 비밀번호와 방 아이디를 삽입하는 프로세스
            $('#room-modal-exact-pw').val(password);
            $('#room-modal-id').val(targetId);
            // 모달에 방 타이틀을 삽입하는 프로세스
            $('#modal-room-title').text(title);
            // 모달을 화면상에 보이게 하는 프로세스
            $('#enter-modal').modal('toggle');
        } else {
            location.href=`/drawing/room?room_Id=${targetId}`;
        }
    });

    // 모달 execute 이벤트 비밀번호 확인 후 입장한다.
    $('#execute-enter-room').click(function(){
        const exact_pw = $('#room-modal-exact-pw').val();
        const written_pw = $('#input-room-password').val();
        const room_id = $('#room-modal-id').val();

        if(exact_pw === written_pw) {
            sessionStorage.setItem('pwWrttenByUser', written_pw);
            location.href=`/drawing/room/?room_Id=${room_id}`;
        } else {
            alert("パスワードが一致されていません。");
        }
    });
});

