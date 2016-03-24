<!--
<회원가입 폼 jsp>
1. 중복체크
중복체크 버튼을 누르면 위의 스크립트 emailchk()로 갔다가 팝업창을 열고
팝업창은 url로 emailchk.jsp를 실행
(emailchk.jsp는 아직 구현 못했습니다.)

2. 확인
확인 버튼을 누르면 joinPro.jsp를 실행
(joinPro.jsp는 아직 구현 못했습니다.)
joinPro.jsp가 성공하면 회원가입 성공.

마지막 수정날짜 : 2016-03-22 오전 10:00
마지막 수정한 사람 : 곽지은
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="country_language.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function chk() {
		if (frm.passwd.value != frm.passwd2.value) {
			alert("암호를 다시 입력하세요");
			frm.passwd.value = "";
			frm.passwd2.value = "";
			frm.password.focus();
			return false;
		}
		return true;
	}
	function emailchk() {
		var purl = "../member/emailchk.jsp?m_email=" + frm.email.value;
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

	<form action="../member/joinPro.jsp" name="frm" onsubmit="return chk()">
		<table class="tab" cellpadding="10" align="center">
			<caption>
				<h2>회원가입</h2>
			</caption>
			<tr height="50">
				<td class="join1"><font class="red">*</font>이메일</td>
				<td><input type="text" name="email" required="required">
					<input type="button" value="중복체크" onclick="emailchk()"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>암호</td>
				<td><input type="password" name="passwd" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>암호확인</td>
				<td><input type="password" name="passwd2" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>닉네임</td>
				<td><input type="text" name="nick" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1">국적</td>
				<td><select name="country">
						<%
							String c = "c";
							Country_LanguageDao cld = Country_LanguageDao.getInstance();
							List<Country_Language> list1 = cld.selectList(c);
							for (Country_Language cl : list1) {
						%>

						<option>
							<%=cl.getValue()%>
						</option>
						<%
							}
						%>
				</select></td>

			</tr>
			<tr height="50">
				<td class="join1">희망언어</td>
				<td><select name="lang">
						<%
							String l = "l";
							List<Country_Language> list2 = cld.selectList(l);
							for (Country_Language cl : list2) {
						%>
						<option><%=cl.getValue()%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">
					&nbsp; <input type="button" value="취소" onclick="history.back(-1)">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>