<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/23/2021
  Time: 10:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse</title>
    <script>
        const userId = "${sessionScope.userId}";
    </script>
</head>


<body data-spy="scroll" data-target="#header">
<!-- 네비 바 -->
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<script src="/resources/js/browse/browse.js?after"></script>
<link rel="stylesheet" href="/resources/css/universal/pagination.css">
<link rel="stylesheet" href="/resources/css/browse/card.css">

<!-- hidden values -->
<input type="hidden" value="${navi.currentPage}" id="pageNo">

<!-- Body part -->
<div class="container-fluid center-block">
    <div class="jumbotron" style="background-color: white; border-radius: 0px 0px 20px 20px">
        <c:choose>
            <c:when test="${empty title}">
                <h1>一緒に描きましょう。</h1>
                <p>または、ただ見にいくこともいいですね。下の方に検索欄がありますので、使ってみましょう。</p>
            </c:when>
            <c:otherwise>
                <h1>「${title}」の検索の結果です。</h1>
                <p>下の方をご覧ください。</p>
            </c:otherwise>
        </c:choose>
        <!-- 방 검색 창 -->
        <div class="row">
            <div class="input-group navbar-collapse" id="room-search-bar">
            <span class="input-group-btn">
                <button class="btn btn-navv btn-default" type="button" id=room-search>検索</button>
            </span>
                <input type="text" val="${title}" class="form-control" placeholder="Search for..."
                       id="room-search-text">
            </div>
        </div>
    </div>

    <!-- 룸리스트  6r/1p-->
    <div class="row" style="margin-top:20px;">
        <c:forEach items="${list }" var="room">
            <div class="col-sm-3 col-md-2 col-md-offset-1 text-center">
                <div class="thumbnail" style="border-radius: 10px 10px 10px 10px;background-color: white;">
                    <img src="<spring:url value='/roomThumbnail/${room.ROOM_ID}--Thumbnail--.png'/>"
                         onerror="this.src='<spring:url value="/roomThumbnail/defaultRoom.jpg"/>'"
                         style="width:150px; height:150px; display:block; background-color: white;">
                    <div class="caption" style="background-color: white;border-radius: 10px 10px 10px 10px;margin-top: 10px;background-color: #c8c8c8">
                        <div class="row">
                            <h3 id="room-title-container-${room.ROOM_ID}">${room.TITLE}</h3>
                            <br>
                            <h3>${room.NICKNAME} <span
                                    class="label label-success">${room.USER_COUNT}/${room.USER_NO}名</span></h3>
                        </div>
                        <div class="row entrance-btn-container" style="margin-top: 15px; text-align: center;">
                            <button class="btn btn-lg btn-primmary btn-block btn-rounded" id="make-bookmark-btn-${room.ROOM_ID}" style="width: 80%;margin: auto;">
                                入る
                            </button>
                            <input type="hidden" value="${room.PASSWORD}" id="room-pw-container-${room.ROOM_ID}">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-3 col-md-1"></div>
        </c:forEach>
    </div>

    <!-- 페이지네이션 -->
    <div class="row text-center">
        <div class="center-block">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link"
                           href="javascript:pagenation('${title}','${navi.currentPage-1}', '${navi.totalPageCount}')"
                           aria-label="Previous">
                            <span aria-hidden="true">«</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <c:forEach begin="${navi.startPageGroup}" end="${navi.endPageGroup}" var="count">
                        <c:choose>
                            <c:when test="${count == navi.currentPage}">
                                <li class="page-item active"><a class="page-link" href="#">${count}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link"
                                       href="javascript:pagenation('${title}', '${count}', '${navi.totalPageCount}')">${count}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link"
                           href="javascript:pagenation('${title}', '${navi.currentPage+1}', '${navi.totalPageCount}')"
                           aria-label="Next">
                            <span aria-hidden="true">»</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <!-- 비밀번호 확인 모달창 -->
    <div class="modal fade" tabindex="-1" role="dialog" id="enter-modal" style="margin-top: 120px;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <div class="modal-header">
                            <h2 class="modal-title" id="modal-room-title"></h2>
                        </div>
                        <div class="modal-body">
                            <p id=""></p>
                            <div class="form-group">
                                <label for="input-room-password"></label>
                                <input id="input-room-password" type="password" class="form-control"
                                       placeholder="パスワード">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                            <button type="button" class="btn btn-primary" id="execute-enter-room">入る</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="modal-header">
                            <h2 class="modal-title">ログインしたユーザーの専用の機能です。</h2>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <input type="hidden" id="room-modal-exact-pw">
        <input type="hidden" id="room-modal-id">
    </div>
</div>
</body>
</html>