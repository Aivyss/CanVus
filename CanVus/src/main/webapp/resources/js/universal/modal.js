function createModal(url) {
    $.ajax({
        url: url,
        type: 'get',
        dataType: 'text',
        success: function (result) {
            let content = `
                <a href="#"><span id="modalClose" style="width:20px; height:20px;background-color: white;">X</span></a>
            `;
            let refined = $(result).append(result).find('#feed-body');
            content = content + refined.html();
            $('#feed-overlay').empty();
            $('#feed-overlay').append(content);
            $('#feed-overlay').css({'display': "block"});

            imageLength = parseInt($('#imageLengthVal').val());
            user_id_feed = $('#user_idVal').val();
            feed_id = $('#feed_idVal').val();
            isLiked = $('#isLikeVal').val();
            likeCount = parseInt($('#likeCountVal').val());
            commentCount = parseInt($('#commentCountVal').val());
            previousPage = 1;
            currentPage = 1;
            bookmarkSwitch = true;
        },
        error: function () {
            console.log("통신에러");
        }
    });
}

$(() => {
    $(document).on('click', '#modalClose', function () {
        $('#feed-overlay').empty();
        $('#feed-overlay').css({'display': 'none'});
    });
});