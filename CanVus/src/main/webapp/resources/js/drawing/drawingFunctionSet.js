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

// 권한부여자 카운팅
let authCount = 0;

// 드로워 리스트
let drawerNicknameList = [];
let drawerIdList = [];
let getPixelList = [0, 0, 0, 0];

// 피드 저장용 전역변수
let layerArry = [];
let ctxArry = [];
let imageBase64Arry = [];

// 픽셀선물 인덱싱
let pixelIndex = 0;

// ********** 소켓 수신부 함수셋 ******************//
const socketFunctionSet = (function () {
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

            // 전체 유저리스트 생성
            if (admin_id == user_id) { // 어드민이 입장한 경우
                for (const user of userList) {
                    if (user['user_type'] == 'VISITOR') { // 유저리스트의 유저가 방문자인 경우
                        $('#canvus-list').append(
                            `<li>
                                <a href="#">
                                    ${user['nickname']}
                                    <button type="button" class="btn btn-success addAuthority" id="list${user['user_id']}">
                                        一緒に
                                    </button>
                                </a>
                            </li>`);
                    } else { // 유저 리스트의 유저가 drawer인 경우
                        drawerNicknameList.push(user['nickname']);
                        drawerIdList.push(user['user_id']);
                        $('#canvus-list').append(`<li><a href="#">${user['nickname']}</a></li>`);
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

                    $('#canvus-list').append(`<li><a href="#">${user['nickname']}</a></li>`);
                }
            }

            // 드로워 리스트 생성
            const numOfDrawers = drawerIdList.length;
            for (let i = 0; i < numOfDrawers; i++) {
                const content = `
                    <button class="btn btn-primary" type="button" id="drawerTop-${drawerIdList[i]}">
                        ${drawerNicknameList[i]}
                    </button>`;
                $('#drawerList').append(content);
            }
        },
        quit: function (data) {
            messageController.chatReply(data);
            const userList = data['userListInRoom'];

            $('#canvus-list').empty();
            $('#drawerList').empty();
            authCount = 0;
            drawerNicknameList = [];
            drawerIdList = [];

            // 전체 유저리스트 생성
            if (admin_id == user_id) { // 어드민이 입장한 경우
                for (const user of userList) {
                    if (user['user_type'] == 'VISITOR') { // 유저리스트의 유저가 방문자인 경우
                        $('#canvus-list').append(
                            `<li>
                                <a href="#">
                                    ${user['nickname']}
                                    <button type="button" class="btn btn-success addAuthority" id="list${user['user_id']}">
                                        一緒に
                                    </button>
                                </a>
                            </li>`);
                    } else { // 유저 리스트의 유저가 drawer인 경우
                        drawerNicknameList.push(user['nickname']);
                        drawerIdList.push(user['user_id']);
                        $('#canvus-list').append(`<li><a href="#">${user['nickname']}</a></li>`);
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

                    $('#canvus-list').append(`<li><a href="#">${user['nickname']}</a></li>`);
                }
            }

            // 드로워 리스트 생성
            const numOfDrawers = drawerIdList.length;
            for (let i = 0; i < numOfDrawers; i++) {
                const content = `
                    <button class="btn btn-primary" type="button" id="drawerTop-${drawerIdList[i]}">
                        ${drawerNicknameList[i]}
                    </button>`;
                $('#drawerList').append(content);
            }
        },
        presentPixel: function (data) {
            const message = data['message'];
            const senderNick = message['senderNickname'];
            const receiverNick = message['receiverNickname'];
            const sender = message['sender'];
            const receiver = message['receiver'];
            const pixel = message['pixel'];
            const text = message['message'];
            const pixelIndex = message['pixelIndex'];

            const content = `
                <div id= "noti-${sender}-${pixelIndex}" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header">
                        <strong class="mr-auto">${senderNick} -> ${receiverNick}</strong>
                        <small class="text-muted">  ${pixel} ピックセル!!</small>
                        <button type="button" 
                                class="ml-2 mb-1 close" 
                                data-dismiss="toast" 
                                aria-label="Close"
                                onclick="paymentFunctionSet.deleteNoti('noti-${sender}-${pixelIndex}');">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="toast-body">
                        ${text}
                    </div>
                </div>
            `;
            $('#toasts-container').append(content);
        },
        createPageLayer: function (data) {
            const message = data['message'];
            const sender = message['user_id'];

            if (sender != user_id) {
                const page_no = message['page_no'];
                const layer_no = message['layer_no'];
                const layerId = `p${page_no}l${layer_no}`;

                if (layer_no == 1) {
                    // 페이지 생성 + 1번 레이어 생성
                    drawingFunctionSet.createPageComponent('receiver');
                } else {
                    // 레이어 생성 (초기화용 함수였지만 원하는 기능이 같아서 이용)
                    drawingFunctionSet.initializeCreateLayer(page_no);
                }

                drawingFunctionSet.changeLayerTarget(layerId);
            }
        },
        deletePageLayer: function (data) {
            const message = data['message'];
            const sender = message['user_id'];

            const layerId = `p${message['page_no']}l${message['layer_no']}`;
            $(`#${layerId}-box`).remove();

            if (sender != user_id) {
                drawingFunctionSet.deleteLayer(layerId, 'receiver');
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

            // 실제 javascript 배열상에도 추가
            drawerIdList.push(targetId);
            drawerNicknameList.push(targetNickname);
        },
        closeRoom: function () {
            socketSenderFunctionSet.disconnect(room_Id, user_id);
            if (confirm("Adminがフィードを作成してルームが閉まりました。")) {
                location.href = "/";
            } else {
                location.href = "/";
            }
        }
    }
})();

// ************ 소켓 발신부 함수셋 ****************//
const socketSenderFunctionSet = (function () {
    return {
        connect: function () {
            const socket = new SockJS('/endpoint');
            socketClient = Stomp.over(socket);

            socketClient.connect({}, function (frame) {
                // 챗 메세지를 실시간으로 받아들이는 파트
                socketClient.subscribe(`/subscribe/drawing/room/${room_Id}`, function (result) {
                    const data = JSON.parse(result.body);
                    console.log(data);
                    socketSenderFunctionSet.parser(data);
                });
            });
        },
        sendMessage: function (message, type) {
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
                    socketSenderFunctionSet.socketEntranceRepeater();
                }
            }
        },
        disconnect: function () {
            const message = {
                userId: user_id,
                message: mynickname + 'さんが退室しました。'
            };

            socketSenderFunctionSet.sendMessage(message, 'quit');
            location.href = "/";
            socketClient.disconnect();
        },
        socketEntranceRepeater: function () {
            try {
                const enterData = {
                    user_id: "BOT",
                    nickname: mynickname,
                    message: mynickname + "さんが入室しました。"
                };
                setTimeout(socketSenderFunctionSet.sendMessage, 500, enterData, 'enter');
            } catch (e) {
                console.log("소켓 생성전");
                socketSenderFunctionSet.socketEntranceRepeater();
            }
        },
        parser: function (data) {
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
            } else if (type == "CLOSEROOM") {
                socketFunctionSet.closeRoom();
            }
        },
    }
})();

