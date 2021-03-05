// 전송 함수
function doSearch(searchText) {
    let url = '/search/result/?keyword=';

    if (searchText.substring(0, 1) == '#') {
        // 태그서치
        url += `${searchText.split('#')[1]}&type=0`;
    } else {
        // 유저서치
        url += `/search/result/?keyword=${searchText}&type=1`;
    }

    location.href = url;
}

$(() => {
    /******************************** 호이스팅 함수부 ************************************/
    function checkValidationAboutRoomInfo() {
        const title = $('#exampleDropdownFormTitle').val();
        const pw = $('#exampleDropdownFormPassword').val();
        const capacity = $('#exampleDropdownFormNumberOfPpl').val();
        const form = document.getElementById('create-room-form');

        if (title == null || title == undefined || title.length <= 0) {
            alert('ルームのタイトルを決めてください。');
            return false;
        }

        if (pw != null && pw != undefined && pw.length > 0) {
            if (pw.length < 3 || pw.length > 6) {
                alert('パスワードは3文字以上６文字以下にしてください。');
                return false;
            }
        }

        if (isNaN(capacity)) {
            alert('数字を入力てください。');
            return false;
        } else {
            if (capacity == null || capacity == undefined) {
                alert('人数は数字しか入力できまん。');
                return false;
            } else if ( capacity <= 0) {
                alert('人数は０以上の数字でお願いします。');
                return false;
            }
        }

        form.submit();
    }

    /******************************* 이벤트 등록부 *************************************/
    $('#searchText').keydown(function (key) {
        if (key.keyCode == 13) {
            const keyword = $('#searchText').val();

            if (keyword.length != 0) {
                doSearch(keyword);
                $('#searchText').val("");
            }
        }
    });

    $('#exampleDropdownFormTitle').keydown(function (key) {
        if (key.keyCode == 13) {
            checkValidationAboutRoomInfo();
        }
    });

    $('#exampleDropdownFormPassword').keydown(function (key) {
        if (key.keyCode == 13) {
            checkValidationAboutRoomInfo();
        }
    });
    $('#exampleDropdownFormNumberOfPpl').keydown(function (key) {
        if (key.keyCode == 13) {
            checkValidationAboutRoomInfo();
        }
    });

    $('#create-room-btn').on('click', function () {
        checkValidationAboutRoomInfo();
    });

    // 이미지 서치 드랍박스 오픈 이벤트
    $('#searchText').on('click', function (event) {
        event.preventDefault();
        event.stopImmediatePropagation();
        $('#image-search-box').addClass('open');
    });
    // 이미지 서치 드랍박스 클로즈 이벤트
    $('body').on('click', function () {
        $('#image-search-box').removeClass('open');
    });
});