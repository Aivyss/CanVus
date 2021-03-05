// 페이징을 위한 전역변수
let tagName = '';
let pagenation_total = 0;
let pagination_curr = 0;

function generateContent (result, tag) {
    $('.gallery').empty();
    // 변수설정
    const pNav = result['pNav'];
    const feedList = result['feedList'];
    tagName = tag;
    pagination_curr = pNav['currentPage'];
    pagenation_total = pNav['totalPageCount'];

    // 피드 분배
    let content = '';
    for (const feedListElement of feedList) {
        content += `
            <div class='col-sm-4 col-xs-6 col-md-2 col-lg-2 hover-fade'>
                <a class="thumbnail" rel="ligthbox" href="javascript:createModal('/feed/view/?feed_id=${feedListElement["FEED_ID"]}');">
                    <img class="img-responsive" alt="" src="/userPicture/${feedListElement["PREVIEW"]}"
                        style="width: 150px; height:150px;" />
                    <div class='text-right'>
                        <small class='text-muted'>${feedListElement['OWNER']}</small>
                    </div> <!-- text-right / end -->
                </a>
            </div> <!-- col-6 / end -->
                `;
    }
    $(`#pane-list-${tag}`).append(content);

    insertPagenation(pNav, tag);
}

function insertPagenation(pNav, tag) {
    // 페이지네이션 업데이트
    $('#pagination-container').empty();
    let pagination = `
                <div class="row center-block text-center">
                    <div class="center-block">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="javascript:pagenation(${pNav["currentPage"]-1}, ${pNav["totalPageCount"]}, '${tag}')" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
            `;
    for (let i=pNav['startPageGroup']; i<= pNav['endPageGroup']; i++) {
        if (i == pNav['currentPage']) {
            pagination += `<li class="page-item active"><a class="page-link" href="#">${i}</a></li>`;
        } else {
            pagination += `
                        <li class="page-item">
                            <a class="page-link" href="javascript:pagenation(${i}, ${pNav['totalPageCount']}, '${tag}')">${i}</a>
                        </li>
                    `;
        }
    }
    pagination += `
                                <li class="page-item">
                                    <a class="page-link" href="javascript:pagenation(${pNav['currentPage']+1}, ${pNav['totalPageCount']}, '${tag}')" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            `;

    $('#pagination-container').append(pagination);
}

function pagenation(curr, totalPage, tag) {
    // TODO CHECK PAGING VALIDATION 1
    if (curr<=0) {
        alert("最初のページです。");
        return;
    }

    // TODO CHECK PAGING VALIDATION 2
    if (curr > totalPage) {
        alert("最後のページです。");
        return;
    }

    // TODO HEADER SETTING
    let header = '';
    if (tag == 'trending') {
        header = 'trending';
    } else {
        header = 'tag';
    }

    // TODO AJAX PAGING
    $.ajax({
        url: '/discover/tag',
        type:'post',
        dataType: 'json',
        data: JSON.stringify({
            header: header,
            tag: tag,
            page: curr
        }),
        contentType: 'application/json',
        success: function(result) {
            generateContent(result, tag);
        },
        error: function () {
            console.log("통신오류");
        }
    });

    console.log(curr);
    console.log(totalPage);
    console.log(tag);
}

function pageSwitching(tag) {
    $('#taglist').children().removeClass('active');
    $(`#tab-${tag}`).addClass('active');
    $('.tab-pane').removeClass('active').addClass('fade');
    $(`#pane-${tag}`).addClass('active').removeClass('fade');
    $('.gallery').empty();

    // 변수정의
    let header = tag;
    let sendingTag = '#'+tag ;

    // 트랜딩이 아닌경우 헤더를 바꾼다 태그를 넣는다.
    if (tag != 'trending') {
        header = 'tag';
    }

    $.ajax({
        url: '/discover/tag',
        type:'post',
        dataType:'json',
        data: JSON.stringify({
            header: header,
            tag: sendingTag,
            page: 1,
        }),
        contentType: 'application/json',
        success: function (result) {
            generateContent(result, tag)
        },
        error : function () {
            console.log("통신에러");
        }
    });
}

$(() => {
    // default --> trending
    pageSwitching('trending');

    $(document).on('click', '#taglist a', function (e) {
        e.preventDefault();
        let tabId = e.target.id;
        tabId = tabId.split('tab-a-')[1];

        pageSwitching(tabId);
    });
});