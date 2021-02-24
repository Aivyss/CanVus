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
    <title>Browse List</title>
    <link rel="stylesheet" href="/resources/css/browse/card.css?reload">
    <link rel="stylesheet" href="/resources/css/browse/searchBar.css?reload">
</head>


<body data-spy="scroll" data-target="#header">
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
        <c:choose>
            <c:when test="${counter == navi.currentPage }">
                <b>${counter }</b>
            </c:when>
            <c:otherwise>
                <a href="/browse/list/?page=${counter }">${counter }</a>
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

</div>

</body>
</html>
