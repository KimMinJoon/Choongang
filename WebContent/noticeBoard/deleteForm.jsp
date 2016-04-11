<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<%@ include file="../session/adminChk.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
<script type="text/javascript">
	function chk() {
		if (frm.password.value != frm.dbPass.value) {
			alert("암호가 다릅니다.");
			frm.password.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<form action="../noticeBoard/deletePro.do" name="frm"
		onsubmit="return chk()">
		<input type="hidden" name="brd_no" value="${brd_no}"> <input
			type="hidden" name="pageNum" value="${pageNum}"> <input
			type="hidden" name="admin" value="${admin}"> <input
			type="submit" value="확인">
	</form>
</body>
</html>