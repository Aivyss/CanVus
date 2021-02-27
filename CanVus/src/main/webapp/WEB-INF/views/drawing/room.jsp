<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Drawing Room</title>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <!-- fabricJS -->
    <script src="/resources/js/fabric/dist/fabric.js"></script>
    <!-- custom brushes -->
    <script src="/resources/js/customBrush/square_brush.js"></script>
    <!-- Drag function -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
            integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <!-- Websocket libraries -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <link rel="stylesheet" href="/resources/css/drawing/style.css?reload">
    <!-- 서버로부터 받아온 변수를 저장하는 자바스크립트 -->
    <script type="text/javascript">
        const room_Id = "${room_Id}";
        const user_id = "${sessionScope.userId}";
        const mynickname = "${sessionScope.userVO.nickname}";
        const admin_id = "${adminId}";
    </script>
</head>

<body data-spy="scroll" data-target="#header" style="padding-top:80px">
<!--Start Hedaer Section-->
<%--<jsp:include page="/WEB-INF/views/mainMenu.jsp"></jsp:include>--%>
<c:choose>
    <c:when test="${empty pwWrttenByUser && dbPassword != null}">
        <jsp:include page="/WEB-INF/views/baseJSP/toolTop.jsp?reload"></jsp:include>
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
        <script src="/resources/js/drawing/drawingFunctionSet.js?reload"></script>
        <jsp:include page="/WEB-INF/views/baseJSP/toolTop.jsp"></jsp:include>
        <!-- 그리기 및 소켓관련 js -->

        <!-- 본격적인 드로잉 페이지 시작 -->

        <link rel="stylesheet" href="/resources/css/drawing/Skeleton.css?after">
        <link rel="stylesheet" href="/resources/css/drawing/pageTab.css?reload">

        <div class="container-fluid">
            <!-- 사이드 바 시작 -->
            <div class="col-md-3 center-block">
                <!-- 레이어 리스트 -->
                <div class="row">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-list"></span>Layer bar
                            <div class="pull-right action-buttons">
                                <div class="btn-group pull-right">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle"
                                            data-toggle="dropdown">
                                        <span class="glyphicon glyphicon-cog" style="margin-right: 0px;"></span>
                                    </button>
                                    <ul class="dropdown-menu slidedown">
                                        <!-- 레이어 생성 버튼 -->
                                        <li><a href="#" id="create-layer-btn"><span class="glyphicon glyphicon-plus"></span>Create layer</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <ul class="list-group" id="list-container">
                                <!-- 레이어 리스트 시작부 -->
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- 채팅박스 -->
                <div class="row">
                    <link rel="stylesheet" href="/resources/css/drawing/chat.css?reload">
                    <div class='chatbox' style="float:left">
                        <div class='chatbox__header'>
                        </div>
                        <div class='chatbox__body'>
                            <div class='message receive'>
                            </div>
                        </div>
                        <div class='chatbox__input'>
                            <input placeholder='Type something here' id="chatContainer">
                            <button>
                                <svg height='24' viewbox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'>
                                    <path d='M2.01 21L23 12 2.01 3 2 10l15 2-15 2z'></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <script src="/resources/js/drawing/chat.js"></script>
            </div><!-- 사이드바 엔드 -->

            <!-- 메인창 시작 -->
            <div class="col-md-7 col-md-offset-1 main-view">
                <!-- 드로워 리스트 -->
                <div class="row">
                    <div class="btn-group btn-group-lg" role="group" aria-label="..." id="drawerList"
                         style="height:50px;">
                    </div>
                </div>

                <!-- 페이지 탭 -->
                <div class="row">
                    <div role="tabpanel">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist" id="tablist">
                            <li role="presentation" class="active" id="tabNav">
                                <a href="#CreatePage" aria-controls="CreatePage" role="tab" data-toggle="tab"
                                   id="CreatePage">Create Page</a>
                            </li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content center-block" id="tabPanes">
                            <div role="tabpanel" class="tab-pane figure figure_bg figure_bg_light center-block in active" id="createPageTab">...</div>
                        </div>
                    </div>
                </div>
                <link rel="stylesheet" href="/resources/css/drawing/chessPattern.css">

                <div id="onePageBuffer" style="display:none">
                </div>
            </div><!-- 메인창 엔드 -->
        </div>
        <!-- 사실상 body end -->
    </c:otherwise>
</c:choose>
</body>
</html>