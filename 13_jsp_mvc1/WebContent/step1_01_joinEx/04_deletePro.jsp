<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("utf-8");
	
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		Connection conn = null;
		
		PreparedStatement pstmt = null;
		
		//select문의 결과를 저장할 객체  *import 해야함.  / select가 아닐경우 변수에 담을 필요가 없음.
		ResultSet rs = null;
		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String dbId    = "root";
			String dbPass  = "1234";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl , dbId , dbPass);
			
			pstmt = conn.prepareStatement("select * from member where id=? and passwd=?");
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // rs.next() : 조회된 1줄의 쿼리문이 있으면 true가 반환된다.  / 여러줄일 경우 while 문에 넣기
				pstmt = conn.prepareStatement("delete from member where id=?");
				pstmt.setString(1,id);
				pstmt.executeUpdate();
		%>
			<script>
				alert("회원탈퇴 되었습니다.")
				location.href="00_main.jsp";
			</script>
		<%
			}
			else {
		%>
			<script>
				alert("아이디와 비밀번호를 확인해주세요")
				history.go(-1); // 한페이지 전으로 이동하는 메서드 
				                // history.back();
			</script>
		<%
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			rs.close();
			pstmt.close();
			conn.close();
		}
	
	%>
</body>
</html>