<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02_bWrite</title>
<body>
	<form action="03_bWritePro.jsp" method="post">
		<h2>게시글 쓰기</h2>
		<table style="width: 700px;" border="1">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
			<tr>
				<td>작성자</td>
				<td><input type="text" id="writer" name="writer" /></td>
			</tr>
			<tr >
				<td>제목</td>
				<td><input type="text" id="subject" name="subject" /></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="email" id="email" name="email" /></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="password" name="password" /></td>
			</tr>
			<tr>
				<td align="center">글내용</td>
				<td><textarea  rows="10" cols="50" id="content" name="content" ></textarea></td>
			</tr>
			</table>
			<p>
				<input type="submit" value="글쓰기" />
				<input type="button" onclick="location.href='04_bList.jsp'" value="전체게시글보기">
			</p>
	</form>
</body>
</html>