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

	<table class="tab" cellpadding="10" align="center" width="60%">
		<caption><h2>J_RecommendBoard</h2></caption>
		<tr>
			<th class="bottom" width="5%">번호</th>
			<th class="bottom" width="7%">말머리</th>
			<th class="bottom" width="32%">제목</th>
			<th class="bottom" width="10%">닉네임</th>
			<th class="bottom" width="10%">date</th>
			<th class="bottom" width="1%">hit</th>
			<th class="bottom" width="1%">rc</th>
		</tr>
<%
		J_RecommendBoardDao jr = J_RecommendBoardDao.getInstance();

		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum.equals("null") || pageNum.equals(""))
			pageNum = "1";

		int rowPerPage = 10;
		int pagePerBlock = 10;
		int nowPage = Integer.parseInt(pageNum);
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
		if (list.size() != 0) {
			for (J_RecommendBoard jrb : list) {			
%>
			<tr>
				<td class="bottom"><%=total--%></td>
				<td class="bottom"><%=jrb.getC_value()%></td>
<%
				if (jrb.getBrd_dey_yn().equals("y")) {
					out.println("<td class='bottom' colspan='7'>삭제된 글입니다</td></tr>");
				} else {
%>
				<td class="bottom">
<%
					if (jrb.getRe_level() > 0) {
						int w = jrb.getRe_level() * 10;
%>
					<img alt="" src="../images/level.gif" width="<%=w%>" height="10">
					<img alt="" src="../images/re.gif">
<%
 					}
%>
					<a href="view.jsp?num=<%=jrb.getBrd_no()%>&pageNum=<%=nowPage%>"><%=jrb.getBrd_subject()%></a>
<%
					if (jrb.getBrd_readcount() > 20)
						out.println("<img src='images/hot.gif'>");
%>
				</td>
				<td class="bottom"><%=jrb.getM_nick()%></td>
				<td class="bottom"><%=jrb.getBrd_reg_date()%></td>
				<td class="bottom"><%=jrb.getBrd_readcount()%></td>
				<td class="bottom"><%=jrb.getBrd_recommend()%></td>
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
	
	<div align="center">
<%
		if (startPage > pagePerBlock) {
%>
			<a href="list.jsp?pageNum=<%=startPage - pagePerBlock%>">[prev] </a>
			<a href="list.jsp?pageNum=1">[1]</a>				
			...
<%
		}
		for (int i = startPage; i <= endPage; i++) {
			if(i==nowPage){
%>
				<b>[<%=i%>]</b>
<%
			} else {
%>
				<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%
			}
		}
		if (totalPage > endPage) {
%>
			...
			<a href="list.jsp?pageNum=<%=totalPage%>">[<%=totalPage%>]</a>
			<a href="list.jsp?pageNum=<%=startPage + pagePerBlock%>">[next]</a>
<%
		}
%>
		<p>
		<button onclick="location.href='writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>
	</div>

</body>
</html>
