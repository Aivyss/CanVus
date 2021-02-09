// ********** 전역변수 셋 ********** //
// 전체 레이어 객체 및 z-index를 저장하는 리스트
const layerSet = []; // 예: p3l2의 패브릭 객체는 layerSet[2][1]
const zNumSet = []; // 예: p1l1이 z-index가 3이라면 zNumSet[0][0]  == 3

// 현재 바라보고 있는 레이어 객체
let currlayer = null;

// 현재 바라보고 있는 페이지 번호와 레이어번호
let pageNum = 0;
let layerNum = 0;

// 전 단계에서 바라보고 있던 페이지번호와 레이어번호
let bPageNum = 0;
let bLayerNum = 0;

// rbgaGlobal 정보 (주입된 값은 초기값이므로 신경쓰지 않아도 된다.)
let opacityGlobal = 0;
let thicknessGlobal = 5;
let rgbaGlobal = new fabric.Color("black").toRgba(); rgbaGlobal = rgbaGlobal.replaceAll('1)', opacityGlobal + ')');
let brushGlobal = "PencilBrush";

// 소켓 클라이언트 정의
let chatClient = null;
let fabricClient = null;

// 소켓 테스트 용 전역변수
var layer = null;



// ********** 소켓 관련 함수 ********** //
$(() => {
    // 대강의 패브릭 객체 만들자
    layer= new fabric.Canvas('socketLayer');
    layer.isDrawingMode = true;

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

    // 버튼을 클릭하면 fabric 객체를 보낸다. 단 실제로 이렇게 안하고 백단테스트용
    $('#btn').on('click', ()=> {
        sendFabric(layer, 1, 1, room_Id);
    });

    // 버튼을 클릭하면 챗 메세지를 보낸다. 단 실제로 이렇게 안하고 백단 테스트 용.
    $('#btn2').on('click', () => {
        sendMessage('aivyss-메세지', 'commonchat');
    });

    //그려지면 전송하는 구조
    layer.on('mouse:up', function() {
        sendFabric(layer, 1, 1);
    });

    // 소켓 연결부
    function connect() {
        const socket1 = new SockJS('/endpoint');
        const socket2 = new SockJS('/endpoint');
        chatClient = Stomp.over(socket1);
        fabricClient = Stomp.over(socket2);

        chatClient.connect({}, function(frame) {
            // 챗 메세지를 실시간으로 받아들이는 파트
            chatClient.subscribe(`/subscribe/drawing/room/${room_Id}/chat`, function(result) {
                const data = JSON.parse(result.body);
                console.log(data);
            });
        });

        fabricClient.connect({}, function(frame) {
            fabricClient.subscribe(`/subscribe/drawing/room/${room_Id}/fabric`, function(result) {
                const data = JSON.parse(result.body);
                console.log(data);
                console.log(data['stringify']);
                layer.loadFromJSON(data['stringify'], layer.renderAll.bind(layer));
            });
        });
    }

    // 패브릭 객체 전송 함수
    function sendFabric(fabricObj, page, layer) {
        // fabric 객체를 보내는 과정 page, layer는 1, room_Id는 "a"이라 가정한다.
        // fabric 객체도 대강 하자. 위에 canvas객체로 대강 때려 넣었다.

        // stringify process
        const data = {
            room_Id : room_Id,
            page_no : page,
            layer_no : layer,
            stringify : JSON.stringify(fabricObj)
        };

        // send process
        fabricClient.send(`/drawing/room/${room_Id}/fabric`, {}, JSON.stringify(data));
    }

    // 메세지 전송 함수
    function sendMessage(message, type) {
        const data = {
            type : type,
            room_Id : room_Id,
            message : message
        };

        // send process
        chatClient.send(`/drawing/room/${room_Id}/chat`, {}, JSON.stringify(data));
    }

    // 페이지 종료 이벤트 --> 소켓종료
    $(window).on('beforeunload', function() {
        disconnect();
    });

    // 소켓 종료 메소드
    function disconnect() {
        sendMessage(user_id, 'quit');

        chatClient.disconnect();
        fabricClient.disconnect();
    }
});


