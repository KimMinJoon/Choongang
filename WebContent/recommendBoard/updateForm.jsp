<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../session/sessionChk.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>

	<form action="updatePro.do" method="post">
		<input type="hidden" name="brd_no" value="${jrb.brd_no}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption><h2>게시판 수정</h2></caption>
			<tr>
				<td class="join1">제목</td>
				<td><input type="text" name="brd_subject" required="required" autofocus="autofocus" value="${jrb.brd_subject}"></td>
			</tr>
			<tr height="50">
				<td class="join1">말머리</td>
				<td>
				<select name="rc_code">
						<c:forEach var="jc" items="${list}">
							<c:if test="${jc.c_major eq 'rc'}">
								<option value="${jc.c_minor}">
									${jc.c_value}
								</option>
							</c:if>
						</c:forEach>							
				</select></td>
			</tr>
			<tr>
				<td class="join1">내용</td>
				<td><pre><textarea rows="5" cols="50" name="brd_content" required="required">${jrb.brd_content}</textarea></pre></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="확인">
					<input type="button" value="취소" onclick="history.back(-1)"></td>
			</tr>
		</table>
	</form>
</body>
</html>