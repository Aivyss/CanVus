<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>CanVus</title>
    <meta name="google-signin-client_id"
          content="1073968802049-evh62jql0f6gblp8din0t6rqv0sobg17.apps.googleusercontent.com">
    <script defer src="https://apis.google.com/js/platform.js"></script>
</head>

<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/universal/GallerySkeleton.css">

<c:choose>
    <c:when test="${empty userVO}"> <!-- 로그인 전 -->
        <link rel="stylesheet" href="/resources/css/home/loginSkeleton.css?reload">

        <!-- 공간 벌려주기 용 -->
        <div class="container" style="margin-top:1%;"></div>

        <!-- login panel -->
        <!-- login panel -->
        <div class="container center-block" id="logreg-forms"
             style="margin-top: 2%; height: 80%; background-color: #eeeeee;border-radius: 20px 20px 20px 20px;">
            <div class="col-xs-12 form-signin block-center" style="margin-top:5%;">
                <h1 class="h1 mb-3 font-weight-normal" style="text-align: center">ログイン・登録</h1>
                <div class="social-login">
                    <div id="my-signin2" onclick="ClickLogin();"></div>
                    <script src="https://apis.google.com/js/platform.js?onload=renderButton"></script>
                </div>
            </div>
            <script src="/resources/js/home/autoLoginBlocker.js?reload"></script>

            <div class="row" style="margin-top: 20%;">
                <script src="/resources/js/home/beforeLogin.js"></script>
                <style>

                    .RollDiv {
                        margin: 0 auto;
                        width: 75%;
                        height: 300px;
                        overflow: hidden;
                    }

                    .RollDiv > div {
                        overflow: hidden;
                        height: 300px;
                        width: 10000px;
                    }

                    .RollDiv > div > a {
                        float: left;
                        display: block;
                    }

                    .RollDiv > div > a > img {
                        width: 150px;
                        height: 150px;
                        margin-right: 10px;
                    }
                </style>
                <div class="RollDiv">
                    <div>
                        <c:forEach items="${previews}" var="preview">
                            <a class="hover-fade"
                               href="javascript:createModal('/feed/view/?feed_id=${preview.feed_id}')">
                                <img src="<spring:url value='/userPicture/${preview.preview}'/>"
                                     style="background-color: white;border: solid grey 1px; margin-left: 20px;"/>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </c:when>

    <c:otherwise> <!-- 로그인 후 -->
        <!-- 배너파트 -->
        <link rel="stylesheet" href="/resources/css/home/bannerSkeleton.css">
        <link rel="stylesheet" href="/resources/css/universal/pagination.css">
        <script src="/resources/js/home/pagination.js"></script>
        <div class="banner" style="background-image:url('/resources/images/home/banner.jpg'); margin-bottom: 50px;">
            <div class="container">
                <div class="banner-text">
                    <div class="banner-heading">
                        フォローの最近のフィード
                    </div>
                    <div class="banner-sub-heading">
                        一ヶ月間のフィードです。
                    </div>
                </div>
            </div>
        </div>
        <!-- 피드 프리뷰 파트 -->
        <div class="container">
            <div class="row">
                <div class="list-group gallery">
                    <c:forEach items="${previews}" var="preview">
                        <div class='col-sm-4 col-xs-6 col-md-2 col-lg-2 hover-fade'>
                            <a class="thumbnail" rel="ligthbox"
                               href="javascript:createModal('/feed/view/?feed_id=${preview.FEED_ID}');">
                                <img class="img-responsive" alt=""
                                     src="<spring:url value='/userPicture/${preview.PREVIEW}'/>"
                                     style="width: 150px; height:150px;"/>
                                <div class='text-right'>
                                    <small class='text-muted'>${preview.NICKNAME}</small>
                                </div> <!-- text-right / end -->
                            </a>
                        </div>
                        <!-- col-6 / end -->
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- 네비게이션 파트 -->
        <div class="row center-block text-center">
            <div class="center-block">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link"
                               href="javascript:pagenation('${navi.currentPage-1}', '${navi.totalPageCount}')"
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
                                           href="javascript:pagenation('${count}', '${navi.totalPageCount}')">${count}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <li class="page-item">
                            <a class="page-link"
                               href="javascript:pagenation('${navi.currentPage+1}', '${navi.totalPageCount}')"
                               aria-label="Next">
                                <span aria-hidden="true">»</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

            <style>
                .pagination > li > a {
                    border-radius: 50% !important;
                    margin: 0 5px;
                    background-color: white;
                }
            </style>
        </div>
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
