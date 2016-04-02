<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@page import="j_onelineboard.J_OneLineBoard"%>
<%@page import="java.util.List"%>
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

#update{
	position : relative;
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
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	
	
	$(document).ready(function(){
		$(".updateForm").hide();
		$(".replyForm").hide();
		
		$(".btnUpdate").click(function(){
			$(this).parent().hide("slow");
			$(this).parent().parent().next().show("slow");

		});
	});
	
	function replyForm(id){
		var originRow = document.getElementById(id);
		var replyRow = document.getElementById("r" + id);
		originRow.style.display = "none";
		replyRow.style.display = "block";
	}
	
	function deleteChk(brd_no,pageNum){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="../oneLineBoard/deleteOneline.jsp?brd_no="+brd_no+"&pageNum="+pageNum;	
		}else{
			return;
		}
	}
	
	function isUpdateSubmit(m_no) {
 		if(m_no == null || m_no == "" || m_no == "null"){
 			if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")) {
 				location.href = "../module/main.jsp?pgm=/member/login.jsp";
 			} else {
 				return;
 			}
 		}else{
 			document.updateFrm.submit();
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
		style=" border: 1px solid; padding: 10px 10px 10px 10px;"
		class="wrap">
			
		<%
				if (list != null) {
					for (int i = 0 ; i < list.size(); i++) {
						J_OneLineBoard jolb = list.get(i);
		%>
		<div class="row">
			<p><%=total--%>&nbsp;<%=jolb.getM_nick()%>&nbsp;<%=jolb.getBrd_reg_date()%>&nbsp;<%=jolb.getBrd_content()%><a href="javascript:replyForm(<%=i%>)">[<%=jolb.getRep_count()%>]</a>
					<%
						if (m_no != null) {
							if (jolb.getM_no() == Integer.parseInt(m_no)) {
					%> 
								<input type="button" class="btnUpdate" value="수정">
								<a href="javascript:deleteChk(<%=jolb.getBrd_no()%>,<%=pageNum%>)">삭제</a> 
					<%
		 					}
					%> 
								<a href="javascript:replyForm(<%=i%>)">답글</a> 
					<%
						}
					%>
			</p>
		</div>
		<div class="updateForm">
			<form action="../oneLineBoard/updateOneline.jsp" name="updateFrm">
				<p><a>취소</a></p>
					<c:if test="${not empty m_no}">
						<input type="hidden" name="m_no" value="${m_no}">
					</c:if>
						<input type="hidden" name="brd_no" value="<%=jolb.getBrd_no()%>">
					<textarea rows="3" cols="100" maxlength="150" id="updateContent"
						name="brd_content" required="required" onkeyup="textCheck()"><%=jolb.getBrd_content()%></textarea>
					<span id="counter">0/150</span> <input
						style="height: 50px; width: 120px;" type="submit" value="등록"
						onclick="isUpdateSubmit(${m_no})">
			</form>
		</div>
		<div class="replyForm">
			<jsp:include page="replyOneLineForm.jsp" >
				<jsp:param value="<%=jolb.getBrd_no()%>" name="brd_no"/>
				<jsp:param value="<%=pageNum%>" name="pageNum"/>
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
			<strong>
				[<%=i%>]
			</strong>
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