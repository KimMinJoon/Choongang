<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>

	<form action="writePro.do" method="post">
		<input type="hidden" name="brd_no" value="${brd_no}">
		<input type="hidden" name="ref" value="${ref}">
		<input type="hidden" name="re_step" value="${re_step}">
		<input type="hidden" name="re_level" value="${re_level}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		<input type="hidden" name="m_no" value="${m_no}">

		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption><h2>게시판 작성</h2></caption>
			<tr>
				<td class="inputleft">
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
				<td class="inputleft"> <input type="text" name="brd_subject" required="required" autofocus="autofocus" size="50" placeholder="제목을 입력해 주세요"></td>
			</tr>
			<tr>
				<td><textarea rows="20" cols="90" name="brd_content" required="required"></textarea></td>
			</tr>
			<tr>
				<td align="center"><input type="submit" value="확인"> &nbsp;
				<input type="button" value="취소" onclick="history.back(-1)"></td>
			</tr>
		</table>
	</form>
	
</body>
</html>