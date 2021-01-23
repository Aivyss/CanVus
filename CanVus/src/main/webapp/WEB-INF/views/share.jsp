<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="/resources/css/share.css">


</head>


<body>
	
	<jsp:include page="mainMenu.jsp"></jsp:include>

	<table>

			<!-- 메인 최상단 검색창 및 메뉴 -->
			<tr class ="head" >
				<td >
					<img id="logo" alt="로고" src="/resources/images/CanVus.PNG">
				</td>
				<td class ="head">
					<img id ="search" alt="찾기" src="/resources/images/search.png">
				
				</td>
				
				<td class ="head">
					<input type = "text" id = "name" value = "">
				</td>
				
				<td class ="head" width = 130px>
					&nbsp;		 
				</td>
			
				<td class ="head">
					<input type = "button" value = "Discovery" id = "disco">
				</td>
				<td width = 40px>
					&nbsp;
				</td>
				<td class ="head">
					<input type = "button" value = "notification" id = "menu">
				</td>	
				<td width = 40px>
					&nbsp;
				</td>
				<td class ="head">
					<input type = "button" value = "Drawing" id = "menu">
				</td>	
				<td width = 40px>
					&nbsp;
				</td>
				<td class ="head">
					<input type = "button" value = "Profile" id = "menu">
				</td>	
			</tr>			
</table>
	
	<div id = "tle">
	
	<!-- 방 검색창 -->
		<table >
			<tr class ="head">
				<td class ="head"> 
					<img  alt="찾기" src="/resources/images/search.png" width = 60px height = 60px>
				</td>
				<td class ="head">
					<input type = "text" id = "roomSearch" value ="방 제목 검색">
				</td>
			</tr>				
		</table>
	<!-- 생성되어 있는 방 -->	
		<table class ="picture">
	
			<tr>
				<td>
					<table class ="roombox">
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>
				<td>
					<table >
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>
				<td>
					<table class ="roombox">
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>
				<td>
					<table >
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>
			<tr>
				<td>
					<table class ="roomboxb">
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>
				<td>
					<table class="roomboxc">
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>
				<td>
					<table class="roomboxb">
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>
				<td>
					<table class="roomboxc">
						<tr class ="head">
							<td>
								<input type="image" width = 320px height = 200px>
							</td>
						</tr>
						<tr>
							<td > 
								<input type ="button" value = "인원 : 250명" id ="ppl"> 
								<input type ="button" value = "공개/비공개" id = "optio">
							</td>
							<td>
							
						</tr>
						<tr>
							<td class ="head">
								<input id ="painter" type="text" value = "painter1" >
								<input id ="painter" type="text" value = "painter2" >
								<input id ="painter" type="text" value = "painter3" >
								<input id ="painter" type="text" value = "painter4" >	
							</td>
						<tr>
							<td>
								<input type="text" value =" 방 제목 : 입력 " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>	
		</table>
	</div>
	
	
	
	


</body>
</html>