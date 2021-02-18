<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>\
<!-- 코어태그 사용을 위한 tablig -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 로컬 파일을 불러오기 위한 taglib -->
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
    ${bundle}
    <c:forEach items="${bundle}" var="oneFeed">
        <div class="row">
            <div class="col-sm-6 col-md-4" style="width: 250px; height:250px; margin:0px">
                <div class="thumbnail" style="width:100%; height:100%;">
                    <img src="<spring:url value='/userPicture/${oneFeed.pictures[0]}'/>" style="height:100%; width:100%; margin:0px">
                    <div class="caption" style="position: absolute; left:10px; top: 200px;">
                        <p><a href="#" class="btn btn-primary" role="button">Like</a>
                        </p></div>
                </div>
            </div>
        </div>
    </c:forEach>

</body>
</html>