// ********** 전역변수 셋 ********** //
// 전체 레이어 객체 및 z-index를 저장하는 리스트
const layerSet = []; // 예: p3l2의 패브릭 객체는 layerSet[2][1]
const zNumSet = []; // 예: p1l1이 z-index가 3이라면 zNumSet[0][0]  == 3
const eventSet = [];

// 현재 바라보고 있는 레이어 객체
let currlayer = null;

// 현재 바라보고 있는 페이지 번호와 레이어번호
let pageNum = 1;
let layerNum = 1;

// 전 단계에서 바라보고 있던 페이지번호와 레이어번호
let bPageNum = 0;
let bLayerNum = 0;

// rbgaGlobal 정보 (주입된 값은 초기값이므로 신경쓰지 않아도 된다.)
let opacityGlobal = 1;
let thicknessGlobal = 5;
let hexGlobal = "#005E7A"; // rgb 정보
let brushGlobal = "PencilBrush";

// 소켓 클라이언트 정의
let socketClient = null;
let isInitialized = false;


// 유저리스트 필터용 변수
let filter;
let list;
let listItems = [];

// 권한부여자 카운팅
let authCount = 0;

// 드로워 리스트 (어드민 제외)
let drawerNicknameList = [];
let drawerIdList = [];
let getPixelList = [0,0,0,0];

// 레인지바 객체
let sliderObj = {
    updateSlider: function (element) {
        if (element) {
            var parent = element.parentElement,
                lastValue = parent.getAttribute('data-slider-value');

            if (lastValue === element.value) {
                return; // No value change, no need to update then
            }

            parent.setAttribute('data-slider-value', element.value);
            var $thumb = parent.querySelector('.range-slider__thumb'),
                $bar = parent.querySelector('.range-slider__bar'),
                pct = element.value * ((parent.clientHeight - $thumb.clientHeight) / parent.clientHeight);

            $thumb.style.bottom = pct + '%';
            $bar.style.height = 'calc(' + pct + '% + ' + $thumb.clientHeight / 2 + 'px)';
            $thumb.textContent = element.value + '%';
        }
    }
};

