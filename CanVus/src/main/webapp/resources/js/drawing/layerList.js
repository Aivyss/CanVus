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
        = `<div class='itemBox' id="${layerId}b" style="width:200px; height:60px; background-color:white;" >`
        + "<div style='float:left;'>"
        + "<span class='itemNum'></span> "
        + `<span name="item">Layer : ${layerId.split("l")[1]}</span>`
        // + `<input type='text' name='item' value="${layerId}" readonly="readonly" style='width:300px;'/>`
        + "</div>"
        + "</div>";
    return contents;
}



function reorder() {
    $(".itemBox").each(function (i, box) {
        $(box).find(".itemNum").html(i + 1);

        let itemBoxIdArray = [];
        $(".itemBox").each(function(){
            let temp = $(this).attr("id");
            temp = temp.split('b');
            itemBoxIdArray.push(temp[0]);

            // z index reodering
            for (let i=0; i<itemBoxIdArray.length; i++) {
                let temp2 = itemBoxIdArray[i].split('p');
                temp2 = temp2[1].split('l');
                zNumSet[temp2[0]-1][temp2[1]-1] = i+1;
                $('#'+itemBoxIdArray[i]).css({'z-index': i+1});
                $('.'+itemBoxIdArray[i]+'u').css({'z-index': i+1});
            }
        });


    });
}

function createItem(layerId) {

    $(createBox(layerId))
        .appendTo("#itemBoxWrap")
        .hover(
            function () {
                $(this).css('backgroundColor', 'skyblue');
                $(this).find('.deleteBox').show();
            },
            function () {
                $(this).css('background', 'white');
                $(this).find('.deleteBox').hide();
            }
        )
        .append("<div class='deleteBox'>[삭제]</div>")
        .find(".deleteBox").click(function () {
            let delCheck = confirm('해당 레이어를 지우시겠습니까?');

            if (delCheck) {
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