<%--
  Created by IntelliJ IDEA.
  User: hklei
  Date: 2/19/2021
  Time: 2:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>

    <!-- 태그 검색 케이스 -->
    ${tag}
    ${feedBundle}

    <div></div>

    <!-- 닉네임 검색 케이스 -->
    ${nickname}
    ${profile}
    ${feedBundle}
</body>
</html>
