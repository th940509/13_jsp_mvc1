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
</body>
</html>