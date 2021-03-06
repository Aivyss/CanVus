<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Drawing Room</title>
    <!-- basic JS -->
    <!-- jQuery -->
    <script src="/resources/js/jQuery/jquery-3.5.1.min.js"></script>
    <!-- BootStrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <!-- fabricJS -->
    <script src="/resources/js/fabric/dist/fabric.js"></script>
    <!-- custom brushes -->
    <script src="/resources/js/customBrush/square_brush.js"></script>
    <!-- Websocket libraries -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!-- payment api -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

    <!-- 서버로부터 받아온 변수를 저장하는 자바스크립트 -->
    <script type="text/javascript">
        const room_Id = "${room_Id}";
        const user_id = "${sessionScope.userId}";
        const mynickname = "${sessionScope.userVO.nickname}";
        const admin_id = "${adminId}";

        // 결제를 위해서 쓰는 변수
        const email = "${sessionScope.userVO.email}";
        const given_name = "${sessionScope.userVO.given_name}";
        const family_name = "${sessionScope.userVO.family_name}";
    </script>

    <!-- Basic CSS -->
    <link rel="stylesheet" href="/resources/css/drawing/style.css">
    <link rel="stylesheet" href="/resources/css/drawing/Skeleton.css?after">
    <link rel="stylesheet" href="/resources/css/drawing/pageTab.css?reload">
    <link rel="stylesheet" href="/resources/css/drawing/chat.css?reload">
    <link rel="stylesheet" href="/resources/css/drawing/chessPattern.css">

</head>

<body data-spy="scroll" data-target="#header" style="padding-top:80px">
<!--Start Hedaer Section-->
<%--<jsp:include page="/WEB-INF/views/mainMenu.jsp"></jsp:include>--%>
<c:choose>
    <c:when test="${empty pwWrttenByUser && dbPassword != null}">
        <script>
            const wrttenPw = "${pwWrttenByUser}";
        </script>
        <script type="text/javascript" src="/resources/js/drawing/passwordCheck.js"></script>
        <!-- 비밀번호 입력 모달파트 data-backdrop="static"(검은 배경을 눌러도 안닫히게) data-keyboard="false"(esc 눌러도 안닫히게) -->
        <div class="modal fade" tabindex="-1" role="dialog" id="entrance-modal" data-backdrop="static"
             data-keyboard="false">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title">パスワードを入力てください。</h2>
                    </div>
                    <div class="modal-body">
                        <p>このルームはパスワードが設定されていますので、パスワードを確認させていただきます。</p>
                        <div class="form-group">
                            <label for="pwCheck"></label>
                            <input id="pwCheck" type="password" class="form-control" placeholder="パスワード">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="cancel-entrance" type="button" class="btn btn-secondary" data-dismiss="modal">戻る
                        </button>
                        <button id="execute-entrance" type="button" class="btn btn-primary">入室</button>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <script src="/resources/js/drawing/drawingFunctionSet.js?reload"></script>
        <jsp:include page="/WEB-INF/views/baseJSP/toolTop.jsp"></jsp:include>

        <!-- 픽셀선물 토스트 -->
        <div aria-live="polite" aria-atomic="true" style="position: relative; min-height: 1px; z-index:9999;">
            <!-- Position it -->
            <div id="toasts-container" style="position: absolute; top: 0; right: 0;">
                <!-- Then put toasts within -->
                    <%--                <div id= "noti-userid-1" class="toast" role="alert" aria-live="assertive" aria-atomic="true">--%>
                    <%--                    <div class="toast-header">--%>
                    <%--                        <strong class="mr-auto">Aivyss -> ???</strong>--%>
                    <%--                        <small class="text-muted">500Pixel</small>--%>
                    <%--                        <button id="noti-userId-1-btn" type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">--%>
                    <%--                            <span aria-hidden="true">&times;</span>--%>
                    <%--                        </button>--%>
                    <%--                    </div>--%>
                    <%--                    <div class="toast-body">--%>
                    <%--                        이거 줄게 먹고 떨어져1--%>
                    <%--                    </div>--%>
                    <%--                </div>--%>
            </div>
        </div>

        <!-- 본격적인 드로잉 페이지 시작 -->
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
                                        <li><a href="#" id="create-layer-btn"><span
                                                class="glyphicon glyphicon-plus"></span>Create layer</a></li>
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
                            <div role="tabpanel"
                                 class="tab-pane figure figure_bg figure_bg_light center-block in active"
                                 id="createPageTab">
                                <div class="jumbotron">
                                    <h1>絵をかきましょう！</h1>
                                    <p>Create Pageボータンを押してページを作ってみましょう。</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="onePageBuffer" style="display:none">
                </div>
            </div><!-- 메인창 엔드 -->
        </div>
        <!-- 사실상 body end -->
    </c:otherwise>
