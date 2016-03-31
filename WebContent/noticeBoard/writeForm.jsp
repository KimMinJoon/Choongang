<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<%
	/* String m_no = (String) session.getAttribute("m_no"); */
	String pageNum = request.getParameter("pageNum");
%>

</head>
<body>
	<form action="../noticeBoard/write.jsp" method="post">
		<input type="hidden" name="pageNum" value="<%=pageNum%>"> <%-- <input
			type="hidden" name="m_no" value="<%=m_no%>"> --%>
		<table class="tab">
			<caption>공지사항 작성</caption>
			<tr>
				<td class="join1">제목</td>
				<td><input type="text" name="brd_subject" required="required"
					autofocus="autofocus"></td>
			</tr>
			<tr>
				<td class="join1">내용</td>
				<td><textarea rows="5" cols="50" name="brd_content"
						required="required"></textarea></td>
			</tr>

			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">
					<input type="reset" value="취소"></td>
			</tr>
		</table>
	</form>
</body>
</html>