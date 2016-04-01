<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	
	<p>
	<p>
	
	<table align="center" width="70%">
		<caption><h2>J_RecommendBoard</h2></caption>
		<tr>
			<th width="3%"></th>
			<th width="7%">말머리</th>
			<th width="34%">제목</th>
			<th width="8%">글쓴이</th>
			<th width="8%">작성일</th>
			<th width="4%">조회</th>
			<th width="4%">추천</th>
		</tr>
		<tr><td colspan="7"><hr></td></tr>
<%
		J_RecommendBoardDao jr = J_RecommendBoardDao.getInstance();

		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum.equals("null") || pageNum.equals(""))
			pageNum = "1";

		int rowPerPage = 15;
		int pagePerBlock = 10;
		int nowPage = Integer.parseInt(pageNum);
		int total = jr.selectTotal();
		int totalPage = (int) Math.ceil((double)total/rowPerPage);
		int startRow = (nowPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int totalBlk = (int) Math.ceil((double)totalPage/pagePerBlock);
		int startPage = (nowPage - 1) / 10 * 10 + 1;
		int endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		total = total - startRow + 1;
			
		List<J_RecommendBoard> list = jr.selectList(startRow, endRow);
		if (list.size() != 0) {
			for (J_RecommendBoard jrb : list) {	
				System.out.println(jrb);
%>
			<tr>
				<td class="default"><%=total--%></td>
				<td class="default"><font class="category"> [<%=jrb.getMc_value()%>] </font></td>
<%				
				if (jrb.getBrd_dey_yn().equals("y")) {
					out.println("<td class='subject' colspan='7'>삭제된 글입니다</td></tr>");
				} else {
%>
				<td class="subject">
<%
					if (jrb.getRe_level() > 0) {
						int w = jrb.getRe_level() * 10;
%>
					<img alt="" src="../images/level.gif" width="<%=w%>" height="10">
					<img alt="" src="../images/re.gif">
<%
 					}
%>
					<a href="../module/main.jsp?pgm=/recommendBoard/view.jsp?num=<%=jrb.getBrd_no()%>&pageNum=<%=nowPage%>"><%=jrb.getBrd_subject()%></a>
<%
					if (jrb.getBrd_readcount() > 20)
						out.println("<img src='images/hot.gif'>");
%>
				</td>
				<td class="nickname"><%=jrb.getM_nick()%></td>
				<td class="default"><%=jrb.getBrd_reg_date()%></td>
				<td class="default"><%=jrb.getBrd_readcount()%></td>
				<td class="default"><%=jrb.getBrd_recommend()%></td>
			</tr>
			<tr><td colspan="7"><hr></td></tr>
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
			<a href="../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=<%=startPage - pagePerBlock%>">[prev] </a>
			<a href="../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=1">[1]</a>				
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
				<a href="../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%
			}
		}
		if (totalPage > endPage) {
%>
			...
			<a href="../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=<%=totalPage%>">[<%=totalPage%>]</a>
			<a href="../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=<%=startPage + pagePerBlock%>">[next]</a>
<%
		}
%>
		<p>
		<button onclick="location.href='../module/main.jsp?pgm=/recommendBoard/writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>
	</div>

</body>
</html>
