<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>
	<h2>회원정보 수정</h2>
	<form method="post" action="06_updatePro.jsp">
		<fieldset>
			<p>아이디: <input type="text" name="id"></p>
			<p>패스워드: <input type="password" name="passwd"></p>
			<p>이름: <input type="text" name="name"></p>
			<p><input type="submit" value="수정하기"></p>
		</fieldset>
	</form>
</body>
</html>