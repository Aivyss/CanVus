function pagenation(searchText, pageNo, totalPage) {
    const refinedSearchText = searchText.split('#')[1];
    pageNo = parseInt(pageNo);
    totalPage = parseInt(totalPage);

    if (pageNo == 0) {
        alert("最初のページです。");
    } else if (pageNo > totalPage) {
        alert("最後のページです。");
    } else {
        location.href = `/search/result/?keyword=${refinedSearchText}&type=0&page=${pageNo}`;
    }
}

$(() => {
    // 팔로우 또는 언팔로우 클릭시 팔로우 정보를 업데이트 하는 이벤트
    $(document).on('click', '#follow-btn', function () {
        if (user_id.length > 0) {
            const followBtn = $('#follow-btn');
            let content = '';

            followBtn.empty();
            if (isFollower) {
                content = `
                    <div class="title btn btn-outline btn-lg">
                        フォローアップ
                    </div>
                `;

            } else {
                content = `
                    <div class="title btn btn-outline-unfollow btn-lg">
                        リムーブ
                    </div>
                `;
            }

            followBtn.append(content);
            isFollower = !isFollower;

            let data = {
                isFollowing: isFollower,
                my_id: my_id,
                user_id: user_id
            };

            $.ajax({
                url: '/follow/updateFollowing',
                type: 'post',
                data: JSON.stringify(data),
                contentType: 'application/json',
                success: function () {
                    if (isFollower) {
                        alert("フォローしました！");
                    } else {
                        alert("リムーブしました！");
                    }
                },
                error: function () {
                    alert("通信上のエラーが発生しました。");
                }
            });
        }
    });
});