// ********** fabric 관련 함수셋 ********** //
const drawingFunctionSet = (function () {
    return {
        changeBrush: function () {
            try {
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

                currlayer.freeDrawingBrush.color = hexGlobal;
                currlayer.freeDrawingBrush.width = thicknessGlobal;
            } catch (e) {
                console.log("currentLayer가 타게팅 되지 않음");
            }
        },
        createLayer: function (isReceiver) {
            try {
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
                    socketSenderFunctionSet.sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
                });
                eventSet[pageNum - 1].push(eventObj);
                console.log(eventSet);

                //TODO 부가적으로 생성된 canvas-container를 지우는 프로세스
                $('.canvas-container').attr('id', 'removeResidue');
                if (user_id != admin_id) {
                    $('.upper-canvas').attr('class', layerId + 'u');
                    $(`.${layerId}u`).css({'display': 'none'}).addClass('drawReceiver');
                } else {
                    $('.upper-canvas').attr('class', layerId + 'u');
                    $(`.${layerId}u`).addClass('drawReceiver');
                }
                // 드로워에 해당하는 경우 display 숨김 속성을 지운다.
                if (drawerIdList.length != 0) {
                    for (const drawer_id of drawerIdList) {
                        if (drawer_id == user_id)
                            $(`.${layerId}u`).css({'display': ""});
                    }
                }

                $('#' + layerId).appendTo('#p' + pageNum);
                $('.' + layerId + 'u').appendTo('#p' + pageNum);
                $('#removeResidue').remove();

                // TODO z-index CSS 속성을 부여하고 Z-INDEX 배열에 추가하는 프로세스
                $('#' + layerId).css({'z-index': totalNumOfLayer + 1});
                $('.' + layerId + 'u').css({'z-index': totalNumOfLayer + 1});
                zNumSet[pageNum - 1].push(totalNumOfLayer + 1);
                console.log(zNumSet);

                // TODO 레이어 리스트에 추가하는 메소드
                drawingFunctionSet.createlayerList(layerId);

                ///////////////////////////////////////////////////////////////

                // 소켓에 레이어를 생성했다는 정보를 쏴주는 구문 (이니셜라이즈 문제가 있어 isInitialized 도입)
                if (isInitialized) {
                    if (isReceiver == undefined) { // 생성한 사람인 경우 소켓으로 전송 및 브러시 체인지
                        const message = {
                            user_id: user_id,
                            page_no: pageNum,
                            layer_no: totalNumOfLayer + 1
                        };

                        socketSenderFunctionSet.sendMessage(message, 'CREATEPAGELAYER');
                        drawingFunctionSet.changeLayerTarget(layerId);
                    }
                }
            } catch (e) {
                alert("現在ページが選択されていません。まず、ページを選んでください。");
            }
        },
        initializeCreateLayer: function (pageNo) {
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
                socketSenderFunctionSet.sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
            });
            eventSet[pageNo - 1].push(eventObj);
            console.log(eventSet);

            //TODO 부가적으로 생성된 canvas-container를 지우는 프로세스
            $('.canvas-container').attr('id', 'removeResidue');
            if (user_id != admin_id) {
                $('.upper-canvas').attr('class', layerId + 'u');
                $(`.${layerId}u`).css({'display': 'none'}).addClass('drawReceiver');
            } else {
                $('.upper-canvas').attr('class', layerId + 'u');
                $(`.${layerId}u`).addClass('drawReceiver');
            }
            // 드로워에 해당하는 경우 display 숨김 속성을 지운다.
            if (drawerIdList.length != 0) {
                for (const drawer_id of drawerIdList) {
                    if (drawer_id == user_id)
                        $(`.${layerId}u`).css({'display': ""});
                }
            }

            $('#' + layerId).appendTo('#p' + pageNo);
            $('.' + layerId + 'u').appendTo('#p' + pageNo);
            $('#removeResidue').remove();

            // TODO z-index CSS 속성을 부여하고 Z-INDEX 배열에 추가하는 프로세스
            $('#' + layerId).css({'z-index': totalNumOfLayer + 1});
            $('.' + layerId + 'u').css({'z-index': totalNumOfLayer + 1});
            zNumSet[pageNo - 1].push(totalNumOfLayer + 1);
            console.log(zNumSet);
        },
        createPage: function (isReceiver) {
            const totalNumOfPage = layerSet.length;
            const pageId = 'p' + (totalNumOfPage + 1); // 예: length가 1이면 2번 페이지를 만들어야한다

            // 이 부분에 canvas 태그 생성구문을 넣을 것. 아이디는 p만든레이어번호l1로 준다.
            // 첫 레이어는 자동생성을 하는 편이 좋을 듯 싶다.
            let contents = `<canvas id="${pageId}l1" width="600px" height="600px"></canvas>`;
            $(`#T${pageId}`).append(contents);

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
            $('.canvas-container').attr('id', pageId).attr('class', 'pageBundle');
            $('.upper-canvas').attr('class', pageId + 'l1u');
            if (user_id != admin_id) {
                $('.upper-canvas').attr('class', pageId + 'l1u');
                $(`.${pageId}l1u`).css({'display': 'none'}).addClass('drawReceiver');
            } else {
                $('.upper-canvas').attr('class', pageId + 'l1u');
                $(`.${pageId}l1u`).addClass('drawReceiver');
            }
            // 드로워에 해당하는 경우 display 숨김 속성을 지운다.
            if (drawerIdList.length != 0) {
                for (const drawer_id of drawerIdList) {
                    if (drawer_id == user_id)
                        $(`.${pageId}l1u`).css({'display': ""});
                }
            }

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
                socketSenderFunctionSet.sendMessage(message, "drawing"); // 예: 2번 페이지는 1번 인덱스이다.
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
                    socketSenderFunctionSet.sendMessage(message, 'CREATEPAGELAYER');
                }
            }
        },
        deleteLayer: function (layerId, isReceiver) {
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
                socketSenderFunctionSet.sendMessage(message, 'DELETEPAGELAYER');
            }
        },
        createPageComponent: function (isReceiver) {
            const totalPage = layerSet.length;

            let content = `
                <div role="tabpanel" class="tab-pane figure figure_bg figure_bg_light center-block fade" id="Tp${totalPage + 1}"></div>
                `;
            $('#tabPanes').append(content);

            drawingFunctionSet.createPage(isReceiver);

            content = `
                <li role="presentation">
                    <a href="#p${totalPage + 1}" aria-controls="p${totalPage + 1}" role="tab" data-toggle="tab" id="pli${totalPage + 1}">Page${totalPage + 1}</a>
                </li>
                `;
            $('#tablist').append(content);
        },
        pageSwitching: function (tabId) {
            $('.tab-pane').removeClass('active').addClass('fade');
            tabId = tabId.split('pli')[1];
            $('#Tp' + tabId).addClass('active').removeClass('fade');

            // 레이어 리스트 컨테이너를 초기화한다.
            $('#list-container').empty();

            bPageNum = pageNum; // 그전에 이전 레이어 번호로 넘긴다.
            pageNum = parseInt(tabId);

            const layerList = layerSet[pageNum - 1];

            // drawer인지 확인
            let isDrawer = false;
            for (const drawerId of drawerIdList) {
                if(drawerId == user_id) {
                    isDrawer = true;
                    break;
                }
            }
            
            for (let i = 0; i < layerList.length; i++) {
                if (layerList[i] != null) {
                    drawingFunctionSet.createlayerList(`p${pageNum}l${i + 1}`);
                    $(`#p${pageNum}l${i+1}`).css({'opacity': '1'});
                    if(isDrawer) {
                        $(`.p${pageNum}l${i+1}u`).css({'display':"block"});
                    } else {
                        $(`.p${pageNum}l${i+1}u`).css({'display':"none"});
                    }
                }
            }

            //레이어 타게팅을 마지막 레이어로 변경
            drawingFunctionSet.changeLayerTarget(`p${pageNum}l${layerList.length}`);
            //브러시 체인지
            drawingFunctionSet.changeBrush();
        },
        initializer: function () {
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
                    drawingFunctionSet.createPageComponent('receiver');

                    if (page_no != 1) {
                        i++;
                    }
                } else {
                    drawingFunctionSet.initializeCreateLayer(page_no);
                }
                // 리렌더링
                const targetObj = layerSet[page_no - 1][layer_no - 1];
                targetObj.loadFromJSON(obj, targetObj.renderAll.bind(targetObj));
            } // FOR END

            isInitialized = true;
        },
        createlayerList: function (layerId) {
            const content = `
                <li class="list-group-item" id="${layerId}-box">
                    <div class="checkbox">
                        <label for="checkbox" id="${layerId}-label">
                            layer ${layerId.split('l')[1]}
                        </label>
                        <div class="pull-right action-buttons">
                            <a href="#" class="trash"><span class="glyphicon glyphicon-trash" id="${layerId}-del"></span></a>
                            <a href="#" class="flag"><span class="glyphicon glyphicon-eye-open" id="${layerId}-visible"></span></a>
                        </div>
                    </div>
                </li>
            `;

            $('#list-container').append(content);
        },
        changeLayerTarget: function (layerId) {
            let temp = layerId.split('l');

            const layer = parseInt(temp[1]);
            const page = parseInt(temp[0].split('p')[1]);

            currlayer = layerSet[page - 1][layer - 1];
            // TODO z-index Reset
            for (let i=0; i<layerSet[page-1].length; i++) {
                $(`.p${page}l${i+1}u`).css({'z-index':i+1});
                $(`#p${page}l${i+1}-box`).css({'background-color':'white'});
            }
            // TODO Targetting
            $(`.${layerId}u`).css({'z-index': 9999});
            $(`#${layerId}-box`).css({'background-color':'rgb(33 138 241 / 46%)'});

            drawingFunctionSet.changeBrush();
        },
        changeVisibility: function (layerId) {
            const $upperlayer = $(`.${layerId}u`);
            const $layer = $(`#${layerId}`);
            let opacity = $layer.css('opacity');
            let visibility = '';

            // 비저블리티 토글링
            if (opacity == '0') {
                opacity = '1';
                $(`#${layerId}-visible`).removeClass('glyphicon-eye-close');
                $(`#${layerId}-visible`).addClass('glyphicon-eye-open');
                $layer.css({'opacity': opacity});
            } else {
                opacity = '0';
                $(`#${layerId}-visible`).removeClass('glyphicon-eye-open');
                $(`#${layerId}-visible`).addClass('glyphicon-eye-close');
                $layer.css({'opacity': opacity});
            }

            visibility = (opacity == '0') ? 'none' : 'block';

            if (drawerNicknameList.length == 0) {
                console.log("드로워가 없는 경우");
                $upperlayer.css({'display': "none"});
            } else {
                $upperlayer.css({'display': "none"});
                for (const drawerIdListElement of drawerIdList) { // 드로워인 경우
                    if (drawerIdListElement == user_id) { // 드로워나 admin인 경우
                        $upperlayer.css({'display': visibility});
                        break;
                    }
                }
            }
        },
    }
})();

