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
    <title>Title</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
<!-- data table -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/dataTables.bootstrap.min.css">
<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.23/js/dataTables.bootstrap.min.js"></script>
<script src="/resources/js/user/pixelManagement/pixelManagement.js"></script>

<div class="container">
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
</body>
</html>