// ********** 소켓 수신부 함수셋 ******************//
let socketFunctionSet = (function () {
    return {
        commonchat: function (data) {
            messageController.chatReply(data);
        },
        enter: function (data) {
            messageController.chatReply(data);
            const userList = data['userListInRoom'];

            $('#canvus-list').empty();
            $('#drawerList').empty();
            authCount = 0;
            drawerNicknameList = [];
            drawerIdList = [];
            getPixelList = [0,0,0,0];


            // 전체 유저리스트 생성
            if (admin_id == user_id) { // 어드민이 입장한 경우
                for (const user of userList) {
                    if (user['user_type'] == 'VISITOR') { // 유저리스트의 유저가 방문자인 경우
                        $('#canvus-list').append(`<li>${user['nickname']}<button class="addAuthority" id="list${user['user_id']}">一緒に</button></li>`);
                    } else { // 유저 리스트의 유저가 drawer인 경우
                        drawerNicknameList.push(user['nickname']);
                        drawerIdList.push(user['user_id']);
                        $('#canvus-list').append(`<li>${user['nickname']}</li>`);

                        authCount++;
                    }
                }
            } else { //  VISITOR와 DRAWER가 입장한 경우
                for (const user of userList) {
                    // 드로워 추출
                    if (user['user_type'] != 'VISITOR') {
                        drawerNicknameList.push(user['nickname']);
                        drawerIdList.push(user['user_id']);
                    }

                    $('#canvus-list').append(`<li>${user['nickname']}</li>`);
                }
            }

            // 드로워 리스트 생성
            const numOfDrawers = drawerIdList.length;
            for (let i = 0; i < numOfDrawers; i++) {
                const content = `
                    <button class="btn btn-primary" type="button" id="drawerTop-${drawerIdList[i]}">
                        ${drawerNicknameList[i]} <span class="badge">0</span>
                    </button>`;
                $('#drawerList').append(content);
            }

        },
        quit: function (data) {

        },
        presentPixel: function (data) {

        },
        createPageLayer: function (data) {
            const message = data['message'];
            const sender = message['user_id'];

            if (sender != user_id) {
                const page_no = message['page_no'];
                const layer_no = message['layer_no'];

                if (layer_no == 1) {
                    // 페이지 생성 + 1번 레이어 생성
                    const totalPage = layerSet.length;

                    createPage('receiver');

                    let content = `<div id="p${totalPage + 1}"></div>`;
                    $('#p' + (totalPage + 1)).appendTo('#base');

                    content = `<li data-tab="p${totalPage + 1}"><a href="#">p${totalPage + 1}</a></li>`

                    $('.tab').append(content);
                } else {
                    // 레이어 생성 (초기화용 함수였지만 원하는 기능이 같아서 이용)
                    initializeCreateLayer(page_no);
                }
            }
        },
        deletePageLayer: function (data) {
            const message = data['message'];
            const sender = message['user_id'];

            if (sender != user_id) {
                const layerId = `p${message['page_no']}l${message['layer_no']}`;
                $(`#${layerId}b`).remove();
                deleteLayer(layerId, 'receiver');
            }
        },
        drawing: function (data) {
            const message = data['message'];
            const sender = message['user_id'];

            if (sender != user_id) {
                const page_no = message['page_no'];
                const layer_no = message['layer_no'];
                const obj = message['stringify'];
                const targetObj = layerSet[page_no - 1][layer_no - 1];
                targetObj.loadFromJSON(obj, targetObj.renderAll.bind(targetObj));
            }
        },
        addAuthority: function (data) {
            const message = data['message'];
            const sender = message['user_id'];
            const targetId = message['targetId'];
            const targetNickname = message['targetNickname'];

            // 캔버스 잠금해제
            if (sender != user_id && targetId == user_id) {
                $('.drawReceiver').css({'display': ''});
            }

            // 드로워 리스트에 해당유저 추가.
            const content = `<button class="btn btn-primary" type="button" id="drawerTop-${targetId}">
                ${targetNickname} <span class="badge">0</span>
            </button>`;
            $('#drawerList').append(content);
        }
    }
})();

document.onkeydown = function (event) {
    if (event.keyCode === 116 || event.ctrlKey == true && (event.keyCode === 82)) {
        disconnect(room_Id, user_id);
        event.cancelBubble = true;
        event.returnValue = false;

        setTimeout(function () {
            window.location.reload();
        }, 100);

        return false;
    }
}

// ********** 소켓 관련 함수 ********** //
connect(); // 소켓 커넥트 실시

// 소켓 연결부
function connect() {
    const socket = new SockJS('/endpoint');
    socketClient = Stomp.over(socket);

    socketClient.connect({}, function (frame) {
        // 챗 메세지를 실시간으로 받아들이는 파트
        socketClient.subscribe(`/subscribe/drawing/room/${room_Id}`, function (result) {
            const data = JSON.parse(result.body);
            console.log(data);
            parser(data);
        });
    });

    //layer.loadFromJSON(data['stringify'], layer.renderAll.bind(layer));
}

// 메세지 전송 함수
function sendMessage(message, type) {
    const data = {
        type: type,
        message: message
    };

    // send process
    try {
        socketClient.send(`/drawing/room/${room_Id}`, {}, JSON.stringify(data));
    } catch (e) {
        console.log("메세지 전송실패");
        if (data['type'] == 'enter') {
            socketEntranceRepeater();
        }
    }
}

// 소켓 종료 메소드
function disconnect() {
    const message = {
        userId: user_id,
        message: mynickname + 'さんが退室しました。'
    };

    sendMessage(message, 'quit');

    socketClient.disconnect();
}

// ********** 소켓 전송과 관련된 이벤트 ********** //
// 페이지 종료 이벤트 --> 소켓종료
$(window).on('beforeunload', function () {
    disconnect();
});

