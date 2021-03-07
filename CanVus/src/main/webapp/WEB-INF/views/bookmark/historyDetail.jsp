<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/26/2021
  Time: 14:18 AM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>History</title>
    <script>
        // 페이지에서 쓰일 전역변수 셋 히스토리는 폴더번호가 아니므로 대강 넣음.
        const folder_id = "";
    </script>
    <link rel="stylesheet" href="/resources/css/universal/GallerySkeleton.css">
    <link rel="stylesheet" href="/resources/css/bookmark/bookmarkDetailSkeleton.css">
    <style>
        .pagination > li > a {
            border-radius: 50% !important;
            margin: 0 5px;
            background-color: white;
        }
    </style>

</head>
<body>
<!-- 네비파트 -->
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>

<!-- pageination JS -->
<script src="/resources/js/bookmark/pagenation.js?reload"></script>

<div class="container-fluid">
    <div class="col-sm-12 center-block" style="margin-top:20px;">
        <!-- 피드 번들 파트-->
        <div class="row center-block feed-box">
            <div class="col-xs-8 col-sm-2 bookmark_name">
                <img class='navLogo' src="/resources/images/defaults/folderDefault.png" alt="">
                <div class="ml-2">
                    <h3 style="color: black">History</h3>
                    <div class="about about-bm">
                        <h6 style="color: black">${totalFeedCount} Feeds</h6>
                    </div>
                </div>
            </div>

            <div class='list-group gallery'>
                <c:forEach items="${historyFeedList}" var="oneFeed" varStatus="status">
                    <div class='col-sm-4 col-xs-6 col-md-2 col-lg-2 hover-fade'>
                        <a class="thumbnail" rel="ligthbox" href="javascript:createModal('/feed/view/?feed_id=${oneFeed.feed_id}')">
                            <img class="img-responsive" alt="" src="<spring:url value='/userPicture/${oneFeed.preview}'/>"
                                 style="width: 150px; height:150px;" />
                            <div class='text-right'>
                                <small class='text-muted'>${oneFeed.nickname}</small>
                            </div> <!-- text-right / end -->
                        </a>
                    </div> <!-- col-6 / end -->
                </c:forEach>
            </div>
        </div>

        <!-- 페이지네이션 파트 -->
        <div class="row center-block text-center">
            <div class="center-block">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="javascript:pagenation('${pageNav.currentPage-1}', '${pageNav.totalPageCount}')" aria-label="Previous">
                                <span aria-hidden="true">«</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <c:forEach begin="${pageNav.startPageGroup}" end="${pageNav.endPageGroup}" var="count">
                            <c:choose>
                                <c:when test="${count == pageNav.currentPage}">
                                    <li class="page-item active"><a class="page-link" href="#">${count}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <a class="page-link" href="javascript:pagenation('${count}', '${pageNav.totalPageCount}')">${count}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <li class="page-item">
                            <a class="page-link" href="javascript:pagenation('${pageNav.currentPage+1}', '${pageNav.totalPageCount}')" aria-label="Next">
                                <span aria-hidden="true">»</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- feed view overlay -->
<div id="feed-overlay" class="modal fade" tabindex="-1" role="dialog">
    <!-- 이곳에 피드를 불러온다. -->
</div>
<script src="/resources/js/universal/feed.js?reload"></script>
<script src="/resources/js/universal/modal.js?reload"></script>
</body>
</html>
