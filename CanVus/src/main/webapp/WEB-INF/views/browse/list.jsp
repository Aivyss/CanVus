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
</head>


<body data-spy="scroll" data-target="#header">
<!-- 네비 바 -->
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<script src="/resources/js/browse/browse.js?reload"></script>

<div class="input-group navbar-collapse" id="searchTitleBar">
    <span class="input-group-btn">
        <button class="btn btn-default" type="button">
            <img src="/resources/images/browse/search.png" width="18px" cursor="pointer">
        </button>
    </span>
    <input type="text" class="form-control" placeholder="Search for..." id="searchTitle">
</div>

<table border="1">
    <tr>
        <th>Title</th>
        <th>Nickname</th>
        <th>Members</th>
        <th>Capacity</th>
        <th>Thumbnail</th>
    </tr>

    <c:forEach items="${list }" var="room">
        <tr>
            <td>${room.TITLE}</td>
            <td>${room.NICKNAME}</td>
            <td>${room.USER_COUNT}</td>
            <td>${room.USER_NO}</td>
            <td><img src="<spring:url value='/roomThumbnail/${room.ROOM_ID}--Thumbnail--.png'/>"
                    onerror="this.src='<spring:url value="/roomThumbnail/defaultRoom.jpg"/>'"></td>
        </tr>
    </c:forEach>
</table>

<div>

    <c:choose>
        <c:when test="${navi.currentPage == 1}">
            <button type="button" id="previousPage" disabled="disabled">◀</button>
        </c:when>
        <c:otherwise>
            <button type="button" id="previousPage" value="${navi.currentPage-1}">◀</button>
        </c:otherwise>
    </c:choose>

    <c:forEach begin="${navi.startPageGroup }" end="${navi.endPageGroup }" var="counter">
<script src="/resources/js/browse/browse.js?after"></script>

<!-- hidden values -->
<input type="hidden" value="${navi.currentPage}" id="pageNo">

<!-- Body part -->
<div class="container-fluid center-block">
    <div class="jumbotron">
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
    </c:forEach>

    <c:choose>
        <c:when test="${navi.currentPage == navi.totalPageCount}">
            <button type="button" id="nextPage" disabled="disabled">▶</button>
        </c:when>
        <c:otherwise>
            <button type="button" id="nextPage" value="${navi.currentPage+1}">▶</button>
        </c:otherwise>
    </c:choose>

        <!-- 방 검색 창 -->
        <div class="row">
            <div class="input-group navbar-collapse" id="room-search-bar">
            <span class="input-group-btn">
                <button class="btn btn-navv btn-default" type="button" id=room-search>検索</button>
            </span>
                <input type="text" val="${title}" class="form-control" placeholder="Search for..." id="room-search-text">
            </div>
        </div>
    </div>


    <!-- 룸리스트  6r/1p-->
    <div class="row" style="margin-top:20px;">
        <c:forEach items="${list }" var="room">
            <div class="col-sm-3 col-md-2 col-md-offset-1 text-center">
                <div class="thumbnail">
                    <img src="<spring:url value='/roomThumbnail/${room.ROOM_ID}--Thumbnail--.png'/>"
                         onerror="this.src='<spring:url value="/roomThumbnail/defaultRoom.jpg"/>'"
                         style="width:150px; height:150px; display:block;">
                    <div class="caption">
                        <div class="row">
                            <h3 id="room-title-container-${room.ROOM_ID}">${room.TITLE}</h3>
                            <br>
                            <h3>${room.NICKNAME} <span
                                    class="label label-success">${room.USER_COUNT}/${room.USER_NO}名</span></h3>
                        </div>
                        <div class="row entrance-btn-container" style="margin-top: 15px;">
                            <button class="btn btn-info btn-default btn-block" id="make-bookmark-btn-${room.ROOM_ID}">
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
                            <c:when test="${counter == navi.currentPage}">
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
    <div class="modal" tabindex="-1" role="dialog" id="enter-modal" style="margin-top: 120px;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title" id="modal-room-title"></h2>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id=""></p>
                    <div class="form-group">
                        <label for="input-room-password"></label>
                        <input id="input-room-password" type="text" class="form-control" placeholder="パスワード">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                    <button type="button" class="btn btn-primary" id="execute-enter-room">入る</button>
                </div>
            </div>
        </div>
        <input type="hidden" id="room-modal-exact-pw">
        <input type="hidden" id="room-modal-id">
    </div>
</div>
</body>
</html>
