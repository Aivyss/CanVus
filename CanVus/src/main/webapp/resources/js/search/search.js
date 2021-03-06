function pagenation(searchText, pageNo, totalPage) {
    const refinedSearchText = searchText.split('#')[1];
    pageNo = parseInt(pageNo);
    totalPage = parseInt(totalPage);

    if (pageNo == 0) {
        alert("最初のページです。");
    } else if (pageNo > totalPage) {
        alert("最後のページです。");
    } else {
        location.href=`/search/result/?keyword=${refinedSearchText}&type=0&page=${pageNo}`;
    }
}
