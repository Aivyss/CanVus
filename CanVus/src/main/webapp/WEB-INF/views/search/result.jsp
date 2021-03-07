<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/19/2021
  Time: 2:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Search Result</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/universal/GallerySkeleton.css">
<link rel="stylesheet" href="/resources/css/universal/pagination.css">
<script src="/resources/js/search/search.js"></script>

<c:choose>
    <c:when test="${empty feedBundle}">
        <!-- 검색결과가 없는 경우 -->
        <div class="container">
            <div class="jumbotron" style="background-color: white;">
                <h1>検索の結果がありません。</h1>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <!-- 검색결과가 있는 경우 -->
        <c:choose>
            <c:when test="${empty pNav}">
                <!-- search user case -->
                <div class="container">
                    <div class="jumbotron" style="background-color: white;">
                        <div class="col-md-3 avatar-container text-center">
                            <a href="/user/board/?user_id=${targetId}">
                                <img src="<spring:url value='/userProfile/${profile}'/>"
                                     class="img-circle profile-avatar"
                                     alt="プロフィール"
                                     style="margin:10% 0; width:100px; height:100px; background-color:white;"
                                     id="photo-preview">
                            </a>
                        </div>
                        <h1>「<a href="/user/board/?user_id=${targetId}">${nickname}</a>」さんを見つけました。</h1>
                    </div>

                    <!-- search result of preview -->
                    <div class="row">
                        <div class="list-group gallery">
                            <c:forEach items="${feedBundle}" var="feed">
                                <div class='col-sm-4 col-xs-6 col-md-2 col-lg-2 hover-fade'>
                                    <a class="thumbnail" rel="ligthbox"
                                       href="javascript:createModal('/feed/view/?feed_id=${feed.FEED_ID}')">
                                        <img class="img-responsive" alt=""
                                             src="<spring:url value='/userPicture/${feed.PREVIEW}'/>"
                                             style="width: 150px; height:150px;"/>
                                        <div class='text-right'>
                                            <small class='text-muted'>${nickname}</small>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- search tag case -->
                <!-- search abstract -->
                <div class="container center-block">
                    <div class="jumbotron" style="background-color:white;">
                        <h1>「${tag}」の検索の結果です。</h1>
                    </div>

                    <!-- search result viewer -->
                    <div class="row">
                        <div class="list-group gallery">
                            <c:forEach items="${feedBundle}" var="feed">
                                <div class='col-sm-4 col-xs-6 col-md-2 col-lg-2 hover-fade'>
                                    <a class="thumbnail" rel="ligthbox"
                                       href="javascript:createModal('/feed/view/?feed_id=${feed.FEED_ID}')">
                                        <img class="img-responsive" alt=""
                                             src="<spring:url value='/userPicture/${feed.PREVIEW}'/>"
                                             style="width: 150px; height:150px;"/>
                                        <div class='text-right'>
                                            <small class='text-muted'>${feed.NICKNAME}</small>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- pagination part -->
                    <div class="row text-center">
                        <div class="center-block">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="javascript:pagenation('${tag}','${pNav.currentPage-1}', '${pNav.totalPageCount}')"
                                           aria-label="Previous">
                                            <span aria-hidden="true">«</span>
                                            <span class="sr-only">Previous</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="${pNav.startPageGroup}" end="${pNav.endPageGroup}" var="count">
                                        <c:choose>
                                            <c:when test="${count == pNav.currentPage}">
                                                <li class="page-item active"><a class="page-link" href="#">${count}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link"
                                                       href="javascript:pagenation('${tag}', '${count}', '${pNav.totalPageCount}')">${count}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="javascript:pagenation('${tag}', '${pNav.currentPage+1}', '${pNav.totalPageCount}')"
                                           aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

<!-- feed view overlay -->
<div id="feed-overlay" class="modal fade" tabindex="-1" role="dialog">
    <!-- 이곳에 피드를 불러온다. -->
</div>
<script src="/resources/js/universal/feed.js?reload"></script>
<script src="/resources/js/universal/modal.js?reload"></script>
</body>
</html>
