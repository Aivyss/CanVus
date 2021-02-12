$(function () {
    $("#itemBoxWrap").sortable({
        placeholder: "itemBoxHighlight",
        start: function (event, ui) {
            ui.item.data('start_pos', ui.item.index());
        },
        stop: function (event, ui) {
            var spos = ui.item.data('start_pos');
            var epos = ui.item.index();
            reorder();
        }
    });
});

function createBox(layerId) {
    let contents
        = `<div class='itemBox' id="${layerId}b" >`
        + "<div style='float:left;'>"
        + "<span class='itemNum'></span> "
        + `<input type='text' name='item' value="${layerId}" readonly="readonly" style='width:300px;'/>`
        + "</div>"
        + "</div>";
    return contents;
}



function reorder() {
    $(".itemBox").each(function (i, box) {
        $(box).find(".itemNum").html(i + 1);
    });
}

function createItem(layerId) {

    $(createBox(layerId))
        .appendTo("#itemBoxWrap")
        .hover(
            function () {
                $(this).css('backgroundColor', '#f9f9f5');
                $(this).find('.deleteBox').show();
            },
            function () {
                $(this).css('background', 'none');
                $(this).find('.deleteBox').hide();
            }
        )
        .append("<div class='deleteBox'>[삭제]</div>")
        .find(".deleteBox").click(function () {
        var valueCheck = false;
        $(this).parent().find('input').each(function () {
            if ($(this).attr("name") != "type" && $(this).val() != '') {
                valueCheck = true;
            }
        });
        if (valueCheck) {
            var delCheck = confirm('해당 레이어를 지우시겠습니까?');
        }
        if (!valueCheck || delCheck == true) {
            console.log(layerId);
            // 실질적 레이어를 삭제한다.
            deleteLayer(layerId);

            $(this).parent().remove();
            reorder();
        }
    });
    // 숫자를 다시 붙인다.
    reorder();
}