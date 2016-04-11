<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*,j_code.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../session/sessionChk.jsp"  %>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="comm.css">
</head>
<body>
<form action="${pageContext.request.contextPath}/meetBoard/updatePro.do" method="post">
	<input type="hidden" name="brd_no" value="${meetboard.brd_no}">
	<input type="hidden" name="pageNum" value="${pageNum}">
<table border="1"><caption>게시판 수정</caption>
<tr>
		<td class="join1">제목</td><td><input type="text" name="brd_subject" required="required" autofocus="autofocus" value="${meetboard.brd_subject}"></td>
	</tr>
	<tr height="50">
				<td class="join1">말머리</td>
				<td>
					<select name="mc_code">
						<option value="${meetboard.mc_code}" selected="selected"> ${meetboard.c_value_cate}</option>
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
						<option value="${meetboard.l_code}" selected="selected">${meetboard.c_value_lang}</option>
						<c:forEach var="jc" items="${list }">
						<c:if test="${jc.c_major eq 'l'}">
						<option value="${jc.c_minor }">
							${jc.c_value}
						</option>
						</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
	<tr>
		<td class="join1">내용</td><td><textarea rows="5" cols="50" name="brd_content" required="required">${meetboard.brd_content}</textarea></td>
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