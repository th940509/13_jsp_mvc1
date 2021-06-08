<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPro</title>
</head>
<body>
	<%-- 
	
		# 데이터 베이스 연동 방법 
		
		1) mysql_connector.jar파일을 WEB-INF안 폴더의 lib에 넣는다. ( 처음셋팅할때 1번만 )
		2) Class.forName("com.mysql.cj.jdbc.Driver"); 을 작성한다. ( 외울필요x , 인터넷에서 복붙o )
		3) DriverManager의 getConnection(db연결정보,연결id,연결password) 메소드를 통하여서 Connection 객체를 생성한다.
		4) 쿼리문을 작성하여 선처리문 객체를 생성한다.
		5) 선처리문 객체를사용하여 쿼리를 웹에서 실행한다.
		
		
		
		# 쉽게 요약한 연동 방법
		
		1) mysql_connector.jar 파일을 lib폴더에 넣는다.
		2) Class.forName 작성
		3) Connection 객체를 작성
		4) Connection 객체로 PrepareStatement 객체를 생성한 후 쿼리문을 실행
		
	
	--%>
	<%
		request.setCharacterEncoding("utf-8");
	
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
		
		// 데이터베이스를 연결하기 위한 객체    *import 해야함.
		Connection conn = null;
		
		// 쿼리문을 실행하기 위한 객체   *import 해야함.
		PreparedStatement pstmt = null;
		
		try{
			// DB 연결 정보 >   "jdbc:mysql://연결DB서버주소:프로토콜번호/DB명/시간동기화"
			String jdbcUrl = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			// DB 연결 계정
			String dbId    = "root";
			// DB 연결 비밀번호
			String dbPass  = "1234";
			
			// forName 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// 데이터 베이스 연동  *import 해야함.
			conn = DriverManager.getConnection(jdbcUrl , dbId , dbPass);
			
			// 선처리문 쿼리 작성
			String sql = "insert into member values(?,?,?,now())";
			
			// 선처리문 쿼리문 완성
			pstmt = conn.prepareStatement(sql);	// "insert into member values(?,?,?,now())";    /  int일 경우 setInt
			pstmt.setString(1, id);				// "insert into member values(id,?,?,now())";
			pstmt.setString(2, passwd);			// "insert into member values(id,passwd,?,now())";
			pstmt.setString(3, name);			// "insert into member values(id,passwd,name,now())";
			
			// 쿼리문 실행
			pstmt.executeUpdate(); 
			
			// executeUpdate(): insert, update, delete 문 실행 메서드
			// executeQuery(): select문 실행 메서드
			
	%>
		<script>
			alert("회원가입 되었습니다");
			// location.href = "url";    > url로 페이지를 이동한다.
			location.href="00_main.jsp";
		</script>
	<%
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			//데이터 베이스 연동 종료
			pstmt.close();
			conn.close();
		}
	%>
</body>
</html>