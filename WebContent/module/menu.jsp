<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	<hr size="1" color="black">
	<table height="4" width="100%">
		<tr>
			<td width="15%" align="center"><a href="${pageContext.request.contextPath}/noticeBoard/exchangeLanguage.do">사이트소개</a></td>
			<td width="15%" align="center"><a href="${pageContext.request.contextPath}/noticeBoard/list.do">공지사항</a></td>
			<td width="15%" align="center"><a href="${pageContext.request.contextPath}/meetBoard/meetlist.do">모임 게시판</a></td>
			<td width="15%" align="center"><a href="${pageContext.request.contextPath}/recommendBoard/list.jsp">추천 게시판</a></td>
			<td width="15%" align="center"><a href="${pageContext.request.contextPath}/oneLineBoard/list.do">한줄 게시판</a></td>
			<td width="15%" align="center">
			<input type="text" id="search" name="search" size=15 />
			<input type="button" id="search" name="search" value="검색"/>
			</td>
		</tr>
	</table>
	
	<hr>
	
</body>
</html>