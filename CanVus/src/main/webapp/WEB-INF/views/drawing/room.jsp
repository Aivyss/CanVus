<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
    <link rel="stylesheet" href="/resources/js/style.css">
    <script src="/resources/js/Classic/Color.Picker.Classic.js" type="text/javascript"></script>
    <script src="/resources/js/Classic/Color.Space.js" type="text/javascript"></script>
    <script src="/resources/js/Classic/viewpalette.js"></script>
    <script src="/resources/js/fabric/dist/fabric.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
            integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script type="text/javascript" src="/resources/js/drawing/layerTestJaewonSeokhyeon.js"></script>
    <link rel="stylesheet" href="/resources/css/drawing/style.css">
    <!-- 전역변수 및 서버로부터 받아온 변수를 저장하는 자바스크립트 -->
    <script type="text/javascript">
		const room_Id = "${room_Id}";
		const user_id = "${sessionScope.userId}";
		const mynickname = "${sessionScope.userVO.nickname}";

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
    </script>
    <script src="/resources/js/drawing/drawingFunctionSet.js"></script>

</head>

<body data-spy="scroll" data-target="#header">
<!--Start Hedaer Section-->
<jsp:include page="/WEB-INF/views/mainMenu.jsp"></jsp:include>
<c:choose>
    <c:when test="${empty pwWrttenByUser && dbPassword != null}">
        <script type="text/javascript" src="/resources/js/drawing/passwordCheck.js"></script>

        <div class="row g-3 align-items-center" id="passwordsetting">
            <label for="inputPassword5" class="form-label">Password</label>
            <input type="password" id="inputPassword5" name="password" class="form-control"
                   aria-describedby="passwordHelpBlock">
            <div>
                <input type="button" value="입력" id="pwCheck">
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <!-- 본격적인 드로잉 페이지 시작 -->
        <!-- 툴 텝 시작 -->
        <div class="toolBar" id="test">
            <div>Drawing Page</div>
            <span>CanVus</span>
            <a>올리기</a>
            <a>저장</a>
            <a>뒤로</a>
            <a>앞으로</a>
            <div class="tool">
                <div>
                    <button class="brush">브러쉬</button>
                </div>
                <div>
                    <button id="selection">selection</button>
                </div>
                <div>
                    <button id="moveLayer">moveLayer</button>
                </div>
                <div class="layers1">
                    <button style="float:left; border:solid #ff0000 2px; color:red;" class="layers1">layer1</button>
                </div>
                <div class="hidelayers1">
                    <button style="float:left; border:solid black 2px; color:black;" class="hidelayers1">hidelayer1
                    </button>
                </div>
                <div class="deletelayers1">
                    <button class="deletelayers1">deletelayer1</button>
                </div>

            </div>

            <div class="tool_brush">
                <div>
                    <input type="button" value="스프레이" onclick="sprayBrush();">
                </div>
                <div>
                    <input type="button" value="써클" onclick="circleBrush();">
                </div>
                <div>
                    <input type="button" value="패턴" onclick="patternBrush();">
                </div>
                <div>
                    <input type="button" value="연필" onclick="pencilBrush();">
                </div>
            </div>

            <div class="rangeBar">
                <input type="range" max="1" min="0.1" step="0.05" value="1" id="opacity" class="range">
            </div>
            <div class="rangeBar">
                <input type="range" max="30" min="1" step="1" value="5" id="thickness" class="range">
            </div>

        </div>
        <!-- 툴 텝 끝 -->

        <!-- page 텝 시작-->
        <div class="container" id="container">
            <ul class="tabs">
                <li class="tab-link current" data-tab="tab-1">page1</li>
                <li class="tab-link" data-tab="tab-2">page2</li>
                <li class="tab-link" data-tab="tab-3">page3</li>
            </ul>

            <div id="tab-1" class="tab-content current">
                <div class="set">
                    <div class="layers">
                        <input type="button" id="makebtn" value="레이어추가"/>
                        <div class="layer1">
                            <canvas class="canvas" id="canvas" width="1000" height="600"></canvas>
                        </div>
                        <div class="layer2">
                            <canvas class="canvas" id="canvas2" width="1000" height="600"></canvas>
                        </div>
                        <div class="layer3">
                            <canvas class="canvas" id="canvas3" width="1000" height="600"></canvas>
                        </div>
                        <div class="layer4">
                            <canvas class="canvas" id="canvas4" width="1000" height="600"></canvas>
                        </div>
                        <div class="layer5">
                            <canvas class="canvas" id="canvas5" width="1000" height="600"></canvas>
                        </div>


                    </div>
                    <div class="buttons">
                        <button id="eraser">eraser</button>
                        <button id="drawer">drawer</button>
                        <button id="red">펜</button>
                        <!-- <input type="button" value="펜" onclick="baseBrush();"> -->
                        <input type="button" value="스프레이" onclick="sprayBrush();">
                        <input type="button" value="써클" onclick="circleBrush();">
                        <input type="button" value="패턴" onclick="patternBrush();">
                        <input type="button" value="연필" onclick="PencilBrush();">
                        <!-- <input type="button" value="히스토리" onclick="getHistory();"> -->
                        <button id="selection">selection</button>
                        <!-- <button id="stringify">stringify</button>
                        <button id="removal">removal</button>
                        <button id="recover">recover</button> -->
                    </div>

                </div>

            </div>

        </div>
        <div id="tab-2" class="tab-content">
        </div>
        <div id="tab-3" class="tab-content">
        </div>
        <script src="/resources/js/drawingApp.js"></script>

        <!-- ▼소켓부분이니 !!!되도록!!!건드리지 말것▼ -->
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <script type="text/javascript" src="/resources/js/drawing/roomSocket.js"></script>
        <div class="container">
            <canvas id="socketLayer" style="width : 100px; height : 200px; border: 1px solid black;"></canvas>
            <input type="button" id="btn" value="객체 전송테스트">
            <input type="button" id="btn2" value="메세지 전송테스트">
        </div>
        <!-- ▲소켓부분이니 !!!되도록!!!건드리지 말것▲ -->


    </c:otherwise>
</c:choose>
</body>
</html>