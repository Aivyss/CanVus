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
    <script type="text/javascript">
        const imageLength = ${fn:length(feedPictures)};
        const user_id = "${userId}";
        const feed_id = "${feedAbstract.feed_id}";
        let isLiked = ${isLiked};
        let commentCount = ${fn:length(feedComments)};
        let likeCount = ${likeCount};
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<div class="container container-feed" style="padding-top: 50px;">
    <link rel="stylesheet" href="/resources/css/feed/feed.css?reload">
    <script src="/resources/js/feed/feed.js"></script>
    <div class="container container-feed feed-plate height-100 d-flex justify-content-center align-items-center">
        <div class="card card-border center-block">
            <div class="row center-block">
                <!-- 컨텐츠 포지션 -->
                <div class="col-xs-9" style="margin-top: 5px;">
                    <!-- 그림들 -->
                    <c:forEach items="${feedPictures}" var="picture" varStatus="status">
                        <c:choose>
                            <c:when test="${status.index == 0}">
                                <img src="<spring:url value='/userPicture/${picture.page_file_output}'/>" width="100%"
                                     id="pictureContainer_${status.index}" class="pictures">
                            </c:when>
                            <c:otherwise>
                                <img src="<spring:url value='/userPicture/${picture.page_file_output}'/>" width="100%"
                                     id="pictureContainer_${status.index}" style="display: none;" class="pictures">
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- 텍스트란 -->
                    <div class="p-3 content">
                        <span>total ${fn:length(feedPictures)}pages</span>
                        <p>${feedAbstract.context}</p>
                    </div>
                </div>

                <!-- 사이드 포지션 -->
                <div class="col-xs-3 height-100 side-plate center-block" style="margin-bottom: 5px; margin-top:5px;">
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
                        <link rel="stylesheet" href="/resources/css/feed/namebtn.css">
                    </div>


                    <div class="row">
                        <!-- like 버튼 -->
                        <div class="col-lg-6" id="like-container">
                            <c:choose>
                                <c:when test="${isLiked}">
                                    <%--                                <div class="col-md-6">--%>
                                    <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like" style="background-color: red"></span>
                                    <%--                                </div>--%>
                                </c:when>
                                <c:otherwise>
                                    <%--                                <div class="col-md-6">--%>
                                    <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like"></span>
                                    <%--                                </div>--%>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <link rel="stylesheet" href="/resources/css/feed/likeBtn.css">

                        <!-- 북마크 파트 -->
                        <div class="col-lg-6 btn-group-sm">
                            <span class="glyphicon glyphicon-bookmark bookmarkCSS" data-toggle="dropdown"
                                  area-expanded="false"></span>
                            <ul class="dropdown-menu custom-dropdown" role="menu" id="bms">
                                <c:forEach items="${bookmarks}" var="bookmark">
                                    <li><a id="bm-${bookmark.folder_id}" href="#">${bookmark.folder_name}</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                        <link rel="stylesheet" href="/resources/css/feed/bookmarkshape.css">
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="block-center" style="text-align:center;">
                            <!-- 게이지바 -->
                            <div class="bs-example" data-example-id="progress-bar-at-low-percentage">
                                <div class="progress">
                                    <div class="progress-bar" id="picture-bar" role="progressbar" aria-valuenow="0"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="min-width: ${100 / fn:length(feedPictures)};">
                                    </div>
                                </div>
                            </div>
                            <div>
                                <!-- 네비게이션 버튼 -->
                                <a href="#"><span class="glyphicon glyphicon-arrow-left previous-btn"
                                                  id="previous-btn"></span></a>
                                <a href="#"><span class="glyphicon glyphicon-arrow-right next-btn" id="next-btn"></span></a>
                                <link rel="stylesheet" href="/resources/css/feed/pictureNav.css">
                            </div>
                        </div>
                    </div>
                </div>
                <br>
            </div>
            <!-- 코멘트 컨테이너 -->
            <div class="row center-block">
                <br>
                <!-- 코멘트 컨테이너-->
                <div class="col-lg-12">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Comment here..." id="comment-input">
                        <span class="input-group-btn">
                                <button class="btn btn-default" type="button" id="comment-btn">comment</button>
                            </span>
                    </div>
                    <div class="about">
                            <span>
                                <span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                                <span id="like-count"><small id="like-count">${likeCount}</small></span></span>
                        <span class="ml-2">
                                <span class="glyphicon glyphicon-envelope"></span>
                                <span id="comment-count"><small id="comment-count">${fn:length(feedComments)}</small></span>
                            </span>
                    </div>
                </div>
            </div>
            <br>
            <!-- 코멘트란 -->
            <div class="row center-block" id="comment-box">
                <c:if test="${not empty feedComments}">
                    <c:forEach items="${feedComments}" var="comment">
                        <div class="col-lg-12">
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
                                            href="/user/board/?user_id=${comment.user_id}">${comment.nickname}</a>
                                    </h5>
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
