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
    <title>Feed</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<div class="container container-feed" style="padding-top: 50px;" id="feed-body">
    <input type="hidden" value="${fn:length(feedPictures)}" id="imageLengthVal">
    <input type="hidden" value="${sessionScope.userId}" id="user_idVal">
    <input type="hidden" value="${feedAbstract.user_id1}" id="feed-owner-idVal">
    <input type="hidden" value="${feedAbstract.feed_id}" id="feed_idVal">
    <input type="hidden" value="${isLiked}" id="isLikeVal">
    <input type="hidden" value="${likeCount}" id="likeCountVal">
    <input type="hidden" value="${fn:length(feedComments)}" id="commentCountVal">

    <div class="container container-feed feed-plate height-100 d-flex justify-content-center align-items-center">
        <div class="card card-border center-block" style="background-color: whitesmoke;">
            <div class="row center-block">
                <!-- 컨텐츠 포지션 -->
                <div class="col-md-8" style="margin-top: 5px;">
                    <!-- 그림들 -->
                    <c:forEach items="${feedPictures}" var="picture" varStatus="status">
                        <c:choose>
                            <c:when test="${status.index == 0}">
                                <img src="<spring:url value='/userPicture/${picture.page_file_output}'/>" width="100%"
                                     id="pictureContainer_${status.index+1}" class="pictures">
                            </c:when>
                            <c:otherwise>
                                <img src="<spring:url value='/userPicture/${picture.page_file_output}'/>" width="100%"
                                     id="pictureContainer_${status.index+1}" style="display: none;" class="pictures">
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- 텍스트란 -->
                    <div class="p-3 content feed-content">
                        <h2>total ${fn:length(feedPictures)}pages</h2><br>
                        <p id="feed-text">${feedAbstract.context}</p>
                    </div>
                </div>

                <!-- 사이드 포지션 -->
                <div class="col-md-3 height-100 side-plate center-block"
                     style="margin-left: 45px;">
                    <!-- drawer 목록 -->
                    <div class="row" style="text-align:center;">
                        <br>
                        <a class="btn btn-lg namebtn" href="/user/board/?user_id=${feedAbstract.user_id1}">
                            <span>${feedAbstract.nickname1}</span>
                        </a>
                        <br>
                        <c:if test="${not empty feedAbstract.user_id2}">
                            <a class="btn btn-lg namebtn" href="/user/board/?user_id=${feedAbstract.user_id2}">
                                <span>${feedAbstract.nickname2}</span>
                            </a>
                            <br>
                        </c:if>
                        <c:if test="${not empty feedAbstract.user_id3}">
                            <a class="btn btn-lg namebtn" href="/user/board/?user_id=${feedAbstract.user_id3}">
                                <span>${feedAbstract.nickname3}</span>
                            </a>
                            <br>
                        </c:if>
                        <c:if test="${not empty feedAbstract.user_id4}">
                            <a class="btn btn-lg namebtn" href="/user/board/?user_id=${feedAbstract.user_id4}">
                                <span>${feedAbstract.nickname4}</span>
                            </a>
                            <br>
                        </c:if>
                        <br>
                        <link rel="stylesheet" href="/resources/css/feed/namebtn.css?reload">
                    </div>

                    <div class="row text-center">
                        <!-- like 버튼 -->
                        <c:choose>
                            <c:when test="${empty sessionScope.userId}"> <!-- 비로그인 유저 -->
                                <a href="#" id="like-container"><span class="thumb thumbs-up glyphicon glyphicon-heart"
                                                                      id="like"></span></a>
                            </c:when>
                            <c:otherwise> <!-- 로그인 유저 -->
                                <c:choose>
                                    <c:when test="${isLiked}">
                                        <a href="#" id="like-container"><span
                                                class="thumb thumbs-up glyphicon glyphicon-heart" id="like"
                                                style="background-color: red"></span></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#" id="like-container"><span
                                                class="thumb thumbs-up glyphicon glyphicon-heart"
                                                id="like"></span></a>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>

                        <!-- 북마크 파트 -->
                        <a href="#" id="bmsIcon"><span class="glyphicon glyphicon-bookmark bookmarkCSS"></span>
                        </a>
                        <div class="row" id="bookmarkListup">
                            <c:if test="${not empty sessionScope.userId}">
                                <ul class="dropdown-menu custom-dropdown open" role="menu" id="bms">
                                    <c:forEach items="${bookmarks}" var="bookmark">
                                        <li><a id="bm-${bookmark.folder_id}" href="#">${bookmark.folder_name}</a></li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </div>
                    </div>

                    <br><br>

                    <!-- 게이지바 -->
                    <div class="row text-center">
                        <div class="center-block text-center" style="text-align:center;">
                            <h3>ページリモコン</h3><br>
                            <div class="bs-example" data-example-id="progress-bar-at-low-percentage">
                                <div class="progress">
                                    <div class="progress-bar" id="picture-bar" role="progressbar" aria-valuenow="0"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="min-width: ${100 / fn:length(feedPictures)}%;">
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <!-- 네비게이션 버튼 -->
                                <a href="#"><span class="glyphicon glyphicon-arrow-left previous-btn"
                                                  id="previous-btn"></span></a>
                                <a href="#"><span class="glyphicon glyphicon-arrow-right next-btn" id="next-btn"></span></a>
                            </div>
                        </div>
                    </div>

                    <!-- 피드삭제 (어드민 전용)  -->
                    <c:if test="${sessionScope.userId == feedAbstract.user_id1}">
                        <div class="row text-center">
                            <a href="#" id="delete-feed-btn">
                                <span class="thumb thumbs-up glyphicon glyphicon-trash"></span>
                            </a>
                        </div>
                    </c:if>
                </div>
                <br>
            </div>
            <!-- 코멘트 컨테이너 -->
            <div class="row center-block">
                <br>
                <!-- 코멘트 컨테이너-->
                <div class="col-lg-12">
                    <div class="input-group">
                        <c:choose>
                            <c:when test="${not empty sessionScope.userId}"> <!-- 로그인 유저 -->
                                <input type="text" class="form-control" placeholder="コメントを付けてみましょう。" id="comment-input">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" id="comment-btn">
                                        コメント
                                    </button>
                                </span>
                            </c:when>
                            <c:otherwise><!-- 비로그인 유저 -->
                                <input type="text" class="form-control" placeholder="ログインして下さい。" id="comment-input" readonly="readonly">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" id="comment-btn">
                                        コメント
                                    </button>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="about">
                            <span>
                                <span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                                <span id="like-count"><small id="like-count-small">${likeCount}</small></span></span>
                        <span class="ml-2">
                                <span class="glyphicon glyphicon-envelope"></span>
                                <span id="comment-count"><small
                                        id="comment-count">${fn:length(feedComments)}</small></span>
                            </span>
                    </div>
                </div>
            </div>
            <br>
            <!-- 코멘트란 -->
            <div class="row center-block" id="comment-box">
                <c:if test="${not empty feedComments}">
                    <c:forEach items="${feedComments}" var="comment">
                        <div class="col-lg-12" id="comment-box-${comment.comment_id}">
                            <div class="media">
                                <div class="media-left media-middle">
                                    <a href="#">
                                        <img class="media-object"
                                             src="<spring:url value='/userProfile/${comment.profile_photo}'/>"
                                             style="height:32px; width:32px;">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <div class="col-md-10">
                                        <h5 class="media-heading">
                                            <a href="/user/board/?user_id=${comment.user_id}">${comment.nickname}</a>
                                        </h5>
                                        <p>${comment.feed_comment}</p>
                                    </div>
                                    <c:if test="${comment.user_id == sessionScope.userId}">
                                        <div class="col-md-2">
                                            <input type="button"
                                                   class="btn btn-primary"
                                                   value="リムーブ"
                                                   style="margin-bottom: 20px;
                                                        background:linear-gradient( to bottom, #ff0000, #cc0000 );
                                                        border-radius: 20px 20px 20px 20px;"
                                                   onclick="deleteComment('${comment.comment_id}')">
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
    <link rel="stylesheet" href="/resources/css/feed/feed.css">
    <link rel="stylesheet" href="/resources/css/feed/likeBtn.css">
    <link rel="stylesheet" href="/resources/css/feed/bookmarkshape.css">
    <link rel="stylesheet" href="/resources/css/feed/pictureNav.css">
</div>
<script src="/resources/js/universal/feed.js?reload"></script>
</body>
</html>
