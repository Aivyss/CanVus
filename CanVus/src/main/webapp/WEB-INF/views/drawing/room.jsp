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
    <!-- 서버로부터 받아온 변수를 저장하는 자바스크립트 -->
    <script type="text/javascript">
		const room_Id = "${room_Id}";
		const user_id = "${sessionScope.userId}";
		const mynickname = "${sessionScope.userVO.nickname}";
    </script>
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
        <script src="/resources/js/drawing/drawingFunctionSet.js"></script>
        <!-- 본격적인 드로잉 페이지 시작 -->
        <!-- 툴 텝 시작 -->
        <link rel="stylesheet" href="/resources/css/drawing/pageTab.css">
        <div id="container">
            <ul class="tab">
                <li class="current" data-tab="create" id="createPage"><a href="#">New Page</a></li>
            </ul>
            <!-- 생성을 위한 툴탭 -->
            <div id="base">
                <div id="create" class="tabcontent current" style="display: none"></div>
            </div>
        </div>

        <!-- ▼소켓부분이니 !!!되도록!!!건드리지 말것▼ -->
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <div class="container">
            <canvas id="p1l1" style="width : 100px; height : 200px; border: 1px solid black;"></canvas>
            <canvas id="p1l2" style="width : 100px; height : 200px; border: 1px solid black;"></canvas>
            <input type="button" id="btn" value="객체 전송테스트">
            <input type="button" id="btn2" value="메세지 전송테스트">
            <input type="button" id="btn3" value="currlayer 바꾸고 이벤트 테스트">
        </div>
        <!-- ▲소켓부분이니 !!!되도록!!!건드리지 말것▲ -->


    </c:otherwise>
</c:choose>
</body>
</html>