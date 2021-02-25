var previousPage = 0;
var currentPage = 0;

function testFunc() {
    $.ajax({
        url: '/feed/view/?feed_id=20210224160129978_L2smEKoEoMeN',
        type: 'get',
        dataType: 'text',
        success: function(result) {
            const refined = $('#feed-overlay').append(result).find('#feed-body');
            $('#feed-overlay').empty();
            $('#feed-overlay').append(refined);
            $('#feed-overlay').css({'display':"block"});
        },
        error: function(){
            console.log("통신에러");
        }
    })
}

$(()=> {
   $(document).on('click', '#feed-overlay', function(){
      $('#feed-overlay').empty();
      $('#feed-overlay').css({'display':'none'});
   });
});