function socketEntranceRepeater(){
    try {
        const enterData = {
            user_id: "BOT",
            nickname: mynickname,
            message: mynickname + "さんが入室しました。"
        };
        setTimeout(sendMessage, 500, enterData, 'enter');
    } catch (e) {
        console.log("소켓 생성전");
        socketEntranceRepeater();
    }
}

// `Message` parser
function parser(data) {
    let type = data['type'];
    type = type.toUpperCase();

    if (type == "COMMONCHAT") {
        socketFunctionSet.commonchat(data);
    } else if (type == "DRAWING") {
        socketFunctionSet.drawing(data);
    } else if (type == "ENTER") {
        socketFunctionSet.enter(data);
    } else if (type == "QUIT") {
        socketFunctionSet.quit(data);
    } else if (type == "CREATEPAGELAYER") {
        socketFunctionSet.createPageLayer(data);
    } else if (type == "PRESENTPIXEL") {
        socketFunctionSet.presentPixel(data);
    } else if (type == "DELETEPAGELAYER") {
        socketFunctionSet.deletePageLayer(data);
    } else if (type == "ADDAUTHORITY") {
        socketFunctionSet.addAuthority(data);
    }
}

// ********** 소켓 전송과 관련된 이벤트 끝 ********** //

// ********** fabric 관련 함수 ********** //
// rgba, 굵기, 투명도의 글로벌 정보를 업데이트하는 메소드
function colorChangeGlobal(opacity, thickness, rgb) {
    if (opacity != null && opacity != undefined) {
        opacityGlobal = opacity;
    }

    if (thickness != null && thickness != undefined) {
        thicknessGlobal = thickness;
    }

    if (rgb != null && rgb != undefined && rgb.length != 0) {
        let rgba = new fabric.Color(rgb).toRgba();
        rgbaGlobal = rgba.replaceAll('1)', opacityGlobal + ')');
    }

    changeBrush();
}

function changeBrush() {
    if (brushGlobal == 'PencilBrush') {
        currlayer.freeDrawingBrush = new fabric.PencilBrush(currlayer);
    } else if (brushGlobal == "SprayBrush") {
        currlayer.freeDrawingBrush = new fabric.SprayBrush(currlayer);
    } else if (brushGlobal == "CircleBrush") {
        currlayer.freeDrawingBrush = new fabric.CircleBrush(currlayer);
    } else if (brushGlobal == "EraserBrush") {
        currlayer.freeDrawingBrush = new fabric.PencilBrush(currlayer);
        currlayer.freeDrawingBrush.globalCompositeOperation = 'destination-out';
        currlayer.freeDrawingBrush.id = 'erasure';
    } else if (brushGlobal == "SquareBrush") {
        currlayer.freeDrawingBrush = new fabric.SquareBrush(currlayer);
    }

    console.log(typeof hexGlobal);
    console.log(hexGlobal);
    console.log(typeof thicknessGlobal);

    currlayer.freeDrawingBrush.color = hexGlobal;
    currlayer.freeDrawingBrush.width = thicknessGlobal;
}

