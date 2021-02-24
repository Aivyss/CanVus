<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/23/2021
  Time: 12:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- 네비바 -->
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/user/bookmark/bookmarkSkeleton.css">

<!-- 테스트 구역 -->
${historyRecordCount}
${bookmarkFolderAbstractList}

<!-- 폴더링 -->
<div class="container-fluid d-flex justify-content-center center-block">
    <!-- History Folder -->
    <div class="col-xs-3 history-folder">
        <ul class="list-group list-group-bm mt-5 text-white">
            <div class="col-lg-8">
                <li class="list-group-item list-group-item-bm d-flex justify-content-between align-content-center">
                    <div class="d-flex flex-row">
                        <div class="row">
                            <div class="col-xs-6">
                                <img src="https://img.icons8.com/color/100/000000/folder-invoices.png" width="80"/>
                            </div>
                        </div>
                        <div class="ml-2">
                            <h3>History</h3>
                            <div class="about about-bm">
                                <h6>${historyRecordCount} Feeds</h6>
                            </div>
                        </div>
                    </div>
                </li>
            </div>
        </ul>
    </div>

    <!-- Bookmarks -->
    <c:forEach items="${bookmarkFolderAbstractList}" var="oneItem">
        <div class="col-xs-3 bookmark-folders" id="${oneItem.folder_id}">
            <ul class="list-group list-group-bm mt-5 text-white">
                <div class="col-lg-8">
                    <li class="list-group-item list-group-item-bm d-flex justify-content-between align-content-center">
                        <div class="d-flex flex-row">
                            <div class="row">
                                <div class="col-xs-6">
                                    <img src="https://img.icons8.com/color/100/000000/folder-invoices.png" width="80" />
                                </div>
                                <div class="col-xs-6">
                                    <div class="check"> <input type="checkbox" name="a"> </div>
                                </div>
                            </div>
                            <div class="ml-2">
                                <h3>${oneItem.folder_name}</h3>
                                <div class="about about-bm">
                                    <h6>${oneItem.feed_count} Feeds</h6>
                                </div>
                            </div>
                        </div>
                    </li>
                </div>
            </ul>
        </div>
    </c:forEach>
</div>


</body>
</html>
