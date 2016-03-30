<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
</head>
<body>
<%
	int brd_no = Integer.parseInt(request.getParameter("brd_no"));
	String pageNum = request.getParameter("pageNum");
	J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
	J_MeetBoard brd = bd.select(brd_no);
	if (brd != null) {
		bd.updateHit(brd_no);
%>
	<table border="1" width="80%"><caption>게시판 상세내용</caption>
		<tr>
			<th>제목</th><td><%=brd.getBrd_subject() %></td>
		</tr>
		<tr>
			<th>작성자</th><td><%=brd.getM_nick() %></td>
		</tr>
		<tr>
			<th>조회수</th><td><%=brd.getBrd_readcount() %></td>
		</tr>
		
		<tr>
			<th>추천수</th><td><%=brd.getBrd_recommend() %></td>
		</tr>
		
		<tr>
			<th>희망언어</th><td><%=brd.getL_code() %></td>
		</tr>
		
		
		<%-- <tr>
			<th>IP</th><td><%=brd.getBrd_ip() %></td>
		</tr> --%>
		
		<tr>
			<th>작성일</th><td><%=brd.getBrd_reg_date() %></td>
		</tr>
		<tr>
			<th>내용</th><td><pre><%=brd.getBrd_content() %></pre></td>
			<!-- pre는 입력한 내용을 잇는 그래도 보여줌  -->
		</tr>
</table>
<%
	} else {
%>
	데이터가 없습니다. 
<%		
	}
%>
<div align="center">
	<button onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">게시판 목록</button>
	<button onclick="location.href='updateForm.jsp?brd_no=<%=brd_no %>&pageNum=<%=pageNum%>'">수정하기</button>
	<!-- 이렇게해야 수정을 누르면 수정클릭한 해당 페이지로 보내준다. -->
	<button onclick="location.href='deleteForm.jsp?brd_no=<%=brd_no %>&pageNum=<%=pageNum%>'">삭제하기</button>
	<button onclick="location.href='writeForm.jsp?brd_no=<%=brd_no %>&pageNum=<%=pageNum%>'">답변</button>
</div>

</body>
</html>