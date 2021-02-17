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
        <jsp:include page="/WEB-INF/baseJSP/toolTop.jsp"></jsp:include>
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
        <jsp:include page="/WEB-INF/baseJSP/toolTop.jsp"></jsp:include>
        <!-- 그리기 및 소켓관련 js -->

        <!-- 본격적인 드로잉 페이지 시작 -->

        <link rel="stylesheet" href="/resources/css/drawing/sideBar.css">
        <link rel="stylesheet" href="/resources/css/drawing/pageTab.css">
        <link rel="stylesheet" href="/resources/css/drawing/layerList.css">

        <div class="skeleton" style="padding-top:5px;">
            <div class="row-fluid">
                <!-- 사이드 바 시작 -->
                <div id="sidebar" class="span2">
                    <!-- 사이드바 -->
                    <!-- 레이어 리스트 -->
                    <div id="itemBoxWrap" style="overflow:auto; width:300px; height:300px;"></div>

                    <!-- 채팅박스 -->
                    <link rel="stylesheet" href="/resources/css/drawing/chat.css">
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
                    <script src="/resources/js/drawing/chat.js"></script>

                    <!-- 유저 리스트 -->
                    <link rel="stylesheet" href="/resources/css/drawing/userList.css">
                    <div style="width:200px; float:left;">
                        <section id="userListSection">
                            <input type="text" id="filter" placeholder="Type to filter"/>
                            <ul id="canvus-list" class="Canvus-List">

                            </ul>
                        </section>
                    </div>
                </div> <!-- 사이드바 앤드 -->

                <div id="content" class="span7">
                    <!-- 드로워 리스트 -->
                    <div class="btn-group btn-group-lg" role="group" aria-label="..." id="drawerList"
                         style="height:50px;">
                    </div>

                    <!-- 페이지 탭 -->
                    <div role="tabpanel">

                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist" id="tablist">
                            <li role="presentation" class="active" id="tabNav">
                                <a href="#CreatePage" aria-controls="CreatePage" role="tab" data-toggle="tab" id="CreatePage">Create Page</a>
                            </li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content" id="tabPanes">
                            <div role="tabpanel" class="tab-pane in active" id="createPageTab">...</div>
                        </div>

                    </div>

                    <div class="underContainer-Main">
                    </div>
                </div> <!-- end #content -->
            </div> <!-- end .row-fluid -->
        </div>

        <!-- 피드를 만들 당시에 사용하는 폼태그 depredcated -->

        <%--        <form action="/drawing/makeFeed" method="post" id="feedForm">--%>
        <%--            <input type="hidden" id="feed_id" name="feed_id">--%>
        <%--            <input type="hidden" id="user_id1" name="user_id1">--%>
        <%--            <input type="hidden" id="user_id2" name="user_id2">--%>
        <%--            <input type="hidden" id="user_id3" name="user_id3">--%>
        <%--            <input type="hidden" id="user_id4" name="user_id4">--%>
        <%--            <input type="hidden" id="context" name="context">--%>
        <%--            <input type="hidden" id="pages" name="pages">--%>
        <%--        </form>--%>
        <!-- end .container -->
    </c:otherwise>
</c:choose>
</body>
</html>