function createLayer(isReceiver) {
    const totalNumOfLayer = layerSet[pageNum - 1].length;
    let layerId = 'p' + pageNum + 'l' + (totalNumOfLayer + 1);

    // 이부분에 canvas 태그를 생성하는 구문을 넣어줄 것 아이디는 layerId로 준다.
    let contents = `<canvas id="${layerId}" width="600px" height="600px"></canvas>`;
    $(`#p${pageNum}`).append(contents);

    ///////////////////////////////////////////////////////////////
    // TODO fabric 객체를 만들고 객체배열에 추가하는 프로세스
    let newLayer = new fabric.Canvas(layerId);
    newLayer.isDrawingMode = true;
    newLayer.freeDrawingBrush.width = thicknessGlobal;
    newLayer.freeDrawingBrush.color = hexGlobal;
    newLayer.freeDrawingBrush.opacity = opacityGlobal;
    layerSet[pageNum - 1].push(newLayer);
    console.log(layerSet);

    // TODO 이벤트객체를 이벤트배열에 추가하는 프로세스.
    const eventObj = newLayer.on('mouse:up', function () {
        const message = {
            user_id: user_id,
            page_no: pageNum,
            layer_no: totalNumOfLayer + 1,
            stringify: JSON.stringify(newLayer)
        };
        sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
    });
    eventSet[pageNum - 1].push(eventObj);
    console.log(eventSet);

    //TODO 부가적으로 생성된 canvas-container를 지우는 프로세스
    $('.canvas-container').attr('class', 'remove');
    if (user_id != admin_id) {
        $('.upper-canvas').attr('class', layerId + 'u');
        $(`.${layerId}u`).css({'display': 'none'}).addClass('drawReceiver');
    } else {
        $('.upper-canvas').attr('class', layerId + 'u');
        $(`.${layerId}u`).addClass('drawReceiver');
    }
    $('#' + layerId).appendTo('#p' + pageNum);
    $('.' + layerId + 'u').appendTo('#p' + pageNum);
    $('.remove').remove();

    // TODO z-index CSS 속성을 부여하고 Z-INDEX 배열에 추가하는 프로세스
    $('#' + layerId).css({'z-index': totalNumOfLayer + 1});
    $('.' + layerId + 'u').css({'z-index': totalNumOfLayer + 1});
    zNumSet[pageNum - 1].push(totalNumOfLayer + 1);
    console.log(zNumSet);

    // TODO 레이어 리스트에 추가하는 메소드
    createItem(layerId);

    ///////////////////////////////////////////////////////////////

    // 소켓에 레이어를 생성했다는 정보를 쏴주는 구문 (이니셜라이즈 문제가 있어 isInitialized 도입)
    if (isInitialized) {
        if (isReceiver == undefined) {
            const message = {
                user_id: user_id,
                page_no: pageNum,
                layer_no: totalNumOfLayer + 1
            };

            sendMessage(message, 'CREATEPAGELAYER');
        }
    }

    ///////////////////////////////////////////////////////////////
}

function initializeCreateLayer(pageNo) {
    const totalNumOfLayer = layerSet[pageNo - 1].length;
    let layerId = 'p' + pageNo + 'l' + (totalNumOfLayer + 1);

    // 이부분에 canvas 태그를 생성하는 구문을 넣어줄 것 아이디는 layerId로 준다.
    let contents = `<canvas id="${layerId}" width="600px" height="600px"></canvas>`;
    $(`#p${pageNo}`).append(contents);

    ///////////////////////////////////////////////////////////////
    // TODO fabric 객체를 만들고 객체배열에 추가하는 프로세스
    let newLayer = new fabric.Canvas(layerId);
    newLayer.isDrawingMode = true;
    newLayer.freeDrawingBrush.width = thicknessGlobal;
    newLayer.freeDrawingBrush.color = hexGlobal;
    newLayer.freeDrawingBrush.opacity = opacityGlobal;
    layerSet[pageNo - 1].push(newLayer);
    console.log(layerSet);

    // TODO 이벤트객체를 이벤트배열에 추가하는 프로세스.
    const eventObj = newLayer.on('mouse:up', function () {
        const message = {
            user_id: user_id,
            page_no: pageNo,
            layer_no: totalNumOfLayer + 1,
            stringify: JSON.stringify(newLayer)
        };
        sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
    });
    eventSet[pageNo - 1].push(eventObj);
    console.log(eventSet);

    //TODO 부가적으로 생성된 canvas-container를 지우는 프로세스
    $('.canvas-container').attr('class', 'remove');
    if (user_id != admin_id) {
        $('.upper-canvas').attr('class', layerId + 'u');
        $(`.${layerId}u`).css({'display': 'none'}).addClass('drawReceiver');
    } else {
        $('.upper-canvas').attr('class', layerId + 'u');
        $(`.${layerId}u`).addClass('drawReceiver');
    }
    $('#' + layerId).appendTo('#p' + pageNo);
    $('.' + layerId + 'u').appendTo('#p' + pageNo);
    $('.remove').remove();

    // TODO z-index CSS 속성을 부여하고 Z-INDEX 배열에 추가하는 프로세스
    $('#' + layerId).css({'z-index': totalNumOfLayer + 1});
    $('.' + layerId + 'u').css({'z-index': totalNumOfLayer + 1});
    zNumSet[pageNo - 1].push(totalNumOfLayer + 1);
    console.log(zNumSet);
}

