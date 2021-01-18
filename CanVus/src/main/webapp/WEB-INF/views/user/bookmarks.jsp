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

<!-- 메인 상단 검색창 -->
<table>
			<tr class ="head">
				<td >
					<img id="logo" alt="로고" src="/resources/images/CanVus.PNG" onclick ="gotohome()">
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

	<!-- 북마크 시작 -->
	<div class= "tle">
		<table>
			<!-- 상단 북마크 표시 절 -->
			<tr class ="box">
				<td width =480px height = 70px align = center >
					<span class ="A"> Bookmarked </span>
				</td>	 
			</tr>
			
				<!-- 폴더 생성 버튼 -->
				<table>
					<tr>
						<img  id = "plus" alt="더하기" src="/resources/images/plus.png" width = 60px height = 60px >					
					</tr>
				<!-- 저장되어 있는 폴더들 -->
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
	
	<!-- 화면에 보여줄 폴더 (default = History) -->	
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
								<td>꼬부기</td>
							</tr>
							<tr class = "box" align = center>	
								<td>파이리</td>
							</tr>
							<tr class = "box" align = center>	
								<td>피카츄</td>
							</tr>
							<tr class = "box" align = center>	
								<td>이상해씨</td>
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
								<td>꼬부기</td>
							</tr>
							<tr class = "box" align = center>	
								<td>파이리</td>
							</tr>
							<tr class = "box" align = center>	
								<td>피카츄</td>
							</tr>
							<tr class = "box" align = center>	
								<td>이상해씨</td>
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
								<td>꼬부기</td>
							</tr>
							<tr class = "box" align = center>	
								<td>파이리</td>
							</tr>
							<tr class = "box" align = center>	
								<td>피카츄</td>
							</tr>
							<tr class = "box" align = center>	
								<td>이상해씨</td>
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
								<td>꼬부기</td>
							</tr>
							<tr class = "box" align = center>	
								<td>파이리</td>
							</tr>
							<tr class = "box" align = center>	
								<td>피카츄</td>
							</tr>
							<tr class = "box" align = center>	
								<td>이상해씨</td>
							</tr>		
						</table>
						</td>
					
							
							
		</table>
	</div>				


</body>
</html>