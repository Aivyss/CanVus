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

			<!-- ���� �ֻ�� �˻�â �� �޴� -->
			<tr class ="head" >
				<td >
					<img id="logo" alt="�ΰ�" src="/resources/images/CanVus.PNG">
				</td>
				<td class ="head">
					<img id ="search" alt="ã��" src="/resources/images/search.png">
				
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
	
	<!-- �� �˻�â -->
		<table >
			<tr class ="head">
				<td class ="head"> 
					<img  alt="ã��" src="/resources/images/search.png" width = 60px height = 60px>
				</td>
				<td class ="head">
					<input type = "text" id = "roomSearch" value ="�� ���� �˻�">
				</td>
			</tr>				
		</table>
	<!-- �����Ǿ� �ִ� �� -->	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
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
								<input type ="button" value = "�ο� : 250��" id ="ppl"> 
								<input type ="button" value = "����/�����" id = "optio">
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
								<input type="text" value =" �� ���� : �Է� " id ="roomName">	
							</td>
						</tr>						
					</table>
				</td>	
		</table>
	</div>
	
	
	
	


</body>
</html>