function createPage(isReceiver) {
    const totalNumOfPage = layerSet.length;
    const pageId = 'p' + (totalNumOfPage + 1); // 예: length가 1이면 2번 페이지를 만들어야한다

    // 이 부분에 canvas 태그 생성구문을 넣을 것. 아이디는 p만든레이어번호l1로 준다.
    // 첫 레이어는 자동생성을 하는 편이 좋을 듯 싶다.
    let contents = `<canvas id="${pageId}l1" width="600px" height="600px"></canvas>`;
    $('#base').append(contents);

    ///////////////////////////////////////////////////////////////

    // TODO 객체 배열 및 z-index배열을 만드는 프로세스
    layerSet.push([]);
    zNumSet.push([]);
    eventSet.push([]);

    // TODO 해당 페이지의 첫 레이어를 만드는 프로세스
    let newLayer = new fabric.Canvas(pageId + 'l1');
    newLayer.isDrawingMode = true;
    newLayer.freeDrawingBrush.width = thicknessGlobal;
    newLayer.freeDrawingBrush.color = hexGlobal;
    newLayer.freeDrawingBrush.opacity = opacityGlobal;
    layerSet[totalNumOfPage].push(newLayer); // 예: 2번 페이지는 1번 인덱스이다.
    console.log(layerSet);

    // TODO canvas-container를 단 1개로 유지하기 위해 ID속성부여 프로세스
    $('.canvas-container').attr('id', pageId);
    $('.upper-canvas').attr('class', pageId + 'l1u');
    if (user_id != admin_id) {
        $('.upper-canvas').attr('class', pageId + 'l1u');
        $(`.${pageId}l1u`).css({'display': 'none'}).addClass('drawReceiver');
    } else {
        $('.upper-canvas').attr('class', pageId + 'l1u');
        $(`.${pageId}l1u`).addClass('drawReceiver');
    }
    $('#' + pageId).attr('class', 'tabcontent');

    // TODO 생성된 canvas 태그들에 z-index를 부여하고 zNumSet에 반영하는 프로세스
    $('#' + pageId + 'l1').css({"z-index": 1});
    $('.' + pageId + 'l1u').css({"z-index": 1});
    zNumSet[totalNumOfPage].push(1);
    console.log(zNumSet);

    // TODO 이벤트 객체를 eventSet에 넣는 프로세스
    const eventObj = newLayer.on('mouse:up', function () {
        const message = {
            user_id: user_id,
            page_no: totalNumOfPage + 1,
            layer_no: 1,
            stringify: JSON.stringify(newLayer)
        };
        sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
    });
    eventSet[totalNumOfPage].push(eventObj);
    console.log(eventSet);

    // 소켓에 페이지를 만들었다는 정보를 쏴주는 구문 (이니셜라이즈 문제가 있어 isInitialized 도입)
    if (isInitialized) {
        if (isReceiver == undefined) {
            const message = {
                user_id: user_id,
                page_no: totalNumOfPage + 1,
                layer_no: 1
            };
            sendMessage(message, 'CREATEPAGELAYER');
        }
    }
    ///////////////////////////////////////////////////////////////
}

