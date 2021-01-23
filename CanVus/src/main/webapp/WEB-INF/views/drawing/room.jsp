<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<c:choose>
			<c:when test="${empty pwWrttenByUser && dbPassword != null}">
				<div>
					<p>비밀번호를 입력하세요</p>
					<input type="password">
					<p>ajax로 보내고 일치하면 다시 이페이지 불러와.</p>
				</div>
			</c:when>
			
			<c:otherwise>
				<div>
					<p>본격으로 드로잉창 시작</p>
				</div>
			</c:otherwise>
		</c:choose>
	</body>
</html>