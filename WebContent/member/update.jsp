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
	<form action="../member/updatePro.jsp" name="frm">
		<input type="hidden" name="check" value="false">
		<table class="tab" cellpadding="10" align="center">
			<caption>
				<h2>회원정보수정</h2>
			</caption>
			<tr height="50">
				<td class="join1"><font class="red">*</font>이메일</td>
				<td><input type="hidden" name="m_email"
					value="<%=mb.getM_email()%>"> <label><%=mb.getM_email()%></label></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>비밀번호</td>
				<td><input type="password" name="m_passwd"
					value="<%=mb.getM_passwd()%>" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>비밀번호 확인</td>
				<td><input type="password" name="m_passwd2" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>닉네임</td>
				<td><input type="text" name="m_nick"
					value="<%=mb.getM_nick()%>" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1">국적</td>
				<td><select name="c_code">
						<option value="0">----------선택안함----------</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("c")) {
						%>
						<option value=<%=jc.getC_minor()%>
							<%if (jc.getC_minor().equals(mb.getC_code())) {%>
							selected="selected" <%}%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
							}
						%>
				</select></td>

			</tr>
			<tr height="50">
				<td class="join1">희망언어</td>
				<td><select name="l_code">

						<option value="0">----------선택안함----------</option>

						<option value="0">선택안함</option>

						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value=<%=jc.getC_minor()%>
							<%if (jc.getC_minor().equals(mb.getL_code())) {%>
							selected="selected" <%}%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="수정">
					&nbsp; <input type="button" value="취소" onclick="history.back(-1)">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>