function deleteLayer(layerId, isReceiver) {
    let temp = layerId.split("p");
    temp = temp[1].split("l");
    let pageNumber = parseInt(temp[0]);
    let layerNumber = parseInt(temp[1]);

    $('#' + layerId).remove();
    $('.' + layerId + 'u').remove();

    layerSet[pageNumber - 1][layerNumber - 1] = null;
    zNumSet[pageNumber - 1][layerNumber - 1] = null;
    eventSet[pageNumber - 1][layerNumber - 1] = null;

    // 소켓에 레이어를 지웠다고 전송하는 구문 (추후작성예정)
    if (isReceiver == undefined) {
        const message = {
            user_id: user_id,
            page_no: pageNumber,
            layer_no: layerNumber
        };
        sendMessage(message, 'DELETEPAGELAYER');
    }
}

function deletePage(isReceiver) {
    const layerLength = layerSet[pageNum - 1].length;

    $('#p' + pageNum).remove();

    layerSet[pageNum - 1] = [];
    zNumSet[pageNum - 1] = [];
    eventSet[pageNum - 1] = [];

    // 소켓에 페이지를 지웠다고 전송하는 구문 (추후작성예정)
    if (isReceiver == undefined) {

    }
}

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
        $(".itemBox").each(function () {
            let temp = $(this).attr("id");
            temp = temp.split('b');
            itemBoxIdArray.push(temp[0]);

            // z index reodering
            for (let i = 0; i < itemBoxIdArray.length; i++) {
                let temp2 = itemBoxIdArray[i].split('p');
                temp2 = temp2[1].split('l');
                zNumSet[temp2[0] - 1][temp2[1] - 1] = i + 1;
                $('#' + itemBoxIdArray[i]).css({'z-index': i + 1});
                $('.' + itemBoxIdArray[i] + 'u').css({'z-index': i + 1});
            }
        });
    });
}

// ******************** 레이어 리스트 관련 함수 ********************//
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
    })
        .click(function () {
            $('#' + layerId + 'b').css('backgroundColor', 'red');
        });
    // 숫자를 다시 붙인다.
    reorder();
}


