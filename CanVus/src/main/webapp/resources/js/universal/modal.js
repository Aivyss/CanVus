function createModal(url) {
    $.ajax({
        url: url,
        type: 'get',
        dataType: 'text',
        success: function (result) {
            let refined = $(result).append(result).find('#feed-body');

            $('#feed-overlay').empty();
            $('#feed-overlay').append(refined.html());
            $('.container-feed').css({'margin-top': '200px'});
            const feedHeight = $('.container-feed').css('height');
            $('.modal-backdrop').css({"height":`${feedHeight+200}px`});
            $('#feed-overlay').modal('show');

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