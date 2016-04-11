<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="olb" class="j_onelineboard.J_OneLineBoard"/>
<jsp:setProperty property="*" name="olb"/>
<body>
	<c:if test="${result > 0}">
		<script type="text/javascript">
			location.href="${pageContext.request.contextPath}/oneLineBoard/list.do?pageNum=${pageNum}&searchType=${searchType}&searchTxt=${searchTxt}";
		</script>
	</c:if>
	<c:if test="${result == 0}">
	<script type="text/javascript">
		alert("한줄 글 삭제 실패");
		history.back();
	</script>
</c:if>
</body>
</html>