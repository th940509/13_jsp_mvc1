<%@page import="step2_00_loginEx.MemberDTO"%>
<%@page import="step2_00_loginEx.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JoinPro</title>
</head>
<body>

	<%
		request.setCharacterEncoding("utf-8");
	
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		
		boolean isFirstMember = MemberDAO.getInstance().insertMember(new MemberDTO(id,pwd,name));          //MemberDAO, DTO *import해야함
		
		if(isFirstMember) {
	%>
			<script>
				alert("You are signed up");
				location.href = "00_main.jsp";
			</script>
	<%
		}
		else {
	%>
			<script>
				alert("try other id");
				history.go(-1);
			</script>
	<%
		}
	
	%>
</body>
</html>