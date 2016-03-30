<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*,j_code.*, java.util.*"%>
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
		J_MemberDao mdo = J_MemberDao.getInstance();
		J_Info jif = mdo.infoselect(m_no);
	%>
	<table class="tab" cellpadding="10" align="center" height="100%">
		<caption>
			<h2>내정보보기</h2>
		</caption>
		<tr height="40%">
			<td colspan="2"><img alt="pic" src="../images/1P.jpg"
				height="150"></td>
		</tr>
		<tr height="15%">
			<td class="join1">이메일</td>
			<td><%=jif.getI_email()%></td>
		</tr>
		<tr height="15%">
			<td class="join1">닉네임</td>
			<td><%=jif.getI_nick()%></td>
		</tr>
		<tr height="15%">
			<td class="join1">국적</td>
			<td><%=jif.getC_value() %></td>
		</tr>
		<tr height="15%">
			<td class="join1">희망언어</td>
			<td><%=jif.getL_value() %></td>
		</tr>
	</table>

</body>
</html>