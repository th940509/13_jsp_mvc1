<%@page import="java.util.ArrayList"%>
<%@page import="step4_00_boardEx.BoardDTO"%>
<%@page import="step4_00_boardEx.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04_bList</title>
</head>
<style>
	ul {
	    list-style:none;
	    margin:0;
	    padding:0;
	}
	
	li {
	    margin: 0 0 0 0;
	    padding: 0 0 0 0;
	    border : 0;
	    float: left;
	}
</style>
<script>

	function showList() {
		var onePageViewCount = document.getElementById("onePageViewCount").value; 
		var searchKeyword = document.getElementById("searchKeyword").value;
		var searchWord = document.getElementById("searchWord").value;
		location.href="04_bList.jsp?searchKeyword="+searchKeyword+"&searchWord="+searchWord + "&onePageViewCount="+onePageViewCount;
	}
	
</script>
<body>

	<p align="right">
		<input type="button" value="테스트 데이터 생성" onclick="location.href='99_makeDummyData.jsp'">
	</p>

	<% 
	
		request.setCharacterEncoding("utf-8");	
	
		String searchKeyword = request.getParameter("searchKeyword");
		if (searchKeyword == null) {
			searchKeyword = "total";
		}
		
		String searchWord = request.getParameter("searchWord");
		if (searchWord == null) {
			searchWord = "";
		}
		
		String tempCnt = request.getParameter("onePageViewCount"); // onePageViewCount : 한페이지에 보고 싶은 게시물의 갯수
		if (tempCnt == null) {
			tempCnt = "10";	
		}	
		int onePageViewCount = Integer.parseInt(tempCnt);
		
		String tempPageNum  = request.getParameter("currentPageNumber"); // currentPageNumber : 시작하는 페이지 숫자
		if (tempPageNum == null){
			tempPageNum = "1";
		}
		int currentPageNumber = Integer.parseInt(tempPageNum); 
		
		BoardDAO bdao = BoardDAO.getInstance(); 
		int totalBoardCount = bdao.getAllCount(searchKeyword,searchWord); // 전체 게시글 수
		
		
		int startBoardIdx = (currentPageNumber -1) * onePageViewCount; 
		ArrayList<BoardDTO> boardList = bdao.getSearchBoard(searchKeyword, searchWord, startBoardIdx, onePageViewCount);
		//전체 게시글 조회
	%>
	<div align="center" style="padding-top: 100px" >
		<h2> 전체 게시글 보기 </h2>
		<br>
		<table border="1">
			<colgroup>
				<col width="10%">
				<col width="40%">
				<col width="20%">
				<col width="20%">
				<col width="10%">
			</colgroup>
			<tr>
				<td> 
					조회 : <span style="color:red"><%=totalBoardCount %></span>개
				</td>
				<td colspan="4" align="right" >
					<select id="onePageViewCount" onchange="showList()" style="width: 100px; display: inline;">
						<option
							<%
								if (onePageViewCount == 5) {
							%>
									selected
							<% 
								}
							%>
							value="5">5</option>
						<option  
							<%
								if (onePageViewCount == 7) {
							%>
									selected
							<% 
								}
							%>
						value="7" >7</option>
						<option
							<%
								if (onePageViewCount == 10) {
							%>
									selected
							<% 
								}
							%>  
						
						value="10">10</option>
					</select>
				</td>
			</tr>
			<tr align="center">
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
			</tr>
	<% 
		for (int i=0; i<boardList.size(); i++){
			BoardDTO bdto = boardList.get(i);
		
	%>						
			<tr align="center">
				<td><%= bdto.getNum() %></td>  <!-- 번호 -->
				<td align="left"> <!-- 제목  / 왼쪽 정렬 -->
					<%
						if (bdto.getReStep() > 1) { // 게시물에 댓글이 1개 이상일 경우
							for (int j=0; j<(bdto.getReLevel()-1)*5; j++) { 
					%>
								&nbsp;  <!-- 공백 / 1번째 답글 &nbsp; 5번, 2번째 답글 10번 -->
					<% 			
							}
					%>
							»&nbsp;
					<% 
						} 
					%>
					 <a href="05_bInfo.jsp?num=<%=bdto.getNum()%>"><%= bdto.getSubject() %></a>
				</td>
				<td> <%= bdto.getWriter() %> </td> <!-- 작성자 -->
				<td> <%= bdto.getRegDate() %> </td> <!-- 작성일 -->
				<td> <%= bdto.getReadCount() %> </td> <!-- 조회수 -->
			</tr>
	<% 
		}
	%>				
			<tr align="right">
				<td colspan="5">
					<input type="button" style="float: right" value="글쓰기" onclick="location.href='02_bWrite.jsp'">
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center">	<!-- colspan 태그: 열병합 -->		
					<select id="searchKeyword" style="width: 150px; display: inline;">
						<option 
							<%
								if (searchKeyword.equals("total")) {
							%>
									selected
							<% 
								}
							%>
						value="total">전체검색</option>
						<option 
							<%
								if (searchKeyword.equals("writer")) {
							%>
									selected
							<% 
								}
							%>
						value="writer">작성자</option>
						<option 
							<%
								if (searchKeyword.equals("subject")) {
							%>
									selected
							<% 
								}
							%>
						value="subject">제목</option>
					</select>
					<input type="text" style="display: inline;" id="searchWord" name="searchWord" value=<%=searchWord %>> 
					<input type="button" value="검색" onclick="showList()">
				</td>
			</tr>
		</table>
		<div style="display: table; margin-left: auto; margin-right: auto">
	<% 
		if (totalBoardCount > 0) {
			
			//            전체페이지 개수 = 전체게시판 수 / 한페이지에서 보여지는 글수
			int addPage = totalBoardCount % onePageViewCount == 0 ? 0 : 1; // 나머지가 0이면 추가 x , 나머지가 0이 아니면 +1페이지 --> 0이면 addPage=0, 0이 아니면 addPage=1
			int totalPageCount = totalBoardCount / onePageViewCount + addPage; // 나눈 값(페이지 수) + addPage -> 페이지 수 구하기
			
			
			// 시작페이지
			int startPage = 1;
			
			if (currentPageNumber % 10 == 0) {  
				startPage = (currentPageNumber / 10 - 1) * 10 + 1;
					/*
						currentPage 10 : 1  
						currentPage 20 : 11  
						currentPage 30 : 21 
					*/
			} 
			else {
				startPage = (currentPageNumber / 10) * 10 + 1;							
				/*
					currentPage 1  : 1  
					currentPage 11 : 11  
					currentPage 21 : 21 
				*/
			}
		
			
			//끝페이지
			int endPage = startPage + 9;
				
			// 끝페이지가 전체 페이지 개수보다 크다면 
			if (endPage > totalPageCount) {
				endPage = totalPageCount;
			}
			
			// 게시물이 한페이지에 보여지는 것보다 작다면
			if (onePageViewCount > totalBoardCount) {
				startPage = 1;
				endPage = 0;
			}
	%>
			<ul>
	<% 
			if (startPage > 10) {
	%>
				<li>
					<a href="04_bList.jsp?currentPageNumber=<%= startPage - 10 %>&onePageViewCount=<%=onePageViewCount%>&searchKeyword=<%=searchKeyword%>&searchWord=<%=searchWord%>" >이전 </a>
				</li> 
	<% 				
			}	
	
			for (int i=startPage; i<=endPage; i++) {
	%>	
				<li>
					<a href="04_bList.jsp?currentPageNumber=<%= i %>&onePageViewCount=<%=onePageViewCount%>&searchKeyword=<%=searchKeyword%>&searchWord=<%=searchWord%>"><%=i%></a>
				</li>
	<% 				
			}
					
			if (endPage <= totalBoardCount && endPage >= 10){
	%>
				<li>
					<a href="04_bList.jsp?currentPageNumber=<%= startPage + 10 %>&onePageViewCount=<%=onePageViewCount%>&searchKeyword=<%=searchKeyword%>&searchWord=<%=searchWord%>"> 다음 </a>
				</li> 
	<% 		
			}
		}	
	%>
			</ul>
		</div>
	</div>
</body>
</html>