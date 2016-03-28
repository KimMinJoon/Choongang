<%@page import="j_board.J_BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//String m_no = (String)session.getAttribute("m_no");
	String m_no = "1";
	String brd_content = request.getParameter("brd_content");
	
	J_BoardDao jbd = J_BoardDao.getInstance();
	String brd_ip = request.getRemoteAddr();
	int result = jbd.insertOneline(m_no, brd_content, brd_ip);
	if(result > 0){
%>
	<script type="text/javascript">
		alert("한줄 글 등록 성공");
		location.href = "../module/main.jsp?pgm=/board4/board4.jsp";
	</script>
<%		
	}else{
%>
	<script type="text/javascript">
		alert("한줄 글 등록 실패");
		history.back();
	</script>
<%
	}
%>
</body>
</html>