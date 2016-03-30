<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/boardcss.css">
</head>
<body>

	<table border="1" align="center" style='border-collapse: collapse;'>
		<caption>게시판</caption>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>닉네임</th>
			<th>등록일</th>
			<th>조회수</th>
			<th>IP</th>
		</tr>
		<%
			int rowPerPage = 10;
			int pagePerBlock = 10;
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum.equals("null") || pageNum.equals(""))
				pageNum = "1";
			int nowPage = Integer.parseInt(pageNum);
			J_RecommendBoardDao jr = J_RecommendBoardDao.getInstance();
			int total = jr.selectTotal();
			int totalPage = (int) Math.ceil((double) total / rowPerPage);
			int startRow = (nowPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			int totalBlk = (int) Math.ceil((double) totalPage / pagePerBlock);
			int startPage = (nowPage - 1) / 10 * 10 + 1;
			int endPage = startPage + pagePerBlock - 1;
			if (endPage > totalPage)
				endPage = totalPage;
			total = total - startRow + 1;
			List<J_RecommendBoard> list = jr.selectList(startRow, endRow);
			if (list != null) {
				for (J_RecommendBoard jrb : list) {
		%>
		<tr>
			<td><%=total--%></td>
			<%
					if (jrb.getBrd_dey_yn().equals("y")) {
							out.println("<td colspan='7'>삭제된 글입니다</td></tr>");
					} else {
			%>
			<td>
				<%
						if (jrb.getRe_level() > 0) {
							int w = jrb.getRe_level() * 10;
				%>
							<img alt="" src="../images/level.gif" width="<%=w%>" height="10">
							<img alt="" src="../images/re.gif">
				<%
 						}
				%>
						<a href="view.jsp?num=<%=jrb.getBrd_no()%>&pageNum=<%=nowPage%>"> <%=jrb.getBrd_subject()%></a>
				<%
						if (jrb.getBrd_readcount() > 20)
							out.println("<img src='images/hot.gif'>");
				%>
			</td>
			<td><a href="mailto:<%=jrb.getEmail()%>"> <%=jrb.getBrd_Writer()%></a></td>
			<td><%=jrb.getBrd_readcount()%></td>
			<td><%=jrb.getBrd_reg_date()%></td>
		</tr>
			<%
					}
				}
			} else {
			%>
		<tr>
			<td colspan="7">데이터가 없습니다</td>
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>


