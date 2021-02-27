/****************************** 전역변수 ******************************************/

var imageLength = parseInt($('#imageLengthVal').val());
var user_id_feed = $('#user_idVal').val();
var feed_id = $('#feed_idVal').val();
var isLiked = $('#isLikeVal').val();
var likeCount = parseInt($('#likeCountVal').val());
var commentCount = parseInt($('#commentCountVal').val());
var previousPage = 1;
var currentPage = 1;

$(() => {
    /******************************* 호이스팅 함수 ************************************/
    // 코멘트의 작성이 완성되고 화면단에 결과를 반영하는 메소드
    function successSendCommentProcess (result) {
        const content = `
            <div class="col-lg-12">
                <div class="media">
                    <div class="media-left media-middle">
                        <a href="#">
                            <img class="media-object"
                                 src='/userProfile/${result["profile_photo"]}'
                                 style="height:32px; width:32px;">
                        </a>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><a
                                href="/user/board/?user_id=${result['user_id']}">${result['nickname']}</a>
                        </h5>
                            ${result['comment']}
                    </div>
                </div>
            </div>
        `;

        $('#comment-box').append(content);
        console.log('댓글추가 완료');
    }

    // 코멘트 입력이 빈칸인지 아닌지 판단하는 메소드
    function checkValidationAndSendComment() {
        const commentContent = $('#comment-input').val();

        if (commentContent.length != 0) {
            sendComment(commentContent);
            $('#comment-input').val("");
        }
    }

    // 코멘트 작성 내용을 서버단으로 보내는 메소드
    function sendComment(commentContent) {
        const params = {
            user_id : user_id_feed,
            feed_id : feed_id,
            comment : commentContent
        };

        $.ajax({
            url:'/comment/sendComment',
            type:"POST",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(params),
            success: function(result) {
                console.log("전송성공");
                console.log(result);
                successSendCommentProcess(result);
            },
            error: function() {
                console.log("전송실패");
            }
        });
    }

    // like를 추가하는 메소드
    function addLike() {
        $.ajax({
            url:"/feed/addLike",
            type:"post",
            contentType: "application/json",
            data: JSON.stringify({
                user_id : user_id_feed,
                feed_id : feed_id,
            }),
            success: function() {
                console.log("라이크 증가 성공");
            },
            error: function () {
                console.log("라이크 증가 실패");
            }
        });
    }

    function deleteLike() {
        $.ajax({
            url:"/feed/deleteLike",
            type:"post",
            contentType: "application/json",
            data: JSON.stringify({
                user_id : user_id_feed,
                feed_id : feed_id,
            }),
            success: function() {
                console.log("라이크 삭제 성공");
            },
            error: function () {
                console.log("라이크 삭제 실패");
            }
        });
    }

    /****************************** 이벤트 등록부 ************************************/
    // 이전 그림보기 버튼 클릭 이벤트
    $('#previous-btn').on('click', function() {
        console.log("이전페이지 보기 버튼 클릭");
        
        if (currentPage != 1) {
            // 현재 페이지의 수를 하나 줄인다.
            previousPage = currentPage;
            currentPage -= 1;
            // 게이지 업데이트
            $('#picture-bar').css({'min-width' : `${(currentPage)*100/imageLength}%`});
            // 그림을 다가린다
            $(`.pictures`).css({'display' : 'none'});
            // 타게팅된 그림만 보이게 한다
            $(`#pictureContainer_${currentPage}`).css({'display':''});
        }
    });

    // 다음 그림보기 버튼 클릭 이벤트
    $('#next-btn').on('click', function() {
        console.log("다음페이지 보기 버튼 클릭");
        
        if (currentPage != imageLength) {
            // 현재 페이지의 수를 하나 줄인다.
            previousPage = currentPage;
            currentPage += 1;
            // 게이지 업데이트
            $('#picture-bar').css({'min-width' : `${(currentPage)*100/imageLength}%`});
            // 그림을 다가린다
            $(`.pictures`).css({'display' : 'none'});
            // 타게팅된 그림만 보이게 한다
            $(`#pictureContainer_${currentPage}`).css({'display':''});
        }
    });

    // 엔터를 이용한 코멘트 작성 이벤트
    $('#comment-input').keydown(function(key) {
        if(key.keyCode == 13) {
            checkValidationAndSendComment();
        }
    });

    // 버튼 클릭을 이용한 코멘트 작성 이벤트
    $('#comment-btn').on('click', function() {
        checkValidationAndSendComment();
    });

    // 라이크 풀기 라이크 걸기
    $(document).on('click', '#like', function() {
        if(user_id_feed == undefined || user_id_feed == null ||user_id_feed.length == 0) {
            alert("ログインしたユーザー専用の機能です。");
            return;
        }

        const likeContainer = $('#like-container');
        const likeCountDOM = $('#like-count');
        let content = '';

        likeContainer.empty();

        if (isLiked) {
            content = `
                <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like"></span>
            `;
            deleteLike();
            likeCountDOM.text("");
            likeCount--;
            likeCountDOM.text(`${likeCount}`);
        } else {
            content = `
                <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like" style="background-color: red"></span>
            `;
            addLike();
            likeCountDOM.text("");
            likeCount++;
            likeCountDOM.text(`${likeCount}`);
        }

        likeContainer.append(content);

        isLiked = !isLiked;
    });

    // 북마크 등록 이벤트
    $(document).on('click', '#bms', function(event) {
        if(user_id_feed == undefined || user_id_feed == null ||user_id_feed.length == 0) {
            alert("ログインしたユーザー専用の機能です。");
            return;
        }

        let eventTargetId = event.target.id;

        if(eventTargetId.substr(0,3) == 'bm-') {
            eventTargetId = parseInt(eventTargetId.split('bm-')[1]);

            const data = {
                folder_id : eventTargetId,
                feed_id : feed_id
            };

            $.ajax({
                url :'/bookmarkRest/addFeedIntoBookmark',
                type:'post',
                contentType:"application/json",
                data: JSON.stringify(data),
                dataType: 'json',
                success : function (result) {
                    if(result['isSuccess']) {
                        alert("Bookmarked");
                    } else {
                        alert("Already Bookmarked");
                    }
                },
                error : function () {
                    alert("Bookmarking Failed");
                }
            });
        }
    });
});