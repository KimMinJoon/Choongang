<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<script type="text/javascript">
	function cl() {
		opener.frm.m_email.value = "${m_email}";
		opener.frm.check.value = "true";
		window.close();
	}
</script>
</head>
<body>
	<c:if test="${result == 1}">
		이메일 : ${m_email}<br>
		<font color="red">사용할 수 없습니다.</font>
		<p>
		<form>
			이메일 : <input type="email" name="m_email" required="required">
			<p>
				<input type="submit" value="확인">
		</form>
	</c:if>
	<c:if test="${result != 1 }">
	이메일 : ${m_email}
	<br>
		<b>사용할 수 있습니다.</b>
		<p>
			<button onclick="cl()">창닫기</button>
	</c:if>
</body>
</html>