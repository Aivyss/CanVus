function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#photo-preview')
                .attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}

$(() => {
    // 동적인 데이터테이블 생성
    $('#payment-table').DataTable();
    $('#transaction-table').DataTable();

    // 프로필 수정 모달 팝업 이벤트
    $('#edit-profile-btn').on('click', () => {
        $('#edit-profile-modal').modal('toggle');
    });

    // 자기소개 수정 모달 팝업 이벤트
    $('#edit-intro-btn').on('click', () => {
        $('#edit-intro-modal').modal('toggle');
    });
    
    // 프로필 수정 실행 버튼 클릭 이벤트
    $('#execute-update-profile').on('click', () => {
        const form = $('#profile-form')[0];
        const formData = new FormData(form);

        $.ajax({
            url:'/user/updateProfile',
            type: 'post',
            enctype: 'multipart/form-data', // 파일 에젝스 전송시 필수
            processData: false, // 파일 에젝스 전송시 필수
            contentType: false, // 파일 에젝스 전송시 필수
            cache: false,
            data: formData,
            success: function () {
                alert("アップロードが出来ました！");
                $('#edit-profile-modal').modal('toggle');
            },
            error: function () {
                alert("アップロードがサーバー上の問題で出来ませんでした。");
            }
        });
    });
    
    // 자기소개 수정 실행 버튼 클릭 이벤트
    $('#execute-update-intro').on('click', () => {
        const intro = $('#intro-text').val();

        if (intro != undefined && intro != null &&  intro.length > 0) {
            const data = {
                intro : intro
            };

            $.ajax({
                url:'/user/updateIntro',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function () {
                    alert("自己紹介を修正しました！");

                    $('#edit-intro-modal').modal('toggle');
                },
                error: function () {
                    alert("修正がサーバー上の問題で出来ませんでした。");
                }
            });
        }
    });
});