// ************ 피드 생성 관련 함수셋 ************* //
const createFeedController = (function () {
    return {
        createFeed: function () {
            if (user_id == admin_id) { // 어드민에게만 허용하기 위해 추가한 조건문
                const pageNo = layerSet.length;
                if (pageNo == 0) {
                    alert('何も描きませんでした。ページを作って絵を描いてください。');
                    return;
                }

                // 레이어 오버레이 버퍼div style="display:none"
                const content = `<div id="buffer" style="display: none;"></div>`;
                $('body').append(content);

                // TODO 오버레이 레이어버퍼 생성
                for (let i = 0; i < pageNo; i++) {
                    const content = `
                        <canvas class="buffer" id="buffer_${i}" width="600px" height="600px"></canvas>
                    `;
                    $('#buffer').append(content);

                    let oneLayer = document.getElementById(`buffer_${i}`);
                    layerArry.push(oneLayer);
                    ctxArry.push(oneLayer.getContext('2d'));
                }

                // TODO 오버레이 진행
                for (let i = 0; i < pageNo; i++) {
                    for (let j = 0; j < layerSet[i].length; j++) {
                        if (layerSet[i][j] != null) {
                            ctxArry[i].drawImage(document.getElementById(`p${i + 1}l${j + 1}`), 0, 0);
                        }
                    }

                    // base 64 추출
                    imageBase64Arry.push(layerArry[i].toDataURL("image/png"));
                }

                //TODO 피드 작성 모달 토글링
                $('#make-feed-modal').modal('toggle');
                
            } else { // Admin이 아닌경우
                alert("すみませんが、アドミンだけの機能です。");
            }
        },
        makeFeedExecution: function () {
            // 어드민 아이디를 없애버리는 프로세스
            for (let i = 0; i < drawerIdList.length; i++) {
                if (drawerIdList[i] == admin_id) {
                    drawerIdList.splice(i, 1);
                    break;
                }
            }

            const data = {
                feed_id: room_Id,
                admin: admin_id,
                drawers: drawerIdList,
                context: $('#pre-context').val(),
                pages: imageBase64Arry
            };

            $.ajax({
                url: '/drawing/makeFeed',
                type: 'post',
                async: false,
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function () {
                    console.log("전송성공");
                    $('#content_div').remove();
                    $('#mask').remove();

                    const message = {
                        room_Id: room_Id,
                        message: 'Adminがフィードを作成してルームが閉まりました。'
                    }
                    socketSenderFunctionSet.sendMessage(message, "closeRoom");
                },
                error: function () {
                    console.log("전송실패");
                }
            });
        },
    } // 함수집합 엔드
})();

