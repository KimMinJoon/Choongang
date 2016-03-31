<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../css/projectcss.css">
</head>
<body>
	<table border="1" width="100%">
		<caption>공지사항</caption>

		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>조회수</td>
			<td>작성일</td>
			<td>수정일</td>
		</tr>

		<%
			String pageNum = request.getParameter("pageNum");//패이지를 읽어오지않으면!
			J_NoticeBoardDao bd = J_NoticeBoardDao.getInstance();

			int rowPerPage = 10;//한페이지에 보여줄 게시글의 수
			int pagePerBlock = 10;//한페이지에 보여줄 블락의 수 (블락은 10페이지)
			if (pageNum == null || pageNum.equals("null") || pageNum.equals(""))
				pageNum = "1";//페이지는 1이다.
			int nowPage = Integer.parseInt(pageNum);
			int total = bd.selectTotal();
			int totalPage = (int) Math.ceil((double) total / rowPerPage);
			int startRow = (nowPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			int totalBlk = (int) Math.ceil((double) totalPage / pagePerBlock);//총블록 구하기 
			int startPage = (nowPage - 1) / 10 * 10 + 1;
			int endPage = startPage + pagePerBlock - 1;

			if (endPage > totalPage) {
				endPage = totalPage;
			}
			total = total - startRow + 1;
			List<J_NoticeBoard> list = bd.selectList(startRow, endRow);
			if (list != null) {
				for (J_NoticeBoard brd : list) {
		%>
		<tr>
			<td><%=total--%></td>
			<%
				if (brd.getBrd_del_yn().equals("y")) {
			%>
			<td colspan="7">삭제된 글입니다.</td>
			<%
				} else {
			%>
			<td><a
				href="view.jsp?brd_no=<%=brd.getBrd_no()%>&pageNum=<%=nowPage%>"><%=brd.getBrd_subject()%></a>
				<!-- 페이지넘을 가지고 다녀야만이 수정이나 삭제를 할때 페이지가 완료후 되돌아오는 페이지를 수정햇던 페이지로 보낸다.-->
				<%
					if (brd.getBrd_readcount() > 20) {//조회수가 20보다 크면 이미지를 붙여라
									out.println("<img src='images/hot.gif'>");
								}
				%></td>
			<td><%=brd.getBrd_readcount()%></td>
			<!-- 읽은 횟수 -->
			<td><%=brd.getBrd_reg_date()%></td>
			<!-- 작성일 -->
			<td><%=brd.getBrd_update_date()%></td>
			<!-- 수정일 -->
		</tr>
		<%
			}
				}
			} else {
		%>
		<tr>
			<th colspan="7">데이터가 없습니다.</th>
		</tr>
		<%
			}
		%>
	</table>
	<div align="center">
		<%
			if (startPage > pagePerBlock) {
		%>
		<a href="list.jsp?pageNum=<%=startPage - pagePerBlock%>">[이전]</a>
		<%
			}

			for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<!-- i를누르면 pageNum을 가지고 다시 그페이지로 넘어가라 -->
		<%
			}
			if (totalPage > endPage) {
		%>
		<a href="list.jsp?pageNum=<%=startPage + pagePerBlock%>">다음</a>
		<%
			}
		%>
		<br>
		<button onclick="location.href='../noticeBoard/writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>
	</div>
</body>
</html>