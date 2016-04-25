<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*,j_code.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../session/sessionChk.jsp"  %>
<!DOCTYPE ><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
<form action="../meetBoard/write.do" method="post">
<input type="hidden" name="pageNum" value="${pageNum}">
<input type="hidden" name="m_no" value="${m_no}">
 
<table class="tab"><caption>게시판 작성</caption>
	<tr>
		<td class="join1">제목</td><td><input type="text" name="brd_subject" required="required" autofocus="autofocus"></td>
	</tr>
	
	<tr height="50">
				<td class="join1">말머리</td>
				<td>
					<select name="mc_code">
						<c:forEach var="jmc" items="${list}">
						<c:if test="${jmc.c_major eq 'mc' }">
						<option value="${jmc.c_minor}">
							${jmc.c_value}
						</option>
						</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			
	<tr height="50">
				<td class="join1">희망언어</td>
				<td>
					<select name="l_code">
						<c:forEach var="jc" items="${list }">
						<c:if test="${jc.c_major eq 'l' }">
						<option value="${jc.c_minor}">
							${jc.c_value}
						</option>
						</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
	<tr>
		<td class="join1">내용</td><td><textarea rows="5" cols="50" name="brd_content" required="required"></textarea></td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="확인">
			<input type="reset"  value="취소">
		</td>
	</tr>
</table>
</form>
</body>
</html>