// ************ 썸네일 생성 관련 함수셋 ************ //
const thumbnailFunctionSet = (function () {
    return {
        sendOnePageIntegrationFunction: function () {
            const isValid = thumbnailFunctionSet.checkOnePageValidation();

            if (isValid) {
                thumbnailFunctionSet.onePageSaveEventFire();
            }
        },
        onePageSaveEventFire: function () {
            const onePageBuffer = $('#onePageBuffer');
            const onePageObjArry = layerSet[0];
            const content = `
               <canvas class="buffer" id="buffer_one" width="600px" height="600px"></canvas>
           `;

            onePageBuffer.append(content);
            const bufferOne = document.getElementById('buffer_one');
            const ctx = bufferOne.getContext('2d');

            for (let i = 0; i < onePageObjArry.length; i++) {
                ctx.drawImage(document.getElementById(`p1l${i + 1}`), 0, 0);
            }

            const base64 = bufferOne.toDataURL("image/png");
            const data = {
                encodedStr: base64,
                room_Id: room_Id
            };

            $.ajax({
                url: '/drawing/thumbnail',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function () {
                    console.log("Success");
                },
                error: function () {
                    console.log("Fail");
                }
            });

            onePageBuffer.empty();
        },
        checkOnePageValidation: function () {
            let check = false;

            if (layerSet.length != 0) { // 하나도 생성 안한경우 false
                if (layerSet[0].length != 0) { // 생성은 했으나 레이어 길이가 0인경우(사실 없음)
                    check = true;
                }
            }

            return check;
        },
    }
});

