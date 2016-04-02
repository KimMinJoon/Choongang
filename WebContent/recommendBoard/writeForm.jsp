<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_code.*" %>
<%@ page import="java.util.List" %>
<%@ include file="../session/sessionChk.jsp" %>

<%
	String pageNum = request.getParameter("pageNum");

	J_CodeDao jcd = J_CodeDao.getInstance();
	List<J_Code> list = jcd.selectList();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>

	<form action="../recommendBoard/writePro.jsp" method="post">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="m_no" value="<%=m_no%>">

		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption><h2>게시판 작성</h2></caption>
			<tr>
				<td class="inputleft">
				<select name="rc_code">
					<%
						for (J_Code jc : list) {
							if (jc.getC_major().equals("rc")) {
					%>
						<option value=<%=jc.getC_minor()%>>
							<%=jc.getC_value()%>
						</option>
					<%
							}
						}
					%>
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