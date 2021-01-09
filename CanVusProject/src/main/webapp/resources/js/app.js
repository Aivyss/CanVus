//  ----▽ 로그인 패널과 관련된 함수세트 ▽----
$(document).ready(function () { // 홈페이지가 동작하자마자 작동하도록 해준다.

    console.log("버튼클릭 감지 및 처리");
    var maskHeight = document.body.offsetHeight;
    $("#mask").css({ 'width': '100%', 'height': '100%' });
    $('#mask').fadeTo('slow', 0.3);

    var dialog = $('#content_div');
    var left = ($(window).scrollLeft() + ($(window).width() - dialog.width()) / 2);
    var top = ($(window).scrollTop() + ($(window).height() - dialog.height()) / 2);
    dialog.css({ 'left': left, 'top': top });
    dialog.show();

    $('#mask').click(function () {
        console.log("마스크 클릭 감지 및 처리");
        $('#mask').hide();
        $('#content_div').hide();
    });
});

function resize_slide() {
    var width = $(document).width();
    var height = $(docuemnt).height();
    var dialog = $('#content_div');
    var top = $(window).scrollTop() + ($(windwo).height() - dialog.height()) / 2;
    dialog.css({ 'top': top, 'left': width / 2 - 150 });
}
//  ----△ 로그인 패널과 관련된 함수세트 △----

