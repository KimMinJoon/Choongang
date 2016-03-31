<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_board.*, j_code.*" %>

<%
	// String m_no = (String)session.getAttribute("m_no"); // 세션처리안됌
	String m_no = "1";
	String pageNum = request.getParameter("pageNum");
%>

<%
	J_CodeDao jcd = J_CodeDao.getInstance();
	List<J_Code> list = jcd.selectList();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/boardcss.css">
</head>
<body>

	<form action="write.jsp" method="post">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="m_no" value="<%=m_no%>">

		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption><h2>게시판 작성</h2></caption>
			<tr>
				<td class="writeF" width="6%">말머리</td>
					<td class="inputleft" width="14%"><select name="mc_code">
						<%
							for (J_Code jmc : list) {
								if (jmc.getC_major().equals("mc")) {
						%>
						<option value=<%=jmc.getC_minor()%>>
							<%=jmc.getC_value()%>
						</option>
						<%
							}
						}
						%>
				</select></td>
				<td colspan="2" rowspan="2" width="30%"> 제목 : &nbsp; <input type="text" name="brd_subject" required="required" autofocus="autofocus" size="50"></td>
			</tr>
			<tr>
				<td class="writeF">희망언어</td>
				<td class="inputleft"><select name="l_code">
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value="<%=jc.getC_minor()%>">
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
				</select></td>
			</tr>
			<tr>
				<td colspan="4"><br><textarea rows="20" cols="100" name="brd_content" required="required"></textarea></td>
			</tr>
			<tr>
				<td colspan="4" align="center"><input type="submit" value="확인"> &nbsp;
				<input type="reset" value="취소" onclick="history.back(-1)"></td>
			</tr>
		</table>
	</form>
	
</body>
</html>