<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
<style>
#inputPassword5 {
	margin-right : 30px;
	margin-left : 30px;
	width :500px;
}

#passwordsetting {
	
	
	position : absolute;
	top:50%;
	left :50%;
	text-align : center;

}

#submitbox{

	text-align : center;
}

</style>		
		
	</head>
	
	<body data-spy="scroll" data-target="#header">
    <!--Start Hedaer Section-->
    <jsp:include page="/WEB-INF/views/mainMenu.jsp"></jsp:include>
    
		<c:choose>
			<c:when test="${empty pwWrttenByUser && dbPassword != null}">
					
				<div class="row g-3 align-items-center" id ="passwordsetting">
			 		<label for="inputPassword5" class="form-label">Password</label>
					<input type="password" id="inputPassword5" class="form-control" aria-describedby="passwordHelpBlock">
					<div> 
					<input type="submit" value= "입력" id = "submitbox">
					</div>
				</div>
				
					<div>
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