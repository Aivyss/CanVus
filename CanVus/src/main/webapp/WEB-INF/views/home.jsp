<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>Home</title>
    <meta name="google-signin-client_id"
          content="1073968802049-evh62jql0f6gblp8din0t6rqv0sobg17.apps.googleusercontent.com">
    <script defer src="https://apis.google.com/js/platform.js"></script>
</head>

<body>
    <jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
    <c:choose>
        <c:when test="${empty userVO}"> <!-- 로그인 전 -->
            <link rel="stylesheet" href="/resources/css/home/loginSkeleton.css">
            <link rel="stylesheet" href="/resources/css/universal/GallerySkeleton.css">

            <!-- 공간 벌려주기 용 -->
            <div class="container" style="margin-top:20px;"></div>

            <!-- login panel -->
            <div class="container center-block" id="logreg-forms">
                <div class="col-xs-12 form-signin block-center">
                    <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Sign in</h1>
                    <div class="social-login">
                        <div id="my-signin2" onclick="ClickLogin();"></div>
                        <script src="https://apis.google.com/js/platform.js?onload=renderButton"></script>
                    </div>
                </div>
                <script src="/resources/js/home/autoLoginBlocker.js?reload"></script>

                <div class="row" style="margin-top: 200px;">
                    <div class='list-group gallery'>
                        <c:forEach items="${previews}" var="preview">
                            <div class='col-sm-4 col-xs-6 col-md-3 col-lg-3 hover-fade'>
                                <a class="thumbnail " rel="ligthbox" >
                                    <img class="img-responsive" alt="" src="<spring:url value='/userPicture/${preview.preview}'/>" />
                                    <div class='text-right'>
                                        <small class='text-muted'>${preview.nickname1}</small>
                                    </div> <!-- text-right / end -->
                                </a>
                            </div> <!-- col-6 / end -->
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise> <!-- 로그인 후 -->
            <p>로그인 완료. 여기 다시 짤 예정</p>
        </c:otherwise>
    </c:choose>
</body>
</html>
