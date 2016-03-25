<!--
<회원가입 폼에서 email 중복체크하는 jsp>

마지막 수정날짜 : 2016-03-22 오전 10:00
마지막 수정한 사람 : 곽지은
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*" errorPage="/error/DBError.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	String m_email = request.getParameter("m_email");
%>
<script type="text/javascript">
	function cl() {
		opener.frm.m_email.value = "<%=m_email%>";
		opener.frm.check.value = "true";
		window.close();
	}
</script>
</head>
<body>
	<%
		J_MemberDao mdo = J_MemberDao.getInstance();
		int result = mdo.inchk(m_email);
		if (result == 1) {
	%>
	아이디 : <%=m_email%><br> 
	사용할 수 없습니다.<p>
	<form>
		아이디: <input type="email" name="m_email" required="required"><p>
		<input type="submit" value="확인">
	</form>
	<%
		} else {
	%>
	아이디 : <%=m_email%><br> 
	사용할 수 있습니다.
	<button onclick="cl()">창닫기</button>
	<%
		}
	%>
</body>
</html>