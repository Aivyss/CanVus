<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2021-03-01
  Time: 오전 1:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Management</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<!-- data table -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/dataTables.bootstrap.min.css">
<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.23/js/dataTables.bootstrap.min.js"></script>
<script src="/resources/js/user/management/management.js"></script>
<!-- CSS part -->
<link rel="stylesheet" href="/resources/css/user/management/management.css">

<div class="container">
    <!-- 프로필 수정 및 자기소개 수정 -->
    <div class="row">
        <div class="col-md-3 col-md-offset-3">
            <input id="edit-profile-btn" type="button" class="btn btn-primmary" value="プロフィールの修正" style="margin-bottom: 20px;

                                                   border-radius: 20px 20px 20px 20px;">
        </div>
        <div class="col-md-3 col-md-offset-3">
            <input id="edit-intro-btn" type="button" class="btn btn-primmary" value="自己紹介の修正" style="margin-bottom: 20px;

                                                   border-radius: 20px 20px 20px 20px;">
        </div>
    </div>

    <div class="row">
        <!-- payment table part -->
        <div class="col-md-5 text-center">
            <div class="row" style="margin: 20px;">
                <h3>課金の履歴</h3>
            </div>
            <div class="row">
                <table id="payment-table" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>支払い</th>
                        <th>ピックセル</th>
                        <th>日時</th>
                        <th>固有番号</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${billList}" var="bill">
                        <tr>
                            <td>${bill.paid_amount}</td>
                            <td>${bill.pixel}</td>
                            <td>${bill.output_date}</td>
                            <td>${bill.merchant_uid}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th>支払い</th>
                        <th>ピックセル</th>
                        <th>日時</th>
                        <th>固有番号</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <div class="col-md-5 col-md-offset-2 text-center">
            <div class="row" style="margin: 20px;">
                <h3>ピックセルの変動</h3>
            </div>
            <div class="row">
                <table id="transaction-table" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <th>差出</th>
                    <th>宛先</th>
                    <th>ピックセル</th>
                    <th>日時</th>
                    <th>Trans. ID</th>
                    </thead>

                    <tbody>
                    <c:forEach items="${trnxList}" var="trnx">
                        <tr>
                            <td>${trnx.sender_nickname}</td>
                            <td>${trnx.receiver_nickname}</td>
                            <td>${trnx.pixels_amount}</td>
                            <td>${trnx.transaction_date}</td>
                            <td>${trnx.transaction_id}</td>
                        </tr>
                    </c:forEach>
                    </tbody>

                    <tfoot>
                    <th>差出</th>
                    <th>宛先</th>
                    <th>ピックセル</th>
                    <th>日時</th>
                    <th>Trans. ID</th>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<!--  -->

<!-- 개인정보 수정모달파트 -->
<div class="modal fade" tabindex="-1" role="dialog" id="edit-profile-modal" style="z-index: 20000;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title">
                    プロフィールを直しています。
                </h1>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row text-center center-block">
                    <img src="./testImage.png" class="img-circle profile-avatar" alt="プロフィール"
                         style="margin:10% 0; width:250px; border: #1266f1 solid 3px; height:250px; background-color:white;"
                         id="photo-preview">
                    <form id="profile-form" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="photo_upload">プロフィール</label>
                            <input type="file" class="form-control-file" id="photo_upload" name="photo_upload"
                                   onchange="readURL(this);" style="margin: 0 25%;">
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                <button type="button" class="btn btn-primary" id="execute-update-profile">修正</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" tabindex="-1" role="dialog" id="edit-intro-modal" style="z-index: 20000;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title">
                    自己紹介を直しています。
                </h1>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h4>直す内容を入力してください。</h4>
                <input type="text" id="intro-text" class="form-control">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">戻る</button>
                <button type="button" class="btn btn-primary" id="execute-update-intro">修正</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
