<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>

<style type="text/css">

.mainLogo{
	font-size: 35px;
	padding-left: 20px;
	padding-right: 150px;
	padding-top: 30px;
	text-decoration: none;
	
}

.search{
	width: 500px;
	height: 20px; 
	background-color: #efefef; 
    border-radius: 6px; 
    border: 1px solid #dedede; 
    padding: 10px; 
    margin-top: 3px; 
    font-size: 0.9em; 
    color: #3a3a3a; 
}

input:focus, textarea:focus{ 
    border: 1px solid #97d6eb; 
} 

.tab{
	font-size: 25px;
	float: right;
	padding-left: 50px;
	padding-right: 20px;
	padding-top: 15px;
	text-decoration: none;
}

.myTable{
	
	margin-right: 0px;
}

.profileImg{
	width: 360px;
	height: 310px;
	margin-left: 210px;
}

.update{
	padding-right: 160px;
	
}

.button{
	width: 120px;
	height: 100px;
	margin-left: 70px;
	margin-right: 70px;

}

.myInformation{
	padding-left: 150px;
}

.people{
	text-align: center;
	font-size: 25px;
}

.setText{
	margin-left: 150px;
	margin-top: 20px;
}

.boardTable{
	margin-top: 30px;
}

.boardImg{
	width: 290px;
	height: 290px;
	cursor: pointer;
	padding-left: 135px;
	padding-top: 20px;
}

.like{
	width: 30px;
	height: 30px;
	cursor: pointer;
	float: right;
	padding-bottom: 40px;
}

.popUp{
	position: absolute;
	left: 50%;
	top: 50%;
	z-index: 5;
	transform: translate(-50%,-50%);
	width: 500px;
	height: 500px;
	box-shadow: 0 0 10px rgba(0,0,0,0.5);
	border-radius: 5px;
	text-align: right;
	padding: 15px;
	box-sizing: border-box;
	opacity: 0;
	transition: all 0.5s;
}

a{
	text-decoration: none;
}
 .popUp close{
	color: gray;
	text-decoration: none;
}
.popUp:target {
	opacity: 1;
}
.popUp:target + dim{
	opacity: 1;
	z-index: 2;
}

.dim{
	position: absolute;
	left: 0;
	top: 0;
	z-index: -1;
	width: 100%;
	height: 100%;
	background: rgba(0,0,0,0);
	opacity: 0;
	transition: all 0.5s;
}   
    



</style>




</head>
<body>
	${bundle}
	<jsp:include page="../mainMenu.jsp"></jsp:include>
	<!-- 메인로고 >> 클릭시 홈으로 -->	
	<a href="/" class="mainLogo">CanVus</a>
	
	<!-- 전체 검색 텍스트 창 -->
	<input type="text" class="search">
	
	<!-- 오른쪽 상단 메뉴 탭들 -->
	<a href="" class="tab">Profile</a>
	<a href="" class="tab">Drawing</a>
	<a href="" class="tab">Share</a>
	<a href="" class="tab">Notification</a>
	<a href="/discovery/discoveryList" class="tab">Discovery</a>
	<br><br><br>
	
	<!-- 내 프로필 이미지 -->	
	<img class="profileImg" align="left" alt="프로필" src="/resources/images/순두부.png">
	
	<!-- 프로필 이미지 수정 float창 -->		
	<a href="#pop1" class="update">수정</a>
				 <div class="popUp" id="pop1">
					<a href="#close">닫기</a>
				</div>
				<div class="dim"></div>
	
	<!-- 내 정보, 소개글 테이블 -->
	<table class="myInformation">
		<tr>
			<td>
				<input type="button" value="Following" class="button">
			</td>
			<td>
				<input type="button" value="Follower" class="button">
			</td>
			<td>
				<input type="button" value="Feeds" class="button">
			</td>
			<td>
				<input type="button" value="누적픽셀" class="button">
			</td>
		</tr>
		
		<tr>
			<td id="following" class="people">135명</td>
			<td id="follower" class="people">135명</td>
			<td id="feeds" class="people">26개</td>
			<td id="pixels" class="people">3000px</td>
		</tr>
	</table>
	
	<textarea rows="14" cols="142" class="setText"></textarea>
	
	<!-- 게시글 전체 테이블 -->
	<table class="boardTable">
		<tr>
			<td>
				<!-- 게시글 한개 테이블 -->
				<table>
					<tr>
						<td><img class="boardImg" alt="게시글 이미지" src="/resources/images/순두부.png" ></td>
					</tr>
					<tr>
						<td><img class="like" alt="좋아요" src="/resources/images/빈하트.png"></td>
					</tr>
				</table>
			</td>
			<td>
				<!-- 게시글 한개 테이블 -->
				<table>
					<tr>
						<td><img class="boardImg" alt="게시글 이미지" src="/resources/images/순두부.png" ></td>
					</tr>
					<tr>
						<td><img class="like" alt="좋아요" src="/resources/images/빈하트.png"></td>
					</tr>
				</table>
			</td>
			<td>
				<table>
					<tr>
						<td><img class="boardImg" alt="게시글 이미지" src="/resources/images/순두부.png" ></td>
					</tr>
					<tr>
						<td><img class="like" alt="좋아요" src="/resources/images/빈하트.png"></td>
					</tr>
				</table>
			</td>
			<td>
				<!-- 게시글 한개 테이블 -->
				<table>
					<tr>
						<td><img class="boardImg" alt="게시글 이미지" src="/resources/images/순두부.png" ></td>
					</tr>
					<tr>
						<td><img class="like" alt="좋아요" src="/resources/images/빈하트.png"></td>
					</tr>
				</table>
			</td>
		</tr>
		
		<!-- 게시글 줄 바꿈 -->
		<tr>
			<td>
				<!-- 게시글 한개 테이블 -->
				<table>
					<tr>
						<td><img class="boardImg" alt="게시글 이미지" src="/resources/images/순두부.png" ></td>
					</tr>
					<tr>
						<td><img class="like" alt="좋아요" src="/resources/images/빈하트.png"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	
	
	


	
</body>
</html>