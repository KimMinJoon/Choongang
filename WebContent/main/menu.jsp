<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head><body>
<table height="200" width="100%">
	<tr>
		<td><a href="temp.jsp?pgm=home.jsp">홈</a></td>
		<!-- href는 temp.jsp로 가는데 pgm에 home.jsp를 넣어서 가라라는 의미이다. -->
	</tr>
	<tr>
		<td><a href="temp.jsp?pgm=meetBoard.jsp">모임게시판</a></td>
	</tr>
	<tr>
		<td><a href="temp.jsp?pgm=recommendBoard.jsp">추천게시판</a></td>
	</tr>
</table>
</body>
</html>