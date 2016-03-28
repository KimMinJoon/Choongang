<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*,j_code.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList(0);
		String m_no = (String) session.getAttribute("m_no");
		J_MemberDao mdo = J_MemberDao.getInstance();
		J_Member mb = mdo.select(m_no);
	%>
	<table class="tab" cellpadding="10" align="center">
		<caption>
			<h2>내정보보기</h2>
		</caption>
		<tr>
			<td colspan="2"><img alt="pic" src="../images/1P.jpg"
				height="150"></td>
		</tr>
		<tr height="50">
			<td class="join1">이메일</td>
			<td><%=mb.getM_email()%></td>
		</tr>
		<tr height="50">
			<td class="join1">닉네임</td>
			<td><%=mb.getM_nick()%></td>
		</tr>
		<tr height="50">
			<td class="join1">국적</td>
			<td>
				<%
					for (J_Code jc : list) {
						if (jc.getC_major().equals("c")) {
							if (jc.getC_minor().equals(mb.getC_code())) {
				%> <%=jc.getC_value()%> <%
 	}
 		}
 	}
 %>
			</td>
		</tr>
		<tr height="50">
			<td class="join1">희망언어</td>
			<td>
				<%
					for (J_Code jc : list) {
						if (jc.getC_major().equals("l")) {
							if (jc.getC_minor().equals(mb.getL_code())) {
				%> <%=jc.getC_value()%> <%
 	}
 		}
 	}
 %>
			</td>
		</tr>
	</table>

</body>
</html>