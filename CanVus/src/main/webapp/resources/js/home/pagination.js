function pagenation(pageNo, totalPage) {
    pageNo = parseInt(pageNo);
    totalPage = parseInt(totalPage);

    if (pageNo === 0) {
        alert("最初のページです。");
    } else if (pageNo > totalPage) {
        alert("最後のページです。");
    } else {
        location.href=`/?page=${pageNo}`;
    }
}