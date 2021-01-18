<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입 페이지 테스트</h1>
	<form action="/user/signupSubmit" method="post">
		토큰히든 <input type="hidden" name="idToken" value="${idToken }"> <br>
		닉네임 <input type="text" name="nickname"> <br>
		자기소개 <input type="text" name="introduction"> <br>
		프로필 나중에하자 힘들다
		<input type="submit" value="가입">
	</form>
	<script type="text/javascript">
	</script>
</body>
</html>