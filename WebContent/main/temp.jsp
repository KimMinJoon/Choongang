
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#B3FFAA">
<%
	String pgm = request.getParameter("pgm");
	if(pgm==null || pgm =="") pgm = "home.jsp";
%>

<table>
	<tr>
		<td colspan="2" height="50" bgcolor="#FFFED7"><jsp:include page = "top.jsp"/></td>
	</tr>
	
	<tr>
		<td width="20%" bgcolor="#FFBFFF"><jsp:include page = "menu.jsp"/></td>
		
		<td width="20%" bgcolor="#FFBFFF"><jsp:include page = "<%=pgm %>"/></td>
	</tr>
	
	<tr>
		<td colspan="2" bgcolor="#FFCBCB"><jsp:include page = "bottom.jsp"/></td>
	</tr>
	

</table>
</body>
</html>