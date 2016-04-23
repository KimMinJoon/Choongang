<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<!-- <link rel="stylesheet" type="text/css" href="../../css/projectcss.css"> -->
</head>
<body>
    
    <jsp:include page="top.jsp" />
    
	<table align="center">
		<tr>
			<td>
			<c:if test="${empty param.pgm}">
				<jsp:include page="home.jsp"/>
			</c:if>
			<c:if test="${not empty param.pgm}">
				<jsp:include page="${param.pgm }" />
			</c:if>
			</td>
		</tr>
	</table>
	
	<jsp:include page="bottom.jsp" />
	
</body>
</html>