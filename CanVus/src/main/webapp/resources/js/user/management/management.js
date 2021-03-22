function getExtensionOfFilename2(filename) {
    const _fileLen = filename.length;
    /**
     * lastIndexOf('.')
     * 뒤에서부터 '.'의 위치를 찾기위한 함수
     * 검색 문자의 위치를 반환한다.
     * 파일 이름에 '.'이 포함되는 경우가 있기 때문에 lastIndexOf() 사용
     */
    const _lastDot = filename.lastIndexOf('.');

    // 확장자 명만 추출한 후 소문자로 변경
    const _fileExt = filename.substring(_lastDot, _fileLen).toLowerCase();

    return _fileExt;
}

function readURL2(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#photo-preview')
                .attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}

function checkExtension2(extension) {
    let checker = true;

    if (extension != '.jpg'
        && extension != '.jpeg'
        && extension != '.png'
        && extension != '.gif'
        && extension != '.jfif') {
        checker = false;
    }

    return checker;
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

        // TODO : 파일 확장자 체크
        const notIsFileNull = $("#photo_upload2").val();
        if (notIsFileNull) {
            let fileValue = $("#photo_upload2").val().split("\\");
            let fileName = fileValue[fileValue.length - 1]; // 파일명
            const extension = getExtensionOfFilename2(fileName);
            const checkExt = checkExtension2(extension);

            if (!checkExt) {
                alert('有効なファイルではありません。(jpg. jpeg, gif, png, jfif)');
                return false;
            }
        } else {
            alert('アップロードしようとするファイルがありません。');
            return false;
        }

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