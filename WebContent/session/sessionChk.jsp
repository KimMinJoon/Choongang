<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String m_no = (String)session.getAttribute("m_no");
	if(m_no == null || m_no.equals("") || m_no.equals("null")){
%>
		<script type="text/javascript">
			alert("로그인을 하셔야 이용할 수 있는 페이지입니다.");		
			location.href="../module/main.jsp?pgm=/member/login.jsp";
		</script> 
<%
	} 
%>

</body>
</html>