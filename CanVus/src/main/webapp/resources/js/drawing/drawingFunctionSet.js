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
let rgbaGlobal = new fabric.Color("black").toRgba(); rgbaGlobal = rgbaGlobal.replaceAll('1)', opacityGlobal + ')');
let brushGlobal = "PencilBrush";

// 소켓 클라이언트 정의
let socketClient = null;

// 소켓 테스트 용 전역변수
var layer = null;



// ********** 소켓 관련 함수 ********** //
connect(); // 소켓 커넥트 실시

document.onkeydown = function (event) {
    if(event.keyCode === 116 || event.ctrlKey == true && (event.keyCode === 82)) {
        disconnect(room_Id, user_id);
        event.cancelBubble = true;
        event.returnValue = false;

        setTimeout(function() {
            window.location.reload();
        }, 100);

        return false;
    }
}

// 소켓 연결부
function connect() {
    const socket = new SockJS('/endpoint');
    socketClient = Stomp.over(socket);

    socketClient.connect({}, function(frame) {
        // 챗 메세지를 실시간으로 받아들이는 파트
        socketClient.subscribe(`/subscribe/drawing/room/${room_Id}`, function(result) {
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
        type : type,
        message : message
    };

    // send process
    socketClient.send(`/drawing/room/${room_Id}`, {}, JSON.stringify(data));
}

// 소켓 종료 메소드
function disconnect() {
    const message = {
        userId : user_id
    };

    sendMessage(message, 'quit');

    socketClient.disconnect();
}

// ********** 소켓 전송과 관련된 이벤트 ********** //
// 채팅을 소켓으로 전송하는 이벤트
$('#send').on('click', ()=>{
    const message = $('#chatBox').val();
    if(message.length > 0) {
        sendMessage(message, 'COMMONCHAT');
    }
    $('#chatBox').val("");
});

// 페이지 종료 이벤트 --> 소켓종료
$(window).on('beforeunload', function() {
    disconnect();
});

// 방입장 메세지 전송파트 (일단 임시로 하고 만약 비동기가 이래도 처리가 안되면
// 반복문으로 처리할 것이다.
const enterData = {
    user_id : user_id,
    nickname : mynickname
};
setTimeout(sendMessage, 1000, enterData, 'enter');

// Message parser
function parser(data) {
    let type = data['type'];
    type = type.toUpperCase();

    if (type == "COMMONCHAT") {
        commonchat(data);
    } else if (type == "DRAWING") {
        drawing(data);
    } else if (type == "ENTER") {
        enter(data);
    } else if (type == "QUIT") {
        quit(data);
    } else if (type == "CREATEPAGELAYER") {
        createPageLayer(data);
    } else if (type == "PRESENTPIXEL") {
        presentPixel(data);
    } else if (type == "DELETEPAGELAYER"){
        deletePageLayer(data);
    }
}

function commonchat(data) {
    messageController.chatReply(data);
}

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
    } else if (brushGlobal == "BaseBrush") {
        currlayer.freeDrawingBrush = new fabric.BaseBrush(currlayer);
    } else if (brushGlobal == "PatternBrush") {
        currlayer.freeDrawingBrush = new fabric.BaseBrush(currlayer);
    }

    currlayer.freeDrawingBrush.color = rgbaGlobal;
    currlayer.freeDrawingBrush.width = thicknessGlobal;
}

function createLayer() {
    const totalNumOfLayer = layerSet[pageNum-1].length;
    let layerId = 'p' + pageNum + 'l' + (totalNumOfLayer+1);

    // 이부분에 canvas 태그를 생성하는 구문을 넣어줄 것 아이디는 layerId로 준다.
    let contents = `<canvas id="${layerId}"></canvas>`;
    $(`#p${pageNum}`).append(contents);

    ///////////////////////////////////////////////////////////////
    // TODO fabric 객체를 만들고 객체배열에 추가하는 프로세스
    let newLayer = new fabric.Canvas(layerId);
    newLayer.isDrawingMode = true;
    layerSet[pageNum-1].push(newLayer);
    console.log(layerSet);

    // TODO 이벤트객체를 이벤트배열에 추가하는 프로세스.
    const eventObj = newLayer.on('mouse:up', function() {
        const message = {
            page_no: pageNum,
            layer_no : totalNumOfLayer+1,
            stringify: JSON.stringify(newLayer)
        };
        sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
    });
    eventSet[pageNum-1].push(eventObj);
    console.log(eventSet);

    //TODO 부가적으로 생성된 canvas-container를 지우는 프로세스
    $('.canvas-container').attr('class', 'remove');
    $('.upper-canvas').attr('class', layerId+'u');
    $('#'+layerId).appendTo('#p'+pageNum);
    $('.'+layerId+'u').appendTo('#p'+pageNum);
    $('.remove').remove();

    // TODO z-index CSS 속성을 부여하고 Z-INDEX 배열에 추가하는 프로세스
    $('#'+layerId).css({'z-index':totalNumOfLayer+1});
    $('.'+layerId+'u').css({'z-index':totalNumOfLayer+1});
    zNumSet[pageNum-1].push(totalNumOfLayer+1);
    console.log(zNumSet);

    // TODO 레이어 리스트에 추가하는 메소드
    createItem(layerId);

    ///////////////////////////////////////////////////////////////

    // 소켓에 레이어를 생성했다는 정보를 쏴주는 구문
    const message = {
        page_no: pageNum,
        layer_no: totalNumOfLayer+1
    }

    sendMessage(message,'CREATEPAGELAYER');
    ///////////////////////////////////////////////////////////////
}

function createPage() {
    const totalNumOfPage = layerSet.length;
    const pageId = 'p' + (totalNumOfPage+1); // 예: length가 1이면 2번 페이지를 만들어야한다

    // 이 부분에 canvas 태그 생성구문을 넣을 것. 아이디는 p만든레이어번호l1로 준다.
    // 첫 레이어는 자동생성을 하는 편이 좋을 듯 싶다.
    let contents = `<canvas id="${pageId}l1"></canvas>`;
    $('#base').append(contents);

    ///////////////////////////////////////////////////////////////

    // TODO 객체 배열 및 z-index배열을 만드는 프로세스
    layerSet.push([]);
    zNumSet.push([]);
    eventSet.push([]);

    // TODO 해당 페이지의 첫 레이어를 만드는 프로세스
    let newLayer = new fabric.Canvas(pageId + 'l1');
    newLayer.isDrawingMode = true;
    layerSet[totalNumOfPage].push(newLayer); // 예: 2번 페이지는 1번 인덱스이다.
    console.log(layerSet);

    // TODO canvas-container를 단 1개로 유지하기 위해 ID속성부여 프로세스
    $('.canvas-container').attr('id', pageId);
    $('.upper-canvas').attr('class', pageId+'l1u');
    $('#'+pageId).attr('class', 'tabcontent');

    // TODO 생성된 canvas 태그들에 z-index를 부여하고 zNumSet에 반영하는 프로세스
    $('#'+pageId+'l1').css({"z-index": 1});
    $('.'+pageId+'l1u').css({"z-index": 1});
    zNumSet[totalNumOfPage].push([1]);
    console.log(zNumSet);

    // TODO 이벤트 객체를 eventSet에 넣는 프로세스
    const eventObj = newLayer.on('mouse:up', function() {
        const message = {
            page_no: totalNumOfPage+1,
            layer_no : 1,
            stringify: JSON.stringify(newLayer)
        };
        sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
    });
    eventSet[totalNumOfPage].push(eventObj);
    console.log(eventSet);

    // 소켓에 페이지를 만들었다는 정보를 쏴주는 구문 (추후 작성예정)
    const message = {
        page_no: totalNumOfPage+1,
        layer_no: 1
    }

    sendMessage(message,'CREATEPAGELAYER');

    ///////////////////////////////////////////////////////////////
}

// Layer Explorer를 클릭시 현재 페이지번호, 레이어번호를 업데이트하고 현재 바라보는 레이어를 설정.
$(document).on('click', '#itemBoxWrap' ,function(event) {
    console.log("레이어 타게팅 체인지 함수");
    let layerBoxId = event.target.id;
    // 전 단계 페이지 레이어 번호 지정 및 z인덱스
    bPageNum = pageNum;
    bLayerNum = layerNum;
    const bPageLayer = "p" + bPageNum + "l" + bLayerNum;
    // 전 단계 upper-canvas의 z-index를 원상복구한다.
    $('#'+bPageLayer+'u').css({"z-index": zNumSet[bPageNum-1][bLayerNum-1]});

    // 현 단계 페이지 번호 지정
    layerBoxId = layerBoxId.split('b')[0];
    layerBoxId = layerBoxId.split('p');
    layerBoxId = layerBoxId[1].split('l');
    pageNum = parseInt(layerBoxId[0]);
    layerNum = parseInt(layerBoxId[1]);
    console.log(pageNum);
    console.log(layerNum);
    const pageLayer = "p"+pageNum+"l"+layerNum;

    // 레이어 타게팅
    currlayer = layerSet[pageNum-1][layerNum-1];
    changeBrush();
    // 타게팅한 레이어를 그릴수 있는 upper-canvas를 가장 위에둔다.
    $('.'+pageLayer+"u").css({"z-index": 10000});
    //$('#'+pageLayer).css({"z-index": 10000});
    //$('.current').trigger('click');
});


function deleteLayer(layerId) {
    let temp = layerId.split("p");
    temp = temp[1].split("l");
    let pageNumber = parseInt(temp[0]);
    let layerNumber = parseInt(temp[1]);

    $('#'+layerId).remove();
    $('.'+layerId+'u').remove();

    layerSet[pageNumber-1][layerNumber-1] = null;
    zNumSet[pageNumber-1][layerNumber-1] = null;
    eventSet[pageNumber-1][layerNumber-1] = null;

    // 소켓에 레이어를 지웠다고 전송하는 구문 (추후작성예정)
    const message = {
        page_no: pageNumber,
        layer_no: layerNumber
    }
    sendMessage(message,'DELETEPAGELAYER');
}

function deletePage() {
    const layerLength = layerSet[pageNum-1].length;

    $('#p'+pageNum).remove();

    layerSet[pageNum-1] = [];
    zNumSet[pageNum-1] = [];
    eventSet[pageNum-1] = [];

    // 소켓에 페이지를 지웠다고 전송하는 구문 (추후작성예정)
}


$(()=>{
    $(document).on('click', 'ul.tab li', function() {
        let activeTab = $(this).attr('data-tab');
        $('ul.tab li').removeClass('current');
        $('.tabcontent').removeClass('current');
        $(this).addClass('current');
        $('#'+activeTab).addClass('current');

        // 레이어 리스트 박스를 초기화한다.
        $('#itemBoxWrap').empty();

        // 클릭한 레이어 번호를 현재 레이어 번호로 가진다.
        if (activeTab != "create") {
            bPageNum = pageNum; // 그전에 이전 레이어 번호로 넘긴다.
            pageNum = parseInt(activeTab.substr(1, activeTab.length));
            console.log(activeTab.substr(1, activeTab.length));

            // 레이어 리오더링
            let numOfLayer = layerSet[pageNum-1].length;
            for (let j=1; j<=numOfLayer; j++){
                for (let k=0; k<numOfLayer; k++) {
                    if(zNumSet[pageNum-1][k] == j) {
                        if (layerSet[pageNum-1][k] !=null) {
                            const layerId = "p"+pageNum+"l"+(k+1);
                            createItem(layerId);
                        }
                        break;
                    }
                }
            }

            // for (let i=0; i<numOfLayer; i++) {
            //     if(layerSet[pageNum-1][i] != null) {
            //         const layerId = "p"+pageNum+"l"+(i+1);
            //         createItem(layerId);
            //     }
            // }
        }

    });

    $('#createPage').click(function() {
        const totalPage = layerSet.length;

        createPage();

        let content = `<div id="p${totalPage+1}"></div>`;
        $('#p'+(totalPage+1)).appendTo('#base');

        content = `<li data-tab="p${totalPage+1}"><a href="#">p${totalPage+1}</a></li>`

        $('.tab').append(content);
    });
});
