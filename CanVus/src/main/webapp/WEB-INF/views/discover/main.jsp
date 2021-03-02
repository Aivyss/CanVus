<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Discovery</title>
    <link rel="stylesheet" href="/resources/css/universal/gallarySkeleton.css">
    <link rel="stylesheet" href="/resources/css/discover/pageTab.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<script src="/resources/js/discover/discover.js"></script>

${tagList}
<div class="container-fluid">
    <div class="col-md-1"></div>
    <div class="col-md-10">
        <div class="row">
            <div role="tabpanel">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist" id="taglist">
                    <li role="presentation" class="active" id="tab-trending">
                        <a aria-controls="CreatePage" role="tab" data-toggle="tab"
                           id="tab-a-trending">#trending</a>
                    </li>
                    <c:forEach items="${tagList}" var="tag">
                        <li role="presentation" class="" id="tab-${tag}">
                            <a aria-controls="${tag}" role="tab" data-toggle="tab"
                               id="tab-a-${tag}">${tag}</a>
                        </li>
                    </c:forEach>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content center-block" id="tabPanes">
                    <div role="tabpanel"
                         class="tab-pane figure figure_bg figure_bg_light center-block in active"
                         id="pane-trending">
                    </div>
                    <c:forEach items="${tagList}" var="tag">
                        <div role="tabpanel"
                             class="tab-pane figure figure_bg figure_bg_light center-block"
                             id="pane-${tag}">
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-1"></div>
</div>

<!-- feed view overlay -->
<div id="feed-overlay" class="modal fade" tabindex="-1" role="dialog">
    <!-- 이곳에 피드를 불러온다. -->
</div>
<script src="/resources/js/feed/feed.js?reload"></script>
<script src="/resources/js/universal/modal.js"></script>
</body>
</html>