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
                    let content = `
                        <div class="col-xs-6 col-sm-3 hover-fade feed-gallary">
                            <a href="#">
                                <img src="/userPicture/${oneFeed.pictures[0]}">
                            </a>
                            <div class="caption" style="position:absolute; left:0px; top:70px;">
                                <div class="col-lg-6" id="like-container">
                                    <div id="likeDiv">
                                        <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like"
                                              style="display:block"></span>
                                    </div>
                                    <span class="glyphicon glyphicon-bookmark bookmarkCSS" data-toggle="dropdown"
                                          area-expanded="false"></span>
                                    <ul class="dropdown-menu custom-dropdown" role="menu" id="bms">
                    `;

                    let temp = "";
                    for (const bookmark of bookmarks) {
                        temp += `
                            <li>
                                <a id="bm-${bookmark['folder_id']}" href="#">
                                    ${bookmark['folder_name']}
                                </a>
                            </li>    
                        `;
                    }
                    content += temp;
                    content += `</ul></div></div></div>`;
                    container.append(content);
                }
            },
            error: function () {
                console.log("피드 번들 불러오기 실패");
            }
        });
    });
});
