$(() => {
    $(document).on('click', '.history-folder', function () {
        console.log("히스토리 클릭");
        location.href='/bookmark/history/>pageNo=1';
    });

    $(document).on('click', '.bookmark-folders', function (event) {
        console.log("북마크 클릭");
        const bmId = $(this).attr('id');
        location.href=`/bookmark/detail/?folder_id=${bmId}&pageNo=1`;
    });
});