// ************* 결제 관련 함수셋 ***************** //
const paymentFunctionSet = (function () {
    return {
        // 지불절차를 수행하는 메소드
        entrancePayment: function (selectedPixelVal, myPixel) {
            // 결제에 필요한 변수셋
            const IMP = window.IMP;
            IMP.init("imp01277842"); // 가맹점 식별코드
            const pg = 'html5_inicis'; //결제 pg사 선택
            const pay_method = 'card'; // 결제종류
            let merchant_uid = '';
            const productName = `Pixel: ${selectedPixelVal}`; // 상품명
            const amount = `${selectedPixelVal}`; // 가격(원)

            // merchant_uid 파싱
            $.ajax({
                url: '/payment/parseMerchantUid',
                type: "POST",
                dataType: "json",
                async: false, // 이항목을 넣지 않으면 비동기식으로 코드 절차를 따라가지 않는다.
                contentType: "application/json",
                data: JSON.stringify({
                    pixel: selectedPixelVal,
                }),
                success: function (result) {
                    merchant_uid = result['merchant_uid'];
                    console.log(merchant_uid);
                },
                error: function () {
                    console.log("merhcant uid 파싱에러");
                }
            });

            //거래 시작
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: pay_method,
                merchant_uid: merchant_uid,
                name: productName,
                buyer_email: email,
                buyer_name: family_name + given_name,
                amount: amount,
            }, function (rsp) {
                if (rsp.success) {
                    const pixel = productName.split(': ')[1];
                    console.log(pixel);

                    const paymentData = {
                        'imp_uid': rsp.imp_uid, // 고유 ID
                        'merchant_uid': rsp.merchant_uid, // 상점거래 ID
                        'paid_amount': rsp.paid_amount, // 결제 금액
                        'apply_num': rsp.apply_num, // 카드 승인번호
                        'user_id': user_id, // 거래한 유저 아이디
                        'pixel': selectedPixelVal, // 구입한 pixel 양
                        'inputdate': rsp.paid_at // 구매시각
                    };

                    $.ajax({ // 결제 내역 전송
                        url: '/payment/paymentSubmit',
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(paymentData),
                        success: function (result) {
                            console.log(result['result']);
                            $('#my-pixel').val(myPixel + selectedPixelVal);
                        }, error: function () {
                            console.log("통신실패 관리자에게 문의");
                        }
                    });

                    var msg = '결제가 완료되었습니다.';
                } else {
                    var msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                }

                alert(msg);
            });
        }, // entrancePayment end
        // 픽셀을 선물하는 메소드
        deleteNoti: function (id) {
            $(`#${id}`).remove();
        },
    }
})();

