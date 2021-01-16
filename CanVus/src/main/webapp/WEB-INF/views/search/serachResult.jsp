<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
		<!-- 작성자: 이한결, 작성일:2021.01.13 수정 필요시 연락. -->
		<script type="text/javascript">
			function moreContent (id, cnt) {
				var list_length = $(`.${id}.preview`).length;
				var aname = id+"btn"
			}
		</script>
	</head>
	
	<body>
		<!-- 작성자: 이한결, 작성일:2021.01.13 수정 필요시 연락. -->
		<form id="searchTxtForm">
			<input type="hidden" name="viewCount" id="viewCount" value="0">
			<input type="hidden" name="startCount" id="startCount" value="0">
		
			<div class="list">
				<c:forEach items="${resultList }" var="resultDTO" varStatus="status">
					<div id="moreList">
						<div class="preview">
							------------------------------------ <br>
							<span>${resultDTO.PICTURE }</span>
							<span>${resultDTO.FEED_ID }</span>
							<span>${resultDTO.USER_ID1 }</span>
							<span>${resultDTO.USER_ID2 }</span>
							<span>${resultDTO.USER_ID3 }</span>
							<span>${resultDTO.USER_ID4 }</span>
							------------------------------------ <br>
						</div>
					</div>
				</c:forEach>
			</div>
			<div id="moreBtnDiv" align="center">
				<a id="moreBtna" href="javascript:moreContent('moreList', 10)">더보기</a>
			</div>
		</form>
	</body>
</html>