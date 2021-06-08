<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>
	<h2>회원 탈퇴</h2>
	<form method="post" action="04_deletePro.jsp">
		<fieldset>
			<p>아이디 : <input type="text" name="id"></p>
			<p>패스워드 : <input type="password" name="passwd"></p>
			<p><input type="submit" value="탈퇴하기"></p>
		</fieldset>
	</form>	

</body>
</html>