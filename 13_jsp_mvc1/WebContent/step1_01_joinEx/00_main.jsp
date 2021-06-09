<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	
	# 실습을 위한 데이터 베이스 구성
	
	CREATE DATABASE LOGIN_EX;

	USE LOGIN_EX;
	
	CREATE TABLE MEMBER (
		ID VARCHAR(20),
	    PASSWD VARCHAR(20),
	    NAME VARCHAR(20),
	    JOINDATE DATETIME
	);
	
	SELECT * FROM MEMBER;

 --%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
</head>
<body>
	<p><a href="01_insert.jsp">회원가입</a></p> <!-- <a href="" : ""안의 다른 문서로 이동 -->
	<p><a href="03_delete.jsp">회원탈퇴</a></p>
	<p><a href="05_update.jsp">회원정보 수정</a></p>
	<p><a href="07_list.jsp">회원정보확인</a></p>
</body>
</html>