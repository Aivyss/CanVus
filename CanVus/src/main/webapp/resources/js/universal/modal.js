function createModal(url) {
    $.ajax({
        url: url,
        type: 'get',
        dataType: 'text',
        success: function (result) {
            let refined = $(result).append(result).find('#feed-body');

            $('#feed-overlay').empty();
            $('#feed-overlay').append(refined.html());
            $('.container-feed').css({'margin-top': '80px'});
            const feedHeight = $('.container-feed').css('height');
            $('.modal-backdrop').css({"height":`${feedHeight+200}px`});
            $('.card').addClass('modal-content');
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

            const $feedText = $('#feed-text');
            const text = $feedText.text();
            const regex = /[#][a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣぁ-ゔァ-ヴー々〆〤一-龥]*/g;
            const tagArry = text.match(regex);
            const others = text.split(regex);
            let content = '';
            let j = 0;

            for (let i=0; i<others.length; i++) {
                if (others[i].length === 0) {
                    content += `<a href="/search/result/?type=0&keyword=${tagArry[j].split('#')[1]}">${tagArry[j]}</a>`;
                    j++;
                } else {
                    content += others[i];
                }
            }

            $feedText.empty();
            $feedText.append(content);
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