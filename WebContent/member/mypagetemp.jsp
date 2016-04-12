<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../session/sessionChk.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table align="center" width="100%">
		<tr>
			<td width="20%" height="50"><jsp:include page="mypage.jsp" /></td>
			<td width="80%" class="mypagetemp">
			<c:if test="${empty param.mypgm}">
					<jsp:include page="myinfo.jsp"/>
			</c:if> 
			<c:if test="${not empty param.mypgm}">
					<jsp:include page="${param.mypgm}"/>
			</c:if></td>
		</tr>
	</table>

</body>
</html>