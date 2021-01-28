<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/js/style.css">
<script src="/resources/js/Classic/Color.Picker.Classic.js"
	type="text/javascript"></script>
<script src="/resources/js/Classic/Color.Space.js"
	type="text/javascript"></script>
<script src="/resources/js/Classic/viewpalette.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/resources/js/fabric/dist/fabric.js"></script>
<!-- <script src="node_modules/fabric-history/src/index.js"></script> -->

</head>

<body>
	<jsp:include page="/WEB-INF/views/mainMenu.jsp"></jsp:include>
	<c:choose>
		<c:when test="${empty pwWrttenByUser && dbPassword != null}">
			<div>
				<p>비밀번호를 입력하는 창 만들기</p>
				<p>ajax로 보내고 일치하면 다시 이페이지 불러와.</p>
			</div>
		</c:when>

		<c:otherwise>
			<div>
				<p>본격으로 드로잉창 시작</p>
			</div>

			<div>
				<div>Drawing Page</div>

			</div>
			<div>
				<span>CanVus</span> 
				<a>올리기</a> 
				<a>저장</a> 
				<a>뒤로</a> 
				<a>앞으로</a>
			</div>
			<div class="set">
				<div class="layers">
					<!-- <canvas class="background" width="400" height="400"></canvas> -->
					<canvas class="canvas" id="canvas" width="400" height="400"></canvas>
				</div>
				<div class="buttons">
					<button id="eraser">eraser</button>
					<button id="drawer">drawer</button>
					<button id="red">red</button>
					<input type="button" value="패턴변화" onclick="changeBrush();">
					<input type="button" value="히스토리" onclick="getHistory();">
					<button id="selection">selection</button>
					<button id="stringify">stringify</button>
					<button id="removal">removal</button>
					<button id="recover">recover</button>
				</div>
				<div class="rangeBar">
					<input type="range" max="1" min="0.1" step="0.05" value="1"
						id="opacity"> <input type="range" max="30" min="1"
						step="1" value="5" id="thickness">
				</div>
			</div>
			<script src="/resources/js/app.js"></script>
		</c:otherwise>
	</c:choose>
</body>
</html>