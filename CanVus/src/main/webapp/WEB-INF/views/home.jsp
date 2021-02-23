<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>Home</title>
    <meta name="google-signin-client_id"
          content="1073968802049-evh62jql0f6gblp8din0t6rqv0sobg17.apps.googleusercontent.com">
    <script defer src="https://apis.google.com/js/platform.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>

<body>
    <jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>
    <c:choose>
        <c:when test="${empty userVO}"> <!-- 로그인 전 -->
            <script src="/resources/js/home/loginMask.js"></script>
            <link rel="stylesheet" href="/resources/css/home/loginMask.css">

            <!--▽ 로그인을 위한 가림패널 ▽ -->
            <div id="mask" style="z-index:100;">
            </div>

            <div id="content_div" style="z-index:150; display:none;">
                <img id="loginLogo" src="/resources/images/home/CanVus.png"> <!-- 나중에 div에 이미지 넣는게 더 나으니 부탁함. -->
                <div>最高の絵を描きましょう。</div>
                <div id="gLogin">
                    <div id="my-signin2" onclick="ClickLogin()"></div>
                </div>
                <script src="https://apis.google.com/js/platform.js?onload=renderButton" defer></script>
            </div>
            <!--▲ 로그인을 위한 가림패널 ▲ -->


            <!-- 플로팅 배너를 위한 div -->
            <div class="header">
                <img class="Logo" src="/resources/images/home/CanVus.png">
                <button class="searchBtn"></button>
                <input type="text" class="searchCntnr">
            </div>


            <h1>테스트란</h1>
            <ul>
                <li><a href="/payment/module">결제 테스트</a></li>
                <li><a href="/user/loginForm">로그인 창으로 이동 테스트</a></li>
                <li><a href="/search/imageSearch">이미지 서칭 테스트</a></li>
            </ul>
            <script src="/resources/js/home/autoLoginBlocker.js"></script>
        </c:when>
        <c:otherwise> <!-- 로그인 후 -->
            <p>로그인 완료. 여기 다시 짤 예정</p>
        </c:otherwise>
    </c:choose>
</body>
</html>
