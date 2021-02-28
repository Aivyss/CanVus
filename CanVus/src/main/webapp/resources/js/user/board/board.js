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
                        <div class="col-xs-6 col-sm-3 col-sm-offset-1 hover-fade feed-gallary">
                            <a href="javascript:createModal('/feed/view/?feed_id=${oneFeed['feed_id']}')">
                                <img src="/userPicture/${oneFeed['pictures'][0]}">
                            </a>
                        </div>
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
        const $container = $('##follow-btn-container');
        const isFollowing = false;
        let content = '';

        if (targetId == 'follow-btn' || targetId == 'unfollow-btn'){
            $container.empty();
            if (targetId == 'follow-btn') {
                content = `
                    <button id="unfollow-btn" type="button" class="btn btn-danger">
                        リムーブ
                    </button>
                `;

                isFollowing = true;
            } else if (targetId == 'unfollow-btn') {
                content = `
                    <button id="follow-btn" type="button" class="btn btn-danger">
                        フォロー
                    </button>
                `;
            }
            $container.append(content);

            $.ajax({
                url:''
            })

        }

        if (targetId == 'follow-btn') {

            content = `
                <button id="unfollow-btn" type="button" class="btn btn-danger">
                    リムーブ
                </button>
            `;
            $container.append(content);
        } else if (targetId == 'unfollow-btn') {
            $container.empty();
            content = `
                <button id="follow-btn" type="button" class="btn btn-danger">
                    フォロー
                </button>
            `;
            $container.append(content);
        } else {
            console.log("다른 곳을 누른 경우");
        }
    });
});
