<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*,j_code.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function chk() {
		if (frm.m_passwd.value != frm.m_passwd2.value) {
			alert("암호를 다시 입력하세요");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
		}
		if (frm.check.value == "false") {
			alert("아이디 중복확인을 하세요");
			return false;
		}
		return true;
	}

	function emailchk() {
		var purl = "../member/emailchk.jsp?m_email=" + frm.m_email.value;
		var pname = "emailpopup";
		var pwidth = 300;
		var pheight = 200;
		var pleft = (screen.availWidth - pwidth) / 2;
		var ptop = (screen.availHeight - pheight) / 2;
		var poption = "scrollbars=no,status=no,toolbar=no,resizable=0,location=no,menu=no,"
				+ "width="
				+ pwidth
				+ ",height="
				+ pheight
				+ ",left="
				+ pleft
				+ ",top=" + ptop;
		window.open(purl, pname, poption);
	}
</script>
</head>
<body>

	<%
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList(0);
		String m_email = (String) session.getAttribute("m_email");
		J_MemberDao mdo = J_MemberDao.getInstance();
		J_Member mb = mdo.select(m_email);
	%>
	<form action="../member/updatePro.jsp" name="frm" onsubmit="return chk()">
		<input type="hidden" name="check" value="false">
		<table class="tab" cellpadding="10" align="center">
			<caption>
				<h2>회원정보수정</h2>
			</caption>
			<tr height="50">
				<td class="join1"><font class="red">*</font>이메일</td>
				<td><label name="m_email"><%=mb.getM_email()%></label></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>암호</td>
				<td><input type="password" name="m_passwd"  value="<%=mb.getM_passwd()%>" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>암호확인</td>
				<td><input type="password" name="m_passwd2" required="req"WebContent/mbupdate.jsp"uired"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>닉네임</td>
				<td><input type="text" name="m_nick" value="<%=mb.getM_nick()%>" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1">국적</td>
				<td><select name="c_code">
						<option value="<%=mb.getC_code()%>"><%=mb.getC_code()%></option>
						<option value="0">해당없음</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("c")) {
						%>
						<option   value=<%=jc.getC_minor()%>>
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
						<option value="0">해당없음</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value=<%=jc.getC_minor()%>>
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