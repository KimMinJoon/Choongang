<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<% request.setCharacterEncoding("UTF-8"); %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="olr" class="j_onelineboard.J_OneLineReply"/>
	<jsp:setProperty property="*" name="olr"/>
	
	<%
		
	
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		System.out.println(pageNum);
		
		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int result = jobd.insertReply(olr);
		if(result > 0){
	%>
		<script type="text/javascript">
			location.href = "../module/main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum="+pageNum;
		</script>
	<%
		}else{
	%>
		<script type="text/javascript">
		</script>
	<%
		}
	%>
</body>
</html>