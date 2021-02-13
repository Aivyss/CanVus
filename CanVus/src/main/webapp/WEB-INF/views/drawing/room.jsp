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
    <script src="/resources/js/fabric/dist/fabric.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
            integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
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
        <link rel="stylesheet" href="/resources/css/drawing/sideBar.css">
        <link rel="stylesheet" href="/resources/css/drawing/pageTab.css">
        <link rel="stylesheet" href="/resources/css/drawing/layerList.css">

        <div class="skeleton" style="padding-top:5px;">
            <div class="row-fluid">
                <div id="sidebar" class="span2">
                    <!-- 사이드바 -->
                    <div>
                        <div style="float:left;width:100px;">레이어 추가 : </div>
                        <div style="clear:both;">
                            <input type="button" id="addItem" value="추가" onclick="createLayer();" />
                        </div>
                    </div>

                    <br>

                    <div id="itemBoxWrap" style="overflow:auto; width:300px; height:150px;"></div>
                    <script src="/resources/js/drawing/layerList.js"></script>
                </div>

                <div id="content" class="span7">
                    <!-- 툴탭 -->
                    <div id="container">
                        <ul class="tab">
                            <li class="current" data-tab="create" id="createPage"><a href="#">New Page</a></li>
                        </ul>
                        <!-- 생성을 위한 툴탭 -->
                        <div id="base">
                            <div id="create" class="tabcontent current" style="display: none"></div>
                        </div>
                    </div>
                </div> <!-- end #content -->
            </div> <!-- end .row-fluid -->
        </div> <!-- end .container -->
    </c:otherwise>
</c:choose>
</body>
</html>