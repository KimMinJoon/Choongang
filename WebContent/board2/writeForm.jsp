<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_board.*,j_code.*"%>
<!DOCTYPE ><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="comm.css">

<%
	String pageNum = request.getParameter("pageNum");
%>

<%
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList(0);
	%>
</head>
<body>
<form action="write.jsp" method="post">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
 
<table border="1"><caption>게시판 작성</caption>
	<tr>
		<th>제목</th><td><input type="text" name="subject" required="required" autofocus="autofocus"></td>
	</tr>
	
	<tr height="50">
				<td class="join1">말머리</td>
				<td>
					<select name="l_code">
						<option value="0">해당없음</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("mc")) {
						%>
						<option value=<%=jc.getC_minor()%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
					</select>
				</td>
			</tr>
	
	<tr height="50">
				<td class="join1">희망언어</td>
				<td>
					<select name="l_code">
						<option value="0">해당없음</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value=<%=jc.getC_minor()%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
					</select>
				</td>
			</tr>
	
	<tr>
		<th>닉네임</th><td><input type="text" name="nick" required="required" ></td>
	</tr>
	
	<tr>
		<th>email</th><td><input type="email" name="email" required="required" ></td>
	</tr>
	
	<tr>
		<th>암호</th><td><input type="password" name="passwd" required="required" ></td>
	</tr>
	
	<tr>
		<th>내용</th><td><textarea rows="5" cols="50" name="content" required="required"></textarea></td>
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