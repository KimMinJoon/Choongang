<%--
<에러가 발생한 경우 한글로 에러 내용을 보여주는 에러 처리 jsp>
사용 방법 : <%@ page import errorPage="/error/DBError.jsp" %>

마지막 수정날짜 : 2016-03-22 오전 9:52
마지막 수정한 사람 : 곽지은
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<% response.setStatus(200); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<font color="red"><b><em> "에러가 발생했습니다" </em></b></font><p>
	<%=exception.getMessage() %>

</body>
</html>