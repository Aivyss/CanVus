function getExtensionOfFilename(filename) {
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

function checkExtension(extension) {
    let checker = true;

    if (extension != 'jpg'
        && extension != 'jpeg'
        && extension != 'png'
        && extension != 'gif') {
        checker = false;
    }

    return checker;
}

$(() => {
    // 포토 프리뷰 호이스팅 함수
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#photo-preview').attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    $('#submit-btn').on('click', function () {
        const form = document.getElementById('sign-up-form');
        const nickname = $('#nickname').val();
        const intro = $('#introduction').val();
        let duplicateCheck = false;

        // TODO : nikcname validation check
        if (nickname == null || nickname.length == 0 || nickname == undefined) {
            alert("ニックネームを入力して下さい。");
            return false;
        } else if (nickname.length < 3 || nickname.length > 6) {
            alert("ニックネームは3～6文字の範囲で作成して下さい。");
            return false;
        } else {
            $.ajax({
                url: '/user/checkDuplicateNickname',
                type: "post",
                async: false,
                dataType: 'json',
                data: JSON.stringify({
                    nickname: nickname
                }),
                contentType:"application/json",
                success: function (result) {
                    duplicateCheck = result['isDuplicate'];
                },
                error: function () {
                    console.log("통신실패");
                }
            });
        }
        if (duplicateCheck) {
            alert("誰かが同じニックネームを使っています。他のニックネームを使って下さい。");

            return false;
        }

        // TODO : NULL INTRODUCTION
        if (intro == null || intro == undefined || intro.length === 0) {
            $('#introduction').val(`${nickname}のボードにようこそ！`);
        }

        // TODO : 파일 확장자 체크
        const notIsFileNull = $("#photo_upload").val();
        if (notIsFileNull) {
            let fileValue = $("#photo_upload").val().split("\\");
            let fileName = fileValue[fileValue.length - 1]; // 파일명
            const extension = getExtensionOfFilename(fileName);
            const checkExt = checkExtension(extension);

            if (checkExt) {
                alert('有効なファイルではありません。(jpg. jpeg, gif, png');
                return false;
            }
        }

        // TODO : CHECK AGREEMENTS
        const isAgreed = $('#t_and_c').val();
        if (isAgreed == 0) {
            alert("約款に同意しないと、登録ができません。");
            return;
        }

        // TODO : SUBMIT
        form.submit();
    });

    $('#cancel-btn').on('click', function () {
        location.href="/";
    });


    // 동의 체크버튼
    $('.button-checkbox').each(function () {
        // Settings
        var $widget = $(this),
            $button = $widget.find('button'),
            $checkbox = $widget.find('input:checkbox'),
            color = $button.data('color'),
            settings = {
                on: {
                    icon: 'glyphicon glyphicon-check'
                },
                off: {
                    icon: 'glyphicon glyphicon-unchecked'
                }
            };

        // Event Handlers
        $button.on('click', function () {
            $checkbox.prop('checked', !$checkbox.is(':checked'));
            $checkbox.triggerHandler('change');
            const check = $('#t_and_c').val();
            if (check == 0) {
                $('#t_and_c').val(1);
            } else {
                $('#t_and_c').val(0);
            }
            updateDisplay();
        });
        $checkbox.on('change', function () {
            updateDisplay();
        });

        // Actions
        function updateDisplay() {
            var isChecked = $checkbox.is(':checked');

            // Set the button's state
            $button.data('state', (isChecked) ? "on" : "off");

            // Set the button's icon
            $button.find('.state-icon')
                .removeClass()
                .addClass('state-icon ' + settings[$button.data('state')].icon);

            // Update the button's color
            if (isChecked) {
                $button
                    .removeClass('btn-default')
                    .addClass('btn-' + color + ' active');
            }
            else {
                $button
                    .removeClass('btn-' + color + ' active')
                    .addClass('btn-default');
            }
        }

        // Initialization
        function init() {

            updateDisplay();

            // Inject the icon if applicable
            if ($button.find('.state-icon').length == 0) {
                $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i>');
            }
        }
        init();
    });
});