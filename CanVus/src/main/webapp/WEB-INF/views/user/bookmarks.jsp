<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="/resources/css/bookmarks.css">

<!-- <script src="/resources/js/bookmarkJS.jsp" type="text/javascript"></script> -->

</head>
<body>

<!-- ���� ��� �˻�â -->
<table>
			<tr class ="head">
				<td >
					<img id="logo" alt="�ΰ�" src="/resources/images/CanVus.PNG" onclick ="gotohome()">
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

	<!-- �ϸ�ũ ���� -->
	<div class= "tle">
		<table>
			<!-- ��� �ϸ�ũ ǥ�� �� -->
			<tr class ="box">
				<td width =480px height = 70px align = center >
					<span class ="A"> Bookmarked </span>
				</td>	 
			</tr>
			
				<!-- ���� ���� ��ư -->
				<table>
					<tr>
						<img  id = "plus" alt="���ϱ�" src="/resources/images/plus.png" width = 60px height = 60px >					
					</tr>
				<!-- ����Ǿ� �ִ� ������ -->
					<tr>
						<td class ="buttonMargin">
							<input type ="button" value = "History" class = "folder">
						</td>
						<td class ="buttonMargin">
							<input type ="button" value = "A Folder" class = "folder">
						</td>
						<td class ="buttonMargin">
							<input type ="button" value = "B folder" class = "folder">
						</td>
					</tr>							
				</table>
					
		</table>
		
	</div>
	
	<!-- ȭ�鿡 ������ ���� (default = History) -->	
	<div class= "tle1">
		<table >
					<tr>
						<td class ="buttonMargin">
							<input type ="button" value = "History" class = "folder">
						</td>
					</tr>
					<tr>
						<td>
						<table>
							<tr class = "box">
								<td> 
								<img class="photo" src="/resources/images/sal.png" width = 320px height = 200px onclick="popupNew();">
								</td>
							</tr>
							<tr class = "box">
								<td align = right>
									<img  src="/resources/images/heart.PNG" width = 30px height = 30px > 
								</td>
							</tr>	
							<tr class = "box" align = center>	
								<td>���α�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>���̸�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>��ī��</td>
							</tr>
							<tr class = "box" align = center>	
								<td>�̻��ؾ�</td>
							</tr>		
						</table>
						</td>
						
						<td  class="forpadding">
						<table >
							<tr class = "box">
								<td> 
								<img  src="/resources/images/sal.png" width = 320px height = 200px >
								</td>
							</tr>
							<tr class = "box">
								<td align = right>
									<img  src="/resources/images/heart.PNG" width = 30px height = 30px > 
								</td>
							</tr>	
							<tr class = "box" align = center>	
								<td>���α�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>���̸�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>��ī��</td>
							</tr>
							<tr class = "box" align = center>	
								<td>�̻��ؾ�</td>
							</tr>		
						</table>
						</td>
						
						<td  class="forpadding" >
						<table >
							<tr class = "box">
								<td> 
								<img  src="/resources/images/sal.png" width = 320px height = 200px >
								</td>
							</tr>
							<tr class = "box">
								<td align = right>
									<img  src="/resources/images/heart.PNG" width = 30px height = 30px > 
								</td>
							</tr>	
							<tr class = "box" align = center>	
								<td>���α�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>���̸�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>��ī��</td>
							</tr>
							<tr class = "box" align = center>	
								<td>�̻��ؾ�</td>
							</tr>		
						</table>
						</td>
						
						<td  class="forpadding" >
						<table >
							<tr class = "box">
								<td> 
								<img  src="/resources/images/sal.png" width = 320px height = 200px >
								</td>
							</tr>
							<tr class = "box">
								<td align = right>
									<img  src="/resources/images/heart.PNG" width = 30px height = 30px > 
								</td>
							</tr>	
							<tr class = "box" align = center>	
								<td>���α�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>���̸�</td>
							</tr>
							<tr class = "box" align = center>	
								<td>��ī��</td>
							</tr>
							<tr class = "box" align = center>	
								<td>�̻��ؾ�</td>
							</tr>		
						</table>
						</td>
					
							
							
		</table>
	</div>				


</body>
</html>