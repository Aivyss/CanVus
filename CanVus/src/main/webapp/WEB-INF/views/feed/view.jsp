<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/14/2021
  Time: 10:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<div class="container" style="padding-top: 50px;">
    <link rel="stylesheet" href="/resources/css/feed/feed.css?reload">
    <div class="container feed-plate height-100 d-flex justify-content-center align-items-center">
        <div class="card card-border center-block">
            <div class="row center-block">
                <!-- 컨텐츠 포지션 -->
                <div class="col-xs-9" style="margin-top: 5px;">
                    <!-- 그림들 -->
                    <c:forEach items="${feedPictures}" var="picture" varStatus="status">
                        <c:choose>
                            <c:when test="${status.index == 0}">
                                <img src="<spring:url value='/userPicture/${picture.page_file_output}'/>" width="100%"
                                     id="pictureContainer_${status.index}">
                            </c:when>
                            <c:otherwise>
                                <img src="<spring:url value='/userPicture/${picture.page_file_output}'/>" width="100%"
                                     id="pictureContainer_${status.index}" style="display: none;">
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <div class="p-3 content">
                        <span>total ${fn:length(feedPictures)}pages</span>
                        <p>${feedAbstract.context}</p>
                    </div>
                </div>

                <!-- 사이드 포지션 -->
                <div class="col-xs-3 height-100 side-plate" style="margin-top: 5px;">
                    <!-- 참여유저 목록 -->
                    <div class="list-group">
                        <c:if test="${not empty feedAbstract.user_id1}">
                            <a href="/user/board/?user_id=${feedAbstract.user_id1}"
                               class="list-group-item">${feedAbstract.nickname1}</a>
                        </c:if>
                        <c:if test="${not empty feedAbstract.user_id2}">
                            <a href="/user/board/?user_id=${feedAbstract.user_id2}"
                               class="list-group-item">${feedAbstract.nickname2}</a>
                        </c:if>
                        <c:if test="${not empty feedAbstract.user_id3}">
                            <a href="/user/board/?user_id=${feedAbstract.user_id3}"
                               class="list-group-item">${feedAbstract.nickname3}</a>
                        </c:if>
                        <c:if test="${not empty feedAbstract.user_id4}">
                            <a href="/user/board/?user_id=${feedAbstract.user_id4}"
                               class="list-group-item">${feedAbstract.nickname4}</a>
                        </c:if>
                    </div>
                    <br>

                    <!-- like 버튼 -->
                    <div>
                        <c:choose>
                            <c:when test="${isLiked}">
                                <button class="btn btn-primary" type="button">
                                    Unlike
                                    <span class="badge">${likeCount}</span>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-primary" type="button">
                                    Like
                                    <span class="badge">${likeCount}</span>
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <br>

                    <!-- 북마크 버튼 -->
                    <div>
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1"
                                    data-toggle="dropdown" aria-expanded="true">
                                bookmark
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크1</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크2</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크3</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">북마크4</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row center-block">
                <br>
                <!-- 코멘트 컨테이너-->
                <div class="col-lg-6">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search for...">
                        <span class="input-group-btn">
                                <button class="btn btn-default" type="button">comment</button>
                            </span>
                    </div>
                    <div class="about">
                            <span>
                                <span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                                <small>12</small></span>
                        <span class="ml-2">
                                <span class="glyphicon glyphicon-envelope"></span>
                                <small>12</small>
                            </span>
                    </div>
                </div>
            </div>
            <br>
            <!-- 코멘트란 -->
            <div class="row center-block">
                <c:if test="${not empty feedComments}">
                    <c:forEach items="${feedComments}" var="comment">
                        <div class="col-lg-6">
                            <div class="media">
                                <div class="media-left media-middle">
                                    <a href="#">
                                        <img class="media-object"
                                             src="<spring:url value='/userProfile/${comment.profile_photo}'/>"
                                             style="height:32px; width:32px;">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <h5 class="media-heading"><a
                                            href="/user/board/?user_id=${comment.user_id}">${comment.nickname}</a></h5>
                                        ${comment.feed_comment}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
