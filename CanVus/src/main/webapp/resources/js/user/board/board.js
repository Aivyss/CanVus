$(()=>{
    /*********** 이벤트 등록부 ************/
    // See More part
    $('#more-btn').on('click', function (){
        pageNo++;

        if (pageNo > totalPageCount){ // 페이징을 더 할 수 없다.
            alert("このユーザーのフィードがもうありません。");
            return;
        }

        $.ajax({
            url:'/user/board/seeMore',
            type:'post',
            dataType:'json',
            data: JSON.stringify({
                currentPage: pageNo,
                user_id: user_id
            }),
            contentType:'application/json',
            success: function(result) {
                const bundle = result['bundle'];
                const bookmarks = result['bookmarks'];
                const container = $('#feeds-container');

                for (const oneFeed of bundle) {
                    let content =`
                        <div class="col-xs-6 col-sm-3 hover-fade feed-gallary">
                            <a href="javascript:createModal('/feed/view/?feed_id=${oneFeed['feed_id']}')">
                                <img src="/userPicture/${oneFeed['pictures'][0]}">
                            </a>
                            <div class="caption" style="position:absolute; left:0px; top:70px;">
                                <div class="col-lg-6" id="like-container-board">
                                    <div id="likeDiv">
                                        <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like-${oneFeed[feed_id]}"
                                              style="display:block"></span>
                                    </div>

                    `;
                    content += "</div></div></div>";
                    container.append(content);
                }
            },
            error: function () {
                console.log("피드 번들 불러오기 실패");
            }
        });
    });
});
