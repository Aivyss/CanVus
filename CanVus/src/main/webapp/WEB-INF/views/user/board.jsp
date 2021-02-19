<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
\
<!-- 코어태그 사용을 위한 tablig -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 로컬 파일을 불러오기 위한 taglib -->
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Board</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 유저보드 점보트론 -->
<div class="jumbotron">
    <h1>${userInfo.nickname}</h1>

    <div class="container">
        <div class="row">
            <div class="panel panel-default">
                <!-- 프로파일 파트 -->
                <div class="col-sm-6 col-md-4" style="width: 100px; height:100px; margin-top:18px">
                    <div class="thumbnail" style="width:100%; height:100%;">
                        <img src="<spring:url value='/userProfile/${userInfo.profile_photo}'/>"
                             style="height:100%; width:100%; margin:0px">
                    </div>
                </div>
                <!-- self presentation -->
                <div class="panel-body" style="margin-top:18px">
                    ${userInfo.introduction}
                </div>
            </div>
        </div>
        <div class="row">
            <!-- 팔로워 드랍다운 파트-->
            <div class="btn-group">
                <button class="btn btn-default btn-lg dropdown-toggle" type="button" data-toggle="dropdown"
                        aria-expanded="false">
                    あなたのフォロワー <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <c:forEach items="${followInfoPack['followerList']}" var="follower">
                        <li>
                            <a href="/user/board/?user_id=${follower.user_id}" class="text-right">
                                    ${follower.nickname}
                                <button type="button" class="btn btn-default btn-sm" aria-label="followers">
                                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                </button>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!-- 팔로잉 드랍다운 파트 -->
            <div class="btn-group">
                <button class="btn btn-default btn-lg dropdown-toggle" type="button" data-toggle="dropdown"
                        aria-expanded="false">
                    あなたのフォロー <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <c:forEach items="${followInfoPack['followList']}" var="following">
                        <li>
                            <a href="/user/board/?user_id=${following.following_id}" class="text-right">
                                    ${following.nickname}
                                <button type="button" class="btn btn-default btn-sm" aria-label="followers">
                                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                </button>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <p>...</p>
    <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
</div>

<!-- 피드 번들 파트 -->
<div class="container-fluid">
    <c:forEach items="${bundle}" var="oneFeed">
        <div class="row">
            <div class="col-sm-6 col-md-4" style="width: 250px; height:250px; margin:0px">
                <div class="thumbnail" style="width:100%; height:100%;">
                    <img src="<spring:url value='/userPicture/${oneFeed.pictures[0]}'/>"
                         style="height:100%; width:100%; margin:0px">
                    <div class="caption" style="position: absolute; left:10px; top: 200px;">
                        <p><a href="#" class="btn btn-primary" role="button">Like</a>
                        </p></div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- 테스트용 EL 표현식 -->
    ${userInfo}
    ${bundle}
    ${followInfoPack}
</div>

</body>
</html>