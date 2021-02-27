<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 코어태그 사용을 위한 tablig -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 로컬 파일을 불러오기 위한 taglib -->
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Board</title>
    <script>
        // 페이지에서 쓰일 전역변수 셋
        const user_id = "${userInfo.user_id}";
        let pageNo = 1;
        let totalPageCount = ${totalPageCount};
    </script>
</head>

<body>
<!-- top nav -->
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>

<!-- statics -->
<link rel="stylesheet" href="/resources/css/user/board/Skeleton.css">
<link rel="stylesheet" href="/resources/css/user/board/bookmarkshape.css">
<link rel="stylesheet" href="/resources/css/user/board/likeBtn.css">
<link rel="stylesheet" href="/resources/css/user/board/board.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<script src="/resources/js/user/board/board.js"></script>

<!-- rendering part -->
<div class="container bootdey">
    <div class="content-page">
        <!-- 유저 개요( 프로필 사진 및 닉네임 표시 -->
        <div class="profile-banner" style="background:url(/resources/images/user/board/bg1.jpg);">
            <div class="row"></div>
            <div class="col-sm-3 avatar-container">
                <img src="<spring:url value='/userProfile/${userInfo.profile_photo}'/>"
                     class="img-circle profile-avatar"
                     alt="User avatar">
            </div>
            <div class="col-sm-12 profile-actions text-right">
                <div class="nickname-header">
                    <h1 class="nickname-header">${userInfo.nickname}</h1>
                </div>
            </div>
        </div>

        <div class="content">
            <div class="row center-block">
                <!-- 유저 정보 리스트 -->
                <div class="col-sm-3">
                    <div class="text-center user-profile-2" style="margin-top:120px">
                        <ul class="list-group">
                            <!-- 팔로워 리스트 -->
                            <div class="btn-group" style="width:100%;">
                                <button class="btn list-group-item dropdown-toggle" type="button"
                                        data-toggle="dropdown" aria-expanded="false" style="width: 100%">
                                    Follower
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu follow-list" role="menu"
                                    style="width:100%; text-align:center;">
                                    <li>
                                        <a href="/user/board/?user_id=${following.following_id}" class="text-right">
                                            테스트 닉네임1
                                            <button type="button" class="btn btn-default btn-sm"
                                                    aria-label="followers">
                                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                            </button>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="/user/board/?user_id=${following.following_id}" class="text-right">
                                            테스트 닉네임2
                                            <button type="button" class="btn btn-default btn-sm"
                                                    aria-label="followers">
                                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                            </button>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <!-- 팔로우 리스트 -->
                            <div class="btn-group" style="width:100%;">
                                <button class="btn list-group-item dropdown-toggle" type="button"
                                        data-toggle="dropdown" aria-expanded="false" style="width: 100%">
                                    Follow
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu follow-list" role="menu"
                                    style="width:100%; text-align:center;">
                                    <li>
                                        <a href="/user/board/?user_id=${following.following_id}" class="text-right">
                                            테스트 닉네임1
                                            <button type="button" class="btn btn-default btn-sm"
                                                    aria-label="followers">
                                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                            </button>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="/user/board/?user_id=${following.following_id}" class="text-right">
                                            테스트 닉네임2
                                            <button type="button" class="btn btn-default btn-sm"
                                                    aria-label="followers">
                                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                            </button>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <!-- 누적 픽셀 정보 -->
                            <li class="list-group-item">
                                <span class="badge">245</span>
                                Accumulated Pixel
                            </li>
                        </ul>
                    </div>
                </div> <!-- 유저 정보 리스트 끝 -->


                <div class="col-sm-9 center-block" style="margin-top:20px;">
                    <!-- 피드 번들 파트-->
                    <div class="row center-block" id="feeds-container">
                        <c:forEach items="${bundle}" var="oneFeed" varStatus="status">
                            <div class="col-xs-6 col-sm-3 hover-fade feed-gallary">
                                <a href="#">
                                    <img src="<spring:url value='/userPicture/${oneFeed.pictures[0]}'/>">
                                </a>
                                <div class="caption" style="position:absolute; left:0px; top:70px;">
                                    <div class="col-lg-6" id="like-container">
                                        <div id="likeDiv">
                                            <span class="thumb thumbs-up glyphicon glyphicon-heart" id="like"
                                                  style="display:block"></span>
                                        </div>
                                        <span class="glyphicon glyphicon-bookmark bookmarkCSS" data-toggle="dropdown"
                                              area-expanded="false"></span>
                                        <ul class="dropdown-menu custom-dropdown" role="menu" id="bms">
                                            <c:forEach items="${bookmarks}" var="bookmark">
                                                <li>
                                                    <a id="bm-${bookmark.folder_id}" href="#">
                                                            ${bookmark.folder_name}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- See more 파트 -->
                    <div class="row center-block" style="margin-top:50px; margin-bottom:50px;">
                        <button class="btn btn-info btn-lg btn-block" id="more-btn">もっとみる！</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>