<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@page import="j_onelineboard.J_OneLineBoard"%>
<%@page import="j_board.J_Board"%>
<%@page import="java.util.List"%>
<%@page import="j_board.J_BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.wrap {
	width: 70%;
	position: relative;
	display: inline-block;
}

.wrap textarea {
	width: 80%;
	resize: none;
	min-height: 4.5em;
	line-height: 1.6em;
	max-height: 9em;
	vertical-align: top;
}

.wrap span {
	position: absolute;
	bottom: 5px;
	right: 5px;
}

#counter {
	background: rgba(255, 0, 0, 0.5);
	border-radius: 0.5em;
	padding: 0 .5em 0 .5em;
	font-size: 0.75em;
}
</style>
<%
		String m_no = (String) session.getAttribute("m_no");	
	
		int rowPerPage = 10;
		int pagePerBlock = 10;
		int nowPage = 0;
		String pageNum = request.getParameter("pageNum");

		if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
			pageNum = "1";
		}
		nowPage = Integer.parseInt(pageNum);

		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int total = jobd.selectTotal();

		int totalPage = (int) Math.ceil((double) total / rowPerPage);
		int startRow = (nowPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
		int startPage = (nowPage - 1) / 10 * 10 + 1;
		int endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		total = total - startRow + 1;

		List<J_OneLineBoard> list = jobd.selectOneLine(startRow, endRow);
%>
<script type="text/javascript">
	function udpateForm(id){
		var originRow = document.getElementById(id);
		var updateRow = document.getElementById("u" + id);
		alert(<%=startRow + list.size()%>);
		for(var i = <%=startRow%>; i < <%=startRow + list.size()%>;i++){
			var oRow = document.getElementById(i);
			var uRow = document.getElementById("u" + i);
			oRow.style.display = "block";
			uRow.style.display = "none";
		}
		originRow.style.display = "none";
		updateRow.style.display = "block";
	}
	
	function deleteChk(brd_no){
		
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="deleteOneline.jsp?brd_no="+brd_no;	
		}else{
			return;
		}
	}
</script>
</head>
<body>
	
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;"
		class="wrap">
		<jsp:include page="insertOneLineForm.jsp"/>
	</div>
	<p>
	<div
		style="height: 500px; border: 1px solid; padding: 10px 10px 10px 10px;"
		class="wrap">
		<%
				if (list != null) {
					for (J_OneLineBoard jolb : list) {
		%>
		<div id="<%=jolb.getBrd_no()%>">
			<p><%=jolb.getM_nick()%><%=jolb.getBrd_reg_date()%><%=jolb.getBrd_content()%>
					<%
						if (m_no != null) {
							if (jolb.getM_no() == Integer.parseInt(m_no)) {
					%> 
								<a href="javascript:udpateForm(<%=jolb.getBrd_no()%>);">수정</a> 
								<a href="javascript:deleteChk(<%=jolb.getBrd_no()%>)">삭제</a> 
					<%
		 					}
					%> 
								<a href="">답글</a> 
					<%
						} else {
					%> 
							<a href="">답글</a> 
					<%
						}
					%>
			</p>
		</div>
		<div id="<%="u" + jolb.getBrd_no()%>" style="display: none;">
			<jsp:include page="updateOneLineForm.jsp">
				<jsp:param value="<%=jolb.getBrd_no()%>" name="brd_no"/>
			</jsp:include>
		</div>
			<%

							}
						}
			%>
		<div align="center">
			<%
				if (startPage != 1) {
			%>
			<a href="main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum=1">&lt;&lt;맨
				앞으로</a>
			<%
				}
				if (startPage > pagePerBlock) {
			%>
			<a
				href="main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum=<%=startPage - pagePerBlock%>">&lt;이전</a>
			<%
				}
			%>
			<%
				for (int i = startPage; i <= endPage; i++) {
					if (nowPage != i) {
			%>
			<a href="main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum=<%=i%>"><%=i%></a>
			<%
				} else {
			%>
			<strong><a
				href="main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum=<%=i%>">[<%=i%>]
			</a></strong>
			<%
				}
				}
				if (totalPage > endPage) {
			%>
			<a
				href="main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum=<%=startPage + pagePerBlock%>">다음&gt;</a>
			<%
				}
			%>
			<%
				if (endPage != totalPage) {
			%>
			<a
				href="main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum=<%=totalPage%>">맨
				뒤로&gt;&gt;</a>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>