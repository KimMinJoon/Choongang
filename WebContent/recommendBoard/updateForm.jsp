<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../session/sessionChk.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	window.onload = function(){
		CKEDITOR.replace('content');
	}
</script>
</head>
<body>

	<form action="updatePro.do" method="post">
		<input type="hidden" name="brd_no" value="${jrb.brd_no}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption><h2>게시판 수정</h2></caption>
			<tr>
				<td class="inputleft">
				<select name="rc_code">
					<option value="${jrb.rc_code}" selected="selected"> ${jrb.rc_value}</option>
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
				<td class="inputleft">
				<input type="text" name="brd_subject" required="required" autofocus="autofocus" size="50" value="${jrb.brd_subject}">
			</tr>
			<tr>
				<td>
				<pre><textarea rows="20" cols="90" name="brd_content" required="required">${jrb.brd_content}</textarea></pre>
				</td>
			</tr>
			<tr>
				<td align="center"><input type="submit" value="확인"> &nbsp;
				<input type="button" value="취소" onclick="history.back(-1)"></td>
			</tr>
		</table>
	</form>
</body>
</html>