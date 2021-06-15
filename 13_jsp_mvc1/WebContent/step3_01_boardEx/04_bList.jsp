<%@page import="step3_00_boardEx.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="step3_00_boardEx.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04_bList</title>
</head>
<body>
	<h1>게시글 보기</h1>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		<%
			ArrayList<BoardDTO> boardList = BoardDAO.getInstance().getAllBoard();
			for(int i=0; i<boardList.size(); i++) {
		%>
				<tr>
					<td><%=boardList.get(i).getNum()%></td>
					<td><a href="05_bInfo.jsp?num=<%=boardList.get(i).getNum()%>">
					    <%=boardList.get(i).getSubject()%>
					    </a>
					</td>
					<td><%=boardList.get(i).getWriter()%></td>
					<td><%=boardList.get(i).getRegDate()%></td>
					<td><%=boardList.get(i).getReadCount()%></td>
				</tr>
		<%
			}
		%>
		<tr align="right">
			<td colspan="5">
				<input type="button" value="글쓰기" onclick="location.href='02_bWrite.jsp'">
			</td>
		</tr>
	</table>
</body>
</html>