/*********************** 이벤트 등록파트 *******************/
$(() => {
    // ************로딩후 사용할 수 있는 전역변수 ********************/
    filter = document.getElementById('filter');
    list = document.getElementById('list');

    // ************ 레이어 리스트 초기설정 *****************//
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
    // ********** 레이어 이니셜라이저 실행  ***************//
    initializer();

    // ******************** Page Layer Initializer ******************** //
    function initializer() {
        const data = {
            room_Id: room_Id
        };
        let layers = null;

        $.ajax({
            url: "/drawing/getAllLayers",
            type: "POST",
            dataType: "json",
            async: false,
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (result) {
                layers = result;
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });

        let i = 2;
        for (let layer of layers) {
            const page_no = layer['page_no'];
            const layer_no = layer['layer_no'];
            const obj = layer['stringify'];

            if (page_no == i || (page_no == 1 && layer_no == 1)) {
                // 크리에이트 탭 버튼을 누르는 효과를 주는 구문
                const totalPage = layerSet.length;

                createPage('receiver');

                let content = `<div id="p${totalPage + 1}"></div>`;
                $('#p' + (totalPage + 1)).appendTo('#base');

                content = `<li data-tab="p${totalPage + 1}"><a href="#">p${totalPage + 1}</a></li>`

                $('.tab').append(content);
                /////////////////////////////////////////////////////
                let targetObj = layerSet[page_no - 1][layer_no - 1];
                targetObj.loadFromJSON(obj, targetObj.renderAll.bind(targetObj));

                if (page_no != 1) {
                    i++;
                }
            } else {
                initializeCreateLayer(page_no);
                let targetObj = layerSet[page_no - 1][layer_no - 1];
                targetObj.loadFromJSON(obj, targetObj.renderAll.bind(targetObj));
            }
        } // FOR END

        isInitialized = true;
    }

    // Layer Explorer를 클릭시 현재 페이지번호, 레이어번호를 업데이트하고 현재 바라보는 레이어를 설정.
    $(document).on('click', '#itemBoxWrap', function (event) {
        console.log("레이어 타게팅 체인지 함수");
        let layerBoxId = event.target.id;
        // 전 단계 페이지 레이어 번호 지정 및 z인덱스
        bPageNum = pageNum;
        bLayerNum = layerNum;
        const bPageLayer = "p" + bPageNum + "l" + bLayerNum;
        // 전 단계 upper-canvas의 z-index를 원상복구한다.
        $('#' + bPageLayer + 'u').css({"z-index": zNumSet[bPageNum - 1][bLayerNum - 1]});

        // 현 단계 페이지 번호 지정
        layerBoxId = layerBoxId.split('b')[0];
        layerBoxId = layerBoxId.split('p');
        layerBoxId = layerBoxId[1].split('l');
        pageNum = parseInt(layerBoxId[0]);
        layerNum = parseInt(layerBoxId[1]);
        console.log(pageNum);
        console.log(layerNum);
        const pageLayer = "p" + pageNum + "l" + layerNum;

        // 레이어 타게팅
        currlayer = layerSet[pageNum - 1][layerNum - 1];
        changeBrush();
        // 타게팅한 레이어를 그릴수 있는 upper-canvas를 가장 위에둔다.
        $('.' + pageLayer + "u").css({"z-index": 10000});
    });

    // ************ 페이지텝 이벤트 *********/
    $(document).on('click', 'ul.tab li', function () {
        let activeTab = $(this).attr('data-tab');
        $('ul.tab li').removeClass('current');
        $('.tabcontent').removeClass('current');
        $(this).addClass('current');
        $('#' + activeTab).addClass('current');

        // 레이어 리스트 박스를 초기화한다.
        $('#itemBoxWrap').empty();

        // 클릭한 페이지 번호를 현재 페이지 번호로 가진다.
        if (activeTab != "create") {
            bPageNum = pageNum; // 그전에 이전 레이어 번호로 넘긴다.
            pageNum = parseInt(activeTab.substr(1, activeTab.length));
            console.log(activeTab.substr(1, activeTab.length));

            // z-index가 가장 큰 레이어 판단한다.
            let maxzNum = 0;
            let maxL = 0;
            for (let i = 1; i <= layerSet[pageNum - 1].length; i++) {
                let zNum = $(`.p${pageNum}l${i}u`).css('z-index');

                if (zNum > maxzNum) {
                    maxzNum = zNum;
                    maxL = i;
                }
            }
            // 현재 레이어를 z-index가 가장 큰 레이어로 한다.
            layerNum = maxL;
            currlayer = layerSet[pageNum - 1][maxL - 1];

            // 레이어 리오더링
            let numOfLayer = layerSet[pageNum - 1].length;
            for (let j = 1; j <= numOfLayer; j++) {
                for (let k = 0; k < numOfLayer; k++) {
                    if (zNumSet[pageNum - 1][k] == j) {
                        if (layerSet[pageNum - 1][k] != null) {
                            const layerId = "p" + pageNum + "l" + (k + 1);
                            createItem(layerId);
                        }
                        break;
                    }
                }
            }

            changeBrush();
        } // if end
    });

    //************* 페이지 생성 이벤트 ******************//
    $('#createPage').click(function () {
        const totalPage = layerSet.length;

        createPage();

        let content = `<div id="p${totalPage + 1}"></div>`;
        $('#p' + (totalPage + 1)).appendTo('#base');

        content = `<li data-tab="p${totalPage + 1}"><a href="#">p${totalPage + 1}</a></li>`

        $('.tab').append(content);
    });

    // ******************* 레인지바 초기설정함수 *****************//
    (function initAndSetupTheSliders() {
        var inputs = [].slice.call(document.querySelectorAll('.range-slider input'));
        inputs.forEach(function (input) {
            return input.setAttribute('value', '10');
        });
        inputs.forEach(function (input) {
            return sliderObj.updateSlider(input);
        });
        // Cross-browser support where value changes instantly as you drag the handle, therefore two event types.
        inputs.forEach(function (input) {
            return input.addEventListener('input', function (element) {
                return sliderObj.updateSlider(input);
            });
        });
        inputs.forEach(function (input) {
            return input.addEventListener('change', function (element) {
                return sliderObj.updateSlider(input);
            });
        });
    })();

    //******************* 색, 굵기, 투명도 변경과 관련된 이벤트 ********//
    $(document).on('mouseup', '.range-container', function () {
        console.log("레인지바 이벤트 작동");

        const MAX_THICKNESS = 20;
        const MAX_OPACITY = 1;

        let thickness = $('#thicknessBar').text();
        thickness = parseInt(thickness.split('%')[0]);
        thickness = MAX_THICKNESS * (thickness / 100);
        let opacity = $('#opacityBar').text();
        opacity = parseInt(opacity.split('%')[0]);
        opacity = MAX_OPACITY * (opacity / 100);

        console.log(typeof thickness);
        console.log(thickness);
        console.log(opacity);

        hexGlobal = $('#drawing-color').val() + Math.floor(opacity * 255).toString(16);

        thicknessGlobal = thickness;
        opacityGlobal = opacity;

        changeBrush();
    });

    // ***************** 색상 변경 이벤트  ************************//
    $('#drawing-color').on('change', function () {
        hexGlobal = $('#drawing-color').val() + Math.floor(opacityGlobal*255).toString(16);

        changeBrush();
    });

    // *************** 브러시 버튼 클릭 이벤트 ********************* //
    // deprecated
    $(document).on('click', '.brushElement', function (event) {

    });

    // ********************* 드로잉 권한부여 이벤트 *************************//
    $(document).on('click', '.addAuthority', function (event) {
        if (authCount < 4) {
            let targetId = event.target.id;
            let targetNickname = $('#'+targetId).parent().text();
            targetNickname = targetNickname.split('一緒に')[0];
            targetId = targetId.split('list')[1];

            const message = {
                user_id: user_id,
                targetId: targetId,
                targetNickname: targetNickname
            };

            $(`#${event.target.id}`).remove();

            sendMessage(message, 'ADDAUTHORITY');

            authCount++;
        } else {
            alert('권한은 최대 4명만 부여 가능합니다.');
        }


    });

    // ****************** 우저리스트 필터 이벤트 ************************/
    filter.addEventListener('keyup', function (e) {
        listItems = list.querySelectorAll('li');
        let val = new RegExp(e.target.value, 'gi');
        for (let i = 0; i < listItems.length; i++) {
            if (e.target.value.length > 0) {
                let text = listItems[i].innerHTML;

                if (!text.match(val)) {
                    listItems[i].classList.add('is-hidden');
                } else {
                    listItems[i].classList.remove('is-hidden');
                }
            } else {
                listItems[i].classList.remove('is-hidden');
            }

        }
    });

//****************************** 브러시(만) 변경 이벤트  ****************************//
    $('#brushTap').on('click', function(event){
        console.log("브러시 선택 버튼 클릭으로 인한 브러시 변경 이벤트 발생");

        let brushType = event.target.id;

        if (brushType != 'selector') {
            brushGlobal = brushType;
            changeBrush();
        } else {
            const modeChecker = layerSet[0][0].isDrawingMode;

            for (let i=0; i<layerSet.length; i++) {
                for (let j=0; j<layerSet[i].length; j++) {
                    layerSet[i][j].isDrawingMode = !modeChecker;
                }
            }
        }


        // dropdown이 클릭하더라도 닫히지 않도록 이벤트 버블링 차단(range bar 편의성을 위해)
        event.stopPropagation();
    });

    // 방입장 메세지 전송파트 (소켓 연결은 비동기 이기 때문에 언제 연결될지 모른다)
    socketEntranceRepeater();
});