// ********** fabric 관련 함수 ********** //
$(() => {
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
        const totalNumOfLayer = layerSet[pageNum].length;
        let layerId = 'p' + pageNum + 'l' + totalNumOfLayer;

        // 이부분에 html상으로 캔버스를 생성하는 구문을 넣어줄 것 아이디는 layerId로 준다.
        
        /**
         * 작성 바람
         */

        ///////////////////////////////////////////////////////////////

        // 객체배열 및 z-index 배열에 값을 추가하는 프로세스.
        let newLayer = new fabric.Canvas(layerId);
        layerSet[pageNum].push(newLayer);
        ///////////////////////////////////////////////////////////////

        // fabric 객체 생성에 의해 만들어진 upper-canvas를 한 div로 모아주는 구문을 넣어줄 것.
        // 주의사항1: upper-canvas도 id를 부여해야한다.

        /**
         * 작성 바람
         */

        ///////////////////////////////////////////////////////////////

        // 소켓에 레이어를 생성했다는 정보를 쏴주는 구문 (추후 작성예정)
        
        /**
         * 나중에 작성할 예정
         */

        ///////////////////////////////////////////////////////////////
    }

    function createPage() {
        const totalNumOfPage = layerSet.length;
        const pageId = 'p' + (totalNumOfLayer+1);
        
        // 이 부분에 html 상으로 페이지를 생성하는 구문을 넣어줄 것 아이디는 pageId로 준다.
        // 첫 레이어는 자동생성을 하는 편이 좋을 듯 싶다.

        /**
         * 작성바람
         */

        ///////////////////////////////////////////////////////////////
        
        // 객체 배열 및 z-index를 수정하는 프로세스
        layerSet.push([]);
        let newLayer = new fabric.Canvas(pageId + 'l1');
        layerSet[totalNumOfPage].push(newLayer);
        
        // 소켓에 페이지를 만들었다는 정보를 쏴주는 구문 (추후 작성예정)

        /**
         * 나중에 작성할 예정
         */

        ///////////////////////////////////////////////////////////////
    }

    // Layer Explorer를 클릭시 현재 페이지번호, 레이어번호를 업데이트하고 현재 바라보는 레이어를 설정.
    $("#itemBoxWrap").click(function(event) {
        const layerBoxId = event.target.id;
        // 전 단계 페이지 레이어 번호 지정 및 z인덱스
        bPageNum = pageNum;
        bLayerNum = layerNum;
        const bPageLayer = "p" + bPageNum + "l" + bLayerNum;
        // 전 단계 upper-canvas의 z-index를 원상복구한다.
        $('#'+bPageLayer+'u').css({"z-index": zNumSet[bPageNum-1][bLayerNum-1]});

        // 현 단계 페이지 번호 지정
        pageNum = $(layerBoxId).children('.pageNum').val();
        layerNum = $(layerBoxId).children('.layerNum').val();
        const pageLayer = "p"+pageNum+"l"+layerNum;

        // 레이어 타게팅
        currlayer = layerSet[pageNum-1][layerNum-1];
        changeBrush();
        // 타게팅한 레이어를 그릴수 있는 upper-canvas를 가장 위에둔다. 2147483647는 z-index 최대값이다.
        $('#'+pageLayer+"u").css({"z-index": 2147483647});
    });
});

// ********** 소켓 전송과 관련된 이벤트 ********** //
$(()=>{
    // 그림이 그려진 레이어의 객체를 인식해 소켓으로 그려진 정보를 전송하는 이벤트.
    $('.canvas-container').click(function(event) {
        const object = JSON.stringify(currlayer);
        sendFabric(currlayer, pageNum, layerNum, room_Id);
    });

    // 채팅을 소켓으로 전송하는 이벤트
    $('#send').on('click', ()=>{
        const message = $('#chatBox').val();
        if(message.length > 0) {
            sendMessage(message, 'COMMONCHAT');
        }
        $('#chatBox').val("");
    });
});