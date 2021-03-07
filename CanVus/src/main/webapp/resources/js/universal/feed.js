/****************************** 전역변수 ******************************************/
let imageLength = parseInt($('#imageLengthVal').val());
let user_id_feed = $('#user_idVal').val(); // 피드를 보는 사람의 아이디
let feed_id = $('#feed_idVal').val();
let isLiked = $('#isLikeVal').val();
let likeCount = parseInt($('#likeCountVal').val());
let commentCount = parseInt($('#commentCountVal').val());
let previousPage = 1;
let currentPage = 1;
let bookmarkSwitch = true;

// 코멘트를 삭제하는 메소드
function deleteComment(comment_id) {
    console.log(comment_id);

    if (confirm("削除われたコメントは取り返せません。削除しますか。")) {
        const data = {
            comment_id : parseInt(comment_id)
        };

        $.ajax({
            url:'/comment/deleteComment',
            type:'post',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function () {
                $(`#comment-box-${comment_id}`).remove();
                alert("コメントを消しました。");
            },
            error: function () {
                alert("通信上の問題で、消すことが出来ませんでした。");
            }
        });
    }
}

$(() => {
    /******************************* 호이스팅 함수 ************************************/
    // 코멘트의 작성이 완성되고 화면단에 결과를 반영하는 메소드
    function successSendCommentProcess(result) {
        const content = `
            <div class="col-lg-12">
                <div class="media">
                    <div class="media-left media-middle">
                        <a href="#">
                            <img class="media-object"
                                 src='/userProfile/${result["profile_photo"]}'
                                 onerror="this.src='/resources/images/defaults/profileDefault.png'"
                                 style="height:32px; width:32px;">
                        </a>
                    </div>
                    <div class="media-body">
                        <div class="col-md-10">
                            <h5 class="media-heading">
                                <a href="/user/board/?user_id=${result['user_id']}">${result['nickname']}</a>
                            </h5>
                            <p>${result['comment']}</p>
                        </div>
                        <div class="col-md-2">
                            <input type="button"
                                   class="btn btn-primary"
                                   value="リムーブ"
                                   style="margin-bottom: 20px;
                                            background:linear-gradient( to bottom, #ff0000, #cc0000 );
                                            border-radius: 20px 20px 20px 20px;"
                                   onclick="deleteComment('${result["comment_id"]}')">
                        </div>
                    </div>
                </div>
            </div>
        `;

        $('#comment-box').append(content);
        console.log('댓글추가 완료');
    }

    // 비로그인 유저인지 코멘트 입력이 빈칸인지 아닌지 판단하는 메소드
    function checkValidationAndSendComment() {
        if (user_id_feed == undefined || user_id_feed == null || user_id_feed.length == 0) {
            alert("ログインしたユーザー専用の機能です。");
            return;
        }

        const commentContent = $('#comment-input').val();

        if (commentContent.length != 0) {
            sendComment(commentContent);
            $('#comment-input').val("");
        }
    }

    // 코멘트 작성 내용을 서버단으로 보내는 메소드
    function sendComment(commentContent) {
        const params = {
            user_id: user_id_feed,
            feed_id: feed_id,
            comment: commentContent
        };

        $.ajax({
            url: '/comment/sendComment',
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(params),
            success: function (result) {
                console.log("전송성공");
                console.log(result);
                successSendCommentProcess(result);
            },
            error: function () {
                console.log("전송실패");
            }
        });
    }

    // like를 추가하는 메소드
    function addLike() {
        $.ajax({
            url: "/feed/addLike",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify({
                user_id: user_id_feed,
                feed_id: feed_id,
            }),
            success: function () {
                console.log("라이크 증가 성공");
            },
            error: function () {
                console.log("라이크 증가 실패");
            }
        });
    }

    function deleteLike() {
        $.ajax({
            url: "/feed/deleteLike",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify({
                user_id: user_id_feed,
                feed_id: feed_id,
            }),
            success: function () {
                console.log("라이크 삭제 성공");
            },
            error: function () {
                console.log("라이크 삭제 실패");
            }
        });
    }

    /****************************** 이벤트 등록부 ************************************/
    // 이전 그림보기 버튼 클릭 이벤트
    $(document).on('click', '#previous-btn' ,function () {
        console.log("이전페이지 보기 버튼 클릭");

        if (currentPage != 1) {
            // 현재 페이지의 수를 하나 줄인다.
            previousPage = currentPage;
            currentPage -= 1;
            // 게이지 업데이트
            $('#picture-bar').css({'min-width': `${(currentPage) * 100 / imageLength}%`});
            // 그림을 다가린다
            $(".pictures").fadeOut(600).delay(600);
            // 타게팅된 그림만 보이게 한다
            $(`#pictureContainer_${currentPage}`).fadeIn(1200);
        }
    });

    // 다음 그림보기 버튼 클릭 이벤트
    $(document).on('click', '#next-btn' ,function () {
        console.log("다음페이지 보기 버튼 클릭");

        if (currentPage != imageLength) {
            // 현재 페이지의 수를 하나 줄인다.
            previousPage = currentPage;
            currentPage += 1;
            // 게이지 업데이트
            $('#picture-bar').css({'min-width': `${(currentPage) * 100 / imageLength}%`});
            // 그림을 다가린다
            $(`.pictures`).fadeOut(600).delay(600);
            // 타게팅된 그림만 보이게 한다
            $(`#pictureContainer_${currentPage}`).fadeIn(1200);
        }
    });

    // 엔터를 이용한 코멘트 작성 이벤트
    $(document).on('keydown', '#comment-input', function (key) {
        if (key.keyCode == 13) {
            checkValidationAndSendComment();
        }
    });

    // 버튼 클릭을 이용한 코멘트 작성 이벤트
    $(document).on('click', '#comment-btn' ,function () {
        checkValidationAndSendComment();
    });

    // 라이크 풀기 라이크 걸기
    $(document).on('click', '#like', function () {
        if (user_id_feed == undefined || user_id_feed == null || user_id_feed.length == 0) {
            alert("ログインしたユーザー専用の機能です。");
            return;
        }

        const likeContainer = $('#like-container');
        const likeCountDOM = $('#like-count-small');
        let content = '';

        likeContainer.empty();

        if (isLiked == 'true') {
            content = `
                <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like"></span>
            `;
            deleteLike();
            likeCountDOM.text("");
            likeCount--;
            likeCountDOM.text(`${likeCount}`);
            isLiked = 'false';
        } else {
            content = `
                <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like" style="background-color: red"></span>
            `;
            addLike();
            likeCountDOM.text("");
            likeCount++;
            likeCountDOM.text(`${likeCount}`);
            isLiked = 'true';
        }

        likeContainer.append(content);
    });

    // 북마크 등록 이벤트
    $(document).on('click', '#bms', function (event) {
        if (user_id_feed == undefined || user_id_feed == null || user_id_feed.length == 0) {
            alert("ログインしたユーザー専用の機能です。");
            return;
        }

        let eventTargetId = event.target.id;

        if (eventTargetId.substr(0, 3) == 'bm-') {
            eventTargetId = parseInt(eventTargetId.split('bm-')[1]);

            const data = {
                folder_id: eventTargetId,
                feed_id: feed_id
            };

            $.ajax({
                url: '/bookmarkRest/addFeedIntoBookmark',
                type: 'post',
                contentType: "application/json",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    if (result['isSuccess']) {
                        alert("ブックマークしました！");
                    } else {
                        $.ajax({
                            url: '/bookmarkRest/deleteFeedFromBookmark',
                            type: 'post',
                            contentType: 'application/json',
                            data:JSON.stringify(data),
                            success: function () {
                                alert("このフィードをブックマークから消しました。");
                            },
                            error: function () {
                                alert("通信上のエラーが発生しました。");
                            }
                        })
                    }
                },
                error: function () {
                    alert("Bookmarking Failed");
                }
            });
        }
    });

    // 북마크 활성화 이벤트
    $(document).on('click', '#bmsIcon' ,function () {
        if (user_id_feed == undefined || user_id_feed == null || user_id_feed.length == 0) {
            alert("ログインしたユーザー専用の機能です。");
            return;
        }

        if (bookmarkSwitch) {
            $('#bms').css({'display':"block"});
        } else {
            $('#bms').css({'display':"none"});
        }
        bookmarkSwitch = !bookmarkSwitch
    });

    // 피드 삭제버튼 클릭 이벤트
    $(document).on('click', '#delete-feed-btn', function() {
        const feed_owner_id = $('#feed-owner-idVal').val();
        const my_id = $('#user_idVal').val();
        const feed_id = $('#feed_idVal').val();

        if (my_id === feed_owner_id) {
            // 바닐라 자바스크립트를 써보고 싶었다.
            const form = document.createElement('form');
            form.method = 'post';
            form.action = '/feed/deleteFeed';
            form.target = '_blank';

            const feed_id_form = document.createElement('input');
            const owner_id_form = document.createElement('input');

            feed_id_form.setAttribute('type', 'text');
            feed_id_form.setAttribute('name', 'feed_id');
            feed_id_form.setAttribute('value', feed_id);

            owner_id_form.setAttribute('type', 'text');
            owner_id_form.setAttribute('name', 'user_id1');
            owner_id_form.setAttribute('value', feed_owner_id);

            form.appendChild(feed_id_form);
            form.appendChild(owner_id_form);

            document.getElementById('feed-overlay').appendChild(form);

            form.submit();
        } else {
            alert("フィードのオーナーしか消しません。");
        }
    });
});