// ************ 레인지바 객체 ********************* //
const sliderObj = {
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

// 다른 페이지로 이동시 소켓 접속 종료 및 방에서 나가게 하는 에빈트
document.onkeydown = function (event) {
    if (event.keyCode === 116 || event.ctrlKey == true && (event.keyCode === 82)) {
        socketSenderFunctionSet.disconnect(room_Id, user_id);
        event.cancelBubble = true;
        event.returnValue = false;

        setTimeout(function () {
            window.location.reload();
        }, 100);

        return false;
    }
}

socketSenderFunctionSet.connect(); // 소켓 커넥트 실시

// ********** 소켓 전송과 관련된 이벤트 ********** //
// 페이지 종료 이벤트 --> 소켓종료
$(window).on('beforeunload', function () {
    socketSenderFunctionSet.disconnect(room_Id, user_id);
});

/*********************** ready 파트 및 이벤트 등록파트 *******************/
$(() => {
    // ********** 레이어 이니셜라이저 실행  ***************//
    drawingFunctionSet.initializer();

    // 방입장 메세지 전송파트 (소켓 연결은 비동기 이기 때문에 언제 연결될지 모른다)
    socketSenderFunctionSet.socketEntranceRepeater();

    //***************** 이벤트 등록 리스트 ************************//
    const dynamicEvents = [
        // 레이어 생성
        $('#create-layer-btn').on('click', function () {
            drawingFunctionSet.createLayer();
        }),
        // Layer Explorer를 클릭시 현재 페이지번호, 레이어번호를 업데이트하고 현재 바라보는 레이어를 설정.
        $(document).on('click', '#list-container', function () {
            try {
                let eventId = event.target.id;
                const layerId = eventId.split('-')[0];
                const action = eventId.split('-')[1];

                if (action == 'box' || action == 'label') {
                    drawingFunctionSet.changeLayerTarget(layerId);
                } else if (action == 'del') {
                    drawingFunctionSet.deleteLayer(layerId); // 소켓으로 보내는 쪽이라 isReceiver가 undefined
                } else if (action == 'visible') {
                    drawingFunctionSet.changeVisibility(layerId);
                } else {
                    console.log('아무것도 안함');
                }
            } catch (e) {
                console.log('페이지 번호가 지정되지 않은 상황');
            }
        }),
        // 페이지텝 이벤트
        $(document).on('click', '#tablist a', function (e) {
            e.preventDefault();
            let tabId = e.target.id;

            if (tabId == 'CreatePage') { // 페이지 생성의 경우
                let isDrawer = false;
                for (const drawerId of drawerIdList) {
                    if (drawerId == user_id){
                        isDrawer = true;
                        break;
                    }
                }

                if (isDrawer) {
                    drawingFunctionSet.createPageComponent();
                    const maxPage = layerSet.length;
                    $('#tablist').children().removeClass('active');
                    $('#tablist').children().last().addClass('active');
                    drawingFunctionSet.pageSwitching('pli' + maxPage);
                } else {
                    alert("許可されたDrawer専用の機能です。");
                }
            } else { // 페이지 열람의 경우
                drawingFunctionSet.pageSwitching(tabId);
            }
        }),
        // 레인지바 이벤트
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

            drawingFunctionSet.changeBrush();
        }),
        // 색상 변경 이벤트
        $('#drawing-color').on('change', function () {
            hexGlobal = $('#drawing-color').val() + Math.floor(opacityGlobal * 255).toString(16);

            drawingFunctionSet.changeBrush();
        }),
        // 드로잉 권한부여 이벤트
        $(document).on('click', '.addAuthority', function (event) {
            if (authCount < 4) {
                let targetId = event.target.id;
                let targetNickname = $('#' + targetId).parent().text();
                targetNickname = targetNickname.split('一緒に')[0];
                targetId = targetId.split('list')[1];

                const message = {
                    user_id: user_id,
                    targetId: targetId,
                    targetNickname: targetNickname
                };

                $(`#${event.target.id}`).remove();

                socketSenderFunctionSet.sendMessage(message, 'ADDAUTHORITY');

                authCount++;
            } else {
                alert('권한은 최대 4명만 부여 가능합니다.');
            }
        }),
        // 브러시 변경텝 클릭 이벤트
        $('#brushTap').on('click', function (event) {
            console.log("브러시 선택 버튼 클릭으로 인한 브러시 변경 이벤트 발생");

            let brushType = event.target.id;

            if (brushType != 'selector') {
                brushGlobal = brushType;
                drawingFunctionSet.changeBrush();
            } else {
                try {
                    const modeChecker = layerSet[0][0].isDrawingMode;

                    for (let i = 0; i < layerSet.length; i++) {
                        for (let j = 0; j < layerSet[i].length; j++) {
                            layerSet[i][j].isDrawingMode = !modeChecker;
                        }
                    }
                } catch (e) {
                    alert("ページが一つもありません。");
                }
            }
            // dropdown이 클릭하더라도 닫히지 않도록 이벤트 버블링 차단(range bar 편의성을 위해)
            event.stopPropagation();
        }),
        // 에딧탭 클릭 이벤트
        $(document).on('click', '#Edit', function (event) {
            const eventId = $(event.target).parent().attr('id');

            if (eventId == 'Edit-feed') {
                createFeedController.createFeed();
            } else if (eventId == 'Edit-exit') {
                socketSenderFunctionSet.disconnect(room_Id, user_id);
            }
        }),
        // 피드작성 취소 이벤트
        $(document).on("click", "#mask", function () {
            console.log("마스크 클릭 감지 및 처리");
            $('#mask').remove();
            $('#content_div').remove();
        }),
        // 픽셀 선물 모달창 띄우기 이벤트
        $(document).on('click', '#drawerList', function (event) {
            let targetId = event.target.id;
            targetId = targetId.split('drawerTop-')[1];
            let drawer_nickname = '';

            // TODO 선물하려는 대상의 아이디 추출
            for (let i = 0; i < drawerIdList.length; i++) {
                if (targetId == drawerIdList[i]) {
                    drawer_nickname = drawerNicknameList[i];
                    break;
                }
            }

            // TODO 동적으로 모달 내 텍스트 값을 변경
            $('#target-drawer-id').val(targetId);
            $('#target-drawer-nickname').val(drawer_nickname);
            $('.modal-title').text(`${drawer_nickname}さんにプレゼントしましょう。`);

            // TODO 현재 자신이 보유중인 픽셀의 수를 산출하는 메소드
            $.ajax({
                url: '/user/getPixelAmount',
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (result) {
                    const pixel = result['pixel'];
                    $('#my-pixel').val(pixel);
                },
                error: function () {
                    console.log("통신오류");
                }
            });

            $('#present-pixel-modal').modal('toggle');
        }),
        // 픽셀 선물 목록 클릭시 이벤트
        $('input[name=pixel-amount-list]').click(function () {
            const selectedVal = parseInt(this.value);
            const myPixel = parseInt($('#my-pixel').val());

            if (selectedVal > myPixel) {
                if (confirm('持っている数より多いです。ピックセルを課金しませんか。')) {
                    console.log("결제파트 진입");
                    $('#present-pixel-modal').modal('toggle');
                    $('#pixel-product-modal').modal('toggle');
                } else {
                    alert('数を少なくしてください。');
                }
            }
        }),
        // 픽셀 선물하기 수행버튼 클릭시 이벤트
        $('#execute-present').on('click', function(){
            const selectedPixel = parseInt($('input[name=pixel-amount-list]:checked').val());
            const myPixel = parseInt($('#my-pixel').val());
            const targetId = $('#target-drawer-id').val();
            const targetNick = $('#target-drawer-nickname').val();

            pixelIndex++;
            const data = {
                sender: user_id,
                senderNickname: mynickname,
                receiver: targetId,
                receiverNickname: targetNick,
                pixel: selectedPixel,
                message: $('#present-message').val(),
                pixelIndex: pixelIndex
            };

            if (selectedPixel > myPixel) {
                alert("持っているピックセルより多いので、プレゼントが出来ませんでした。");
            } else {
                $.ajax({
                    url:'/payment/presentPixel',
                    type:'post',
                    dataType:'json',
                    data: JSON.stringify(data),
                    contentType: 'application/json',
                    success: function(result) {
                        const isSuccess = result['result'];

                        if (isSuccess) {
                            alert("プレゼントしました！");
                            $('#present-pixel-modal').modal('hide');
                            socketSenderFunctionSet.sendMessage(data, 'PRESENTPIXEL');
                        } else {
                            pixelIndex--;
                            alert("サーバーの問題で、プレゼントが出来ませんでした。");
                        }
                    },
                    error: function() {
                        pixelIndex--;
                        console.log("통신실패");
                    }
                });
            }
        }),
        // 픽셀 결제 수량 체크 후 결정시 이벤트
        $('#execute-payment').on('click', function() {
            const selectedPixelVal = parseInt($('input[name=pixel-product-list]:checked').val());
            const myPixel = parseInt($('#my-pixel').val());

            paymentFunctionSet.entrancePayment(selectedPixelVal, myPixel);
        }),
    ];
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
});