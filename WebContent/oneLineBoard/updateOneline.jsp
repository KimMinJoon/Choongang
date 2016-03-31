<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="olb" class="j_onelineboard.J_OneLineBoard"/>
<jsp:setProperty property="*" name="olb"/>
<body>
<%
	String m_no = (String)session.getAttribute("m_no");	
	
	olb.setBrd_ip(request.getRemoteAddr());
	J_OneLineBoardDAO jold = J_OneLineBoardDAO.getInstance();
	int result = jold.updateBoard(olb);
	if(result > 0){
%>
	<script type="text/javascript">
		alert("한줄 글 수정 성공");
		location.href = "../module/main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp";
	</script>
<%		
	}else{
%>
	<script type="text/javascript">
		alert("한줄 글 수정 실패");
		history.back();
	</script>
<%
	}
%>
</body>
</html>