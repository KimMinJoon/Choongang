<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function sessionChk(){
	var m_no = <%= (String) session.getAttribute("m_no")%>;
	if (m_no == null || m_no == "" || m_no == "null") {
		alert("로그인이 필요한 페이지 입니다.");
		 location.href="../module/main.jsp?pgm=/member/login.jsp";
	}

}
</script>
</head>
<body onload="sessionChk()">
	<%
		session.invalidate();
	%>
	<script type="text/javascript">
		alert("로그아웃 되었습니다.");
		location.href = "main.jsp";
	</script>
</body>
</html>