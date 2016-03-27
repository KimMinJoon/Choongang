<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_board.*,java.util.*"%>
<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="comm.css">
</head><body>
<table border="1"><caption>게시판</caption>
	<tr>
		<th>번호</th><th>제목</th><th>닉네임</th><th>언어</th><th>조회수</th><th>IP</th><th>작성일</th>
	</tr>
<%
	J_BoardDao bd = J_BoardDao.getInstance();

	String pageNum = request.getParameter("pageNum");//패이지를 읽어오지않으면!
	int rowPerPage = 10;//한페이지에 보여줄 게시글의 수
	int pagePerBlock = 10;//한페이지에 보여줄 블락의 수 (블락은 10페이지)
	if (pageNum == null || pageNum.equals("null")||pageNum.equals("")) pageNum = "1";//페이지는 1이다.
	int nowPage = Integer.parseInt(pageNum);
	int total = bd.selectTotal();
	int totalPage = (int)Math.ceil((double)total/rowPerPage);
	int startRow = (nowPage - 1) * rowPerPage + 1;
	int endRow = startRow + rowPerPage - 1;
	int totalBlk = (int)Math.ceil((double)totalPage/pagePerBlock);//총블록 구하기 
	int startPage = (nowPage - 1) / 10 * 10 + 1;
	int endPage = startPage + pagePerBlock - 1;
	if (endPage > totalPage) {
		endPage = totalPage;
	}
	
	total = total - startRow +1;
	List<J_MeetBoard> list = bd.selectList(startRow, endRow);
	if (list != null){
		for(J_MeetBoard brd : list){
%>
	<tr>
		<td><%=total--%></td>
		<%
			if (brd.getBrd_del_yn().equals("y")) {
		%>
		<td colspan="7"> 삭제된 글입니다.</td></tr>
		<%
			}else{
		%>
		<td>
<% 
			//답글 사용시 필요
			/* if (brd.getRe_level() > 0){
				int w = brd.getRe_level() * 10; */
%>
			<%-- <img alt="" src="images/level.gif" width="<%=w%>" height="10">
			<img alt="" src="images/re.gif"> --%>
<%-- <%
		}
%>	 --%>
<a href="view.jsp?num=<%=brd.getBrd_no()%>&pageNum=<%=nowPage %>"><%=brd.getBrd_subject() %></a>
			<!-- 페이지넘을 가지고 다녀야만이 수정이나 삭제를 할때 페이지가 완료후 되돌아오는 페이지를 수정햇던 페이지로 보낸다.--> 
			<%
				if(brd.getBrd_readcount()>20){//조회수가 20보다 크면 이미지를 붙여라
					out.println("<img src='images/hot.gif'>");
				}
			%>
		</td>
		<%-- <td><%=brd.getBrd_writer() %></td> --%>
		<%-- <a href="mailto:<%=brd.getEmail() %>"> --%>
		<td><%=brd.getM_nick() %></td>
		<td><%=brd.getBrd_language() %></td>
		<td><%=brd.getBrd_readcount() %></td>
		
		<td><%=brd.getBrd_ip() %></td>
		
		<td><%=brd.getBrd_reg_date()%></td>
		
	</tr>		
<%	
		}} 
	} else{
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
	<a href="list.jsp?pageNum=<%=startPage-pagePerBlock%>">[이전]</a>
<%
	}

	for(int i = startPage; i <= endPage; i++){
%>
	<a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>
	<!-- i를누르면 pageNum을 가지고 다시 그페이지로 넘어가라 -->
<%
	}
	if (totalPage > endPage) {
%>
	<a href="list.jsp?pageNum=<%=startPage+pagePerBlock%>">다음</a>
<%
	}
%>
	<br><button onclick="location.href='writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>
</div>
</body>
</html>