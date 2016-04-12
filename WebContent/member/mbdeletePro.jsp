<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<c:if test="${chk == 1 }">
		<c:if test="${result > 0 }">
			<% session.invalidate(); %>
			<script type="text/javascript">
				alert("탈퇴 성공");
				location.href = "../module/main.jsp";
			</script>
		</c:if>
	</c:if>
	<c:if test="${chk == 0 }">
		<script type="text/javascript">
			alert("비밀번호를 확인해주세요.");
			history.go(-1);
		</script>
	</c:if>
	
</body>
</html>