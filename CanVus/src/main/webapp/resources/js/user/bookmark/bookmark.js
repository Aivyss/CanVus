$(() => {
    $(document).on('click', '.history-folder', function () {
        console.log("히스토리 클릭");
    });
    $(document).on('click', '.bookmark-folders', function (event) {
        console.log("북마크 클릭");
        console.log($(this).attr('id'));
    });
});