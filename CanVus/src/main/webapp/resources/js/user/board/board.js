$(() => {
    /*********** 이벤트 등록부 ************/
    // See More part
    $('#more-btn').on('click', function () {
        pageNo++;

        if (pageNo > totalPageCount) { // 페이징을 더 할 수 없다.
            alert("このユーザーのフィードがもうありません。");
            return;
        }

        $.ajax({
            url: '/user/board/seeMore',
            type: 'post',
            dataType: 'json',
            data: JSON.stringify({
                currentPage: pageNo,
                user_id: user_id
            }),
            contentType: 'application/json',
            success: function (result) {
                const bundle = result['bundle'];
                const bookmarks = result['bookmarks'];
                const container = $('#feeds-container');

                for (const oneFeed of bundle) {
                    let content = `
                        <div class='col-sm-4 col-xs-6 col-md-3 col-lg-3 hover-fade'>
                            <a class="thumbnail " rel="ligthbox" href="javascript:createModal('/feed/view/?feed_id=${oneFeed['feed_id']}')">
                                <img class="img-responsive" alt="" src="/userPicture/${oneFeed['feed_id']}--divide--1.png" />
                                <div class='text-right'>
                                    <small class='text-muted'>${oneFeed['nickname1']}</small>
                                </div> <!-- text-right / end -->
                            </a>
                        </div> <!-- col-6 / end -->
                    `;
                    container.append(content);
                }
            },
            error: function () {
                console.log("피드 번들 불러오기 실패");
            }
        });
    });

    $(document).on('click', '#follow-btn-container', function (event) {
        const targetId = event.target.id;
        const $container = $('#follow-btn-container');
        let isFollowing = false;
        let content = '';

        if (targetId == 'follow-btn' || targetId == 'unfollow-btn'){
            $container.empty();
            if (targetId == 'follow-btn') {
                content = `
                    <input id="unfollow-btn"
                        type="button"
                        class="btn btn-primary"
                        value="リムーブ"
                        style="margin-bottom: 20px;
                        background:linear-gradient( to bottom, #ff0000, #cc0000 );
                        border-radius: 20px 20px 20px 20px;">
                `;

                isFollowing = true;
            } else if (targetId == 'unfollow-btn') {
                content = `
                    <input id="follow-btn"
                        type="button"
                        class="btn btn-primary"
                        value="フォロー"
                        style="margin-bottom: 20px;
                        background:linear-gradient( to bottom, #0000ff, #0080ff );
                        border-radius: 20px 20px 20px 20px;">
                `;
            }

            $container.append(content);

            let data = {
                isFollowing: isFollowing,
                my_id: my_id,
                user_id : user_id
            };

            $.ajax({
                url:'/follow/updateFollowing',
                type:'post',
                data: JSON.stringify(data),
                contentType: 'application/json',
                success : function () {
                    if (isFollowing) {
                        alert("フォローしました！");
                    } else {
                        alert("リムーブしました！");
                    }
                },
                error: function () {
                    alert("通信上のエラーが発生しました。");
                }
            });
        } else {
            console.log("다른 곳을 누른 경우");
        }
    });
});
