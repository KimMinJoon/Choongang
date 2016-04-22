<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../session/sessionChk.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<% request.setCharacterEncoding("UTF-8"); %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result>0}">
		<script type="text/javascript">
			location.href="${pageContext.request.contextPath}/meetBoard/view.do?pageNum=${pageNum}&brd_no=${brd_no}";
		</script>
	</c:if>
	<c:if test="${result==0}">
		<script type="text/javascript">
			alert("모임게시글 댓글 입력 실패");
			history.back();
		</script>
	</c:if>
</body>
</html>