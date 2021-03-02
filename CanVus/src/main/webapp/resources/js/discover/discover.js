// 페이징을 위한 전역변수
let tagName = '';
let pagenation_total = 0;
let pagination_curr = 0;

function pageSwitching(tabId) {
    $('#taglist').children().removeClass('active');
    $(`#tab-${tabId}`).addClass('active');
    $('.tab-pane').removeClass('active').addClass('fade');
    $(`#pane-${tabId}`).addClass('active').removeClass('fade');

    // 변수정의
    let header = tabId;
    let tag = '#'+tabId ;

    // 트랜딩이 아닌경우 헤더를 바꾼다 태그를 넣는다.
    if (tabId != 'trending') {
        header = 'tag';
    }

    $.ajax({
        url: '/discover/tag',
        type:'post',
        dataType:'json',
        data: JSON.stringify({
            header: header,
            tag: tag,
            page: 1,
        }),
        contentType: 'application/json',
        success: function (result) {
            // 변수설정
            const pNav = result['pNav'];
            const feedList = result['feedList'];
            tagName = tabId;
            pagination_curr = pNav['currentPage'];
            pagenation_total = pNav['totalPageCount'];

            // 피드 분배
            let content = '';
            for (const feedListElement of feedList) {
                content += `
                    <div class="col-xs-6 col-sm-3 col-sm-offset-1 hover-fade feed-gallary">
                        <a href="javascript:createModal('/feed/view/?feed_id=${feedListElement["FEED_ID"]}');">
                            <img src='/userPicture/${feedListElement["PREVIEW"]}'>
                        </a>
                    </div>
                `;
            }
            $(`#pane-${tabId}`).append(content);
        },
        error : function () {
            console.log("통신에러");
        }
    });
}

$(() => {
    // default --> trending
    pageSwitching('trending');
    // $.ajax({
    //     url: '/discover/tag',
    //     type:'post',
    //     dataType:'json',
    //     data: JSON.stringify({
    //         header: 'trending',
    //         tag: '',
    //         page: 1,
    //     }),
    //     contentType: 'application/json',
    //     success: function (result) {
    //         // 변수설정
    //         const pNav = result['pNav'];
    //         const feedList = result['feedList'];
    //         tagName = 'trending';
    //         pagination_curr = pNav['currentPage'];
    //         pagenation_total = pNav['totalPageCount'];
    //
    //         // 피드 분배
    //         let content = '';
    //         for (const feedListElement of feedList) {
    //             content += `
    //                 <div class="col-xs-6 col-sm-3 col-sm-offset-1 hover-fade feed-gallary">
    //                     <a href="javascript:createModal('/feed/view/?feed_id=${feedListElement["FEED_ID"]}');">
    //                         <img src='/userPicture/${feedListElement["PREVIEW"]}'>
    //                     </a>
    //                 </div>
    //             `;
    //         }
    //         $('#pane-trending').append(content);
    //     },
    //     error : function () {
    //         console.log("통신실패");
    //     }
    // });

    $(document).on('click', '#taglist a', function (e) {
        e.preventDefault();
        let tabId = e.target.id;
        tabId = tabId.split('tab-a-')[1];

        pageSwitching(tabId);
    });
});