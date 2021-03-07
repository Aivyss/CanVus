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
    <title>Bookmark Folders</title>
</head>
<body>
<!-- hidden values -->
<input type="hidden" value="${sessionScope.userId}" id="user_id">
<!-- 네비바 -->
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/bookmark/bookmarkSkeleton.css?reload">
<script src="/resources/js/bookmark/bookmark.js?aaaaasSibal"></script>

<!-- Body area -->
<div class="container-fluid d-flex justify-content-center center-block">
    <!-- bookmark creation part -->
    <div class="row text-center">
        <div class="row center-block" style="margin-top:50px; margin-bottom:50px;">
            <button class="btn btn-primmary"
                    id="make-bookmark-btn"
                    data-toggle="modal"
                    data-target="#createFolderForm"
                    style="border-radius: 20px 20px 20px 20px;">
                フォルダーを作る！
            </button>
        </div>

        <!-- 북마크 생성 모달파트 -->
        <div class="modal fade" tabindex="-1" role="dialog" id="createFolderForm">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title">あなただけのブックマークを作りましょう。</h2>
                    </div>
                    <div class="modal-body">
                        <p>ちなみに、既存にあるフォルダーと同じ名前で作れません。</p>
                        <div class="form-group">
                            <label for="new-folder-name"></label>
                            <input id="new-folder-name" type="text" class="form-control" placeholder="フォルダ名">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                        <button type="button" class="btn btn-primary" id="execute-folder-making">決定</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- folder container -->
    <div class="row" id="folder-container">
        <!-- History Folder part -->
        <div class="col-xs-3 history-folder">
            <ul class="list-group list-group-bm mt-5 text-white">
                <div class="col-lg-8">
                    <li class="list-group-item list-group-item-bm d-flex justify-content-between align-content-center" style="background-color: #ffffff; border: solid black 1px; border-radius: 10px 10px 10px 10px;">
                        <div class="d-flex flex-row">
                            <div class="row">
                                <div class="col-xs-6">
                                    <img src="/resources/images/defaults/folderDefault.png" width="80"/>
                                </div>
                            </div>
                            <div class="ml-2">
                                <h3 style="color: black">History</h3>
                                <div class="about about-bm">
                                    <h6 style="color: black">${historyRecordCount} Feeds</h6>
                                </div>
                            </div>
                        </div>
                    </li>
                </div>
            </ul>
        </div>

        <!-- Bookmarks -->
        <c:forEach items="${bookmarkFolderAbstractList}" var="oneItem">
            <div class="col-xs-3" id="folder-container-${oneItem.folder_id}">
                <ul class="list-group list-group-bm mt-5 text-white">
                    <div class="col-lg-8 bookmark-folders" id="${oneItem.folder_id}">
                        <li class="list-group-item list-group-item-bm d-flex justify-content-between align-content-center" style="background-color: #ffffff; border: solid black 1px; border-radius: 10px 10px 10px 10px;">
                            <div class="d-flex flex-row">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <img src="/resources/images/defaults/folderDefault.png" width="80"/>
                                    </div>
                                    <div class="col-xs-1" style="left: 70px">
                                        <a href="#" class="folder-delete" id="del-${oneItem.folder_id}"><img src="/resources/images/defaults/deleteButtonDefault.png" width="20px" /></a>
                                    </div>
                                </div>
                                <div class="ml-2">
                                    <h3 style="color: black">${oneItem.folder_name}</h3>
                                    <div class="about about-bm">
                                        <h6 style="color: black">${oneItem.feed_count} Feeds</h6>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </div>
                </ul>
            </div>
        </c:forEach>
    </div>
</div>


</body>
</html>
