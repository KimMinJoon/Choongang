<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function dechk() {
		var aa = confirm("정말로 탈퇴하시겠습니까?");
		if (aa) {
			return true;
		} else {
			return false;
		}
	}
	function sessionChk(){
		var m_no = <%= (String) session.getAttribute("m_no")%>;
		if (m_no == null || m_no == "" || m_no == "null") {
			alert("로그인이 필요한 페이지 입니다.");
			 location.href="../module/main.jsp?pgm=/member/login.jsp";
		}
	
	}
</script>
</head>
<body onloade="sessionChk()">

	<form name="frm" action="../member/mbdeletePro.jsp" method="post"
		onsubmit="return dechk()">
		<table class="tab" cellpadding="10" align="center">
			<tr>
				<td class="join1">암호</td>
				<td><input type="password" name="m_passwd"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">
					&nbsp; <input type="button" value="취소" onclick="history.back(-1)"></td>
			</tr>
		</table>
	</form>

</body>
</html>