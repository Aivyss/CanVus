<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
		
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
					<input type="password" id="inputPassword5" name="password" class="form-control" aria-describedby="passwordHelpBlock">
					<div> 
					<input type="button" value= "입력" id = "submitbox" onclick="correctPw()">
					</div>
				</div>
				
					<div>
					
					<script type="text/javascript">
					

					
					function correctPw(){
						var data={}
						data["pwWrttenByUser"]=$("#inputPassword5").val();		
	
						$.ajax({
	
						url : "/drawing/passwordCheck",
						type : "POST",
						dataType : "json",
						contentType : "application/json",
						data : JSON.stringify(data),
						success : function(result) {
							if(result["result"] == "sussces") {
								//TODO 세션스코프에 비번값넣기	
								${sessionScope.pwWrttenByUser}							
							location.href="/drawing/room/?room_Id=";
							
							}else {								

								alret("비밀번호가 틀렸습니다");
								}
						},
						error:function(request,status,error){
						    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						    }					
									
		
						});
					}
					 
</script> 
					<p>ajax로 보내고 일치하면 다시 이페이지 불러와.</p>
					</div>
			</c:when>
			
			<c:otherwise>
				<div>
					<p>본격으로 드로잉창 시작</p>
					${pwWrttenByUser }
					${dbPassword }
				</div>
			</c:otherwise>
		</c:choose>
	</body>
</html>