<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*" errorPage="/error/DBError.jsp"%>
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
		String m_no = (String) session.getAttribute("m_no");
		String m_passwd = request.getParameter("m_passwd");
		J_MemberDao md = J_MemberDao.getInstance();
		int chk = md.passwdChk(m_no, m_passwd);
		if (chk == 1) {
			int result = md.delete(Integer.parseInt(m_no));
			if (result > 0) {
				session.invalidate();
	%>
	<script type="text/javascript">
		alert("탈퇴 완료");
		location.href = "../module/main.jsp";
	</script>
	<%
		}
		} else {
	%>
	<script type="text/javascript">
		alert("비밀번호를 확인해주세요.");
		history.go(-1);
	</script>
	<%
		}
	%>

</body>
</html>