</c:choose>

<!-- 픽셀선물 모달파트 -->
<div class="modal fade" tabindex="-1" role="dialog" id="present-pixel-modal" style="z-index: 20000;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title" id="present-pixel-modal-title">

                </h1>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 픽셀 단위 리스트 -->
                <div class="row">
                    <div class="col-md-9">
                        <div class="input-group col-md-12">
                            <span class="input-group-addon">
                                <input type="radio" value="100" name="pixel-amount-list">
                            </span>
                            <input type="text" class="form-control" value="100 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="300" name="pixel-amount-list">
                            </span>
                            <input type="text" class="form-control" value="300 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="500" name="pixel-amount-list">
                            </span>
                            <input type="text" class="form-control" value="500 pixel" readonly="readonly">
                        </div>

                        <div class="input-group col-md-12">
                            <span class="input-group-addon">
                                <input type="radio" value="1000" name="pixel-amount-list">
                            </span>
                            <input type="text" class="form-control" value="1000 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="1500" name="pixel-amount-list">
                            </span>
                            <input type="text" class="form-control" value="1500 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="2000" name="pixel-amount-list">
                            </span>
                            <input type="text" class="form-control" value="2000 pixel" readonly="readonly">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <h4>あなたが持っているピックセルの数です。</h4>
                    <input type="text" id="my-pixel" class="form-control" readonly="readonly">
                    <h4>下にメッセージを作成したください。</h4>
                    <input type="text" id="present-message" class="form-control">
                </div>

                <!-- 히든 벨류 -->
                <input type="hidden" id="target-drawer-id">
                <input type="hidden" id="target-drawer-nickname">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                <button type="button" class="btn btn-primary" id="execute-present">プレゼント</button>
            </div>
        </div>
    </div>
</div>

<!-- 픽셀결제 모달파트 -->
<div class="modal fade" tabindex="-1" role="dialog" id="pixel-product-modal" style="z-index: 20000;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title">
                    課金するピックセルの数を選んでください。
                </h1>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 픽셀 단위 리스트 -->
                <div class="row">
                    <div class="col-md-9">
                        <div class="input-group col-md-12">
                            <span class="input-group-addon">
                                <input type="radio" value="100" name="pixel-product-list">
                            </span>
                            <input type="text" class="form-control" value="100 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="300" name="pixel-product-list">
                            </span>
                            <input type="text" class="form-control" value="300 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="500" name="pixel-product-list">
                            </span>
                            <input type="text" class="form-control" value="500 pixel" readonly="readonly">
                        </div>

                        <div class="input-group col-md-12">
                            <span class="input-group-addon">
                                <input type="radio" value="1000" name="pixel-product-list">
                            </span>
                            <input type="text" class="form-control" value="1000 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="1500" name="pixel-product-list">
                            </span>
                            <input type="text" class="form-control" value="1500 pixel" readonly="readonly">

                            <span class="input-group-addon">
                                <input type="radio" value="2000" name="pixel-product-list">
                            </span>
                            <input type="text" class="form-control" value="2000 pixel" readonly="readonly">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                <button type="button" class="btn btn-primary" id="execute-payment">支払う</button>
            </div>
        </div>
    </div>
</div>

<!-- 피드작성 모달파트 -->
<div class="modal fade" tabindex="-1" role="dialog" id="make-feed-modal" style="z-index: 20000;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title">
                    フィードの内容とタグを入力してください
                    <small>タグは前に#をつけて作ることができます。</small>
                </h1>
            </div>
            <div class="modal-body">
                <!-- content part -->
                <div class="row">
                    <textarea id="pre-context" rows="20" style="width: 100%; resize: none;"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                <button type="button" class="btn btn-primary" onclick="createFeedController.makeFeedExecution();">アップロード</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>