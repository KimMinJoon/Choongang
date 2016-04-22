<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table.listContainer{
	width: 875px;
	border: 1px solid black;
	border-collapse: collapse;
	border-spacing:0;
	margin: 0 auto;
}
table.insertContainer{
	position : relative;
	width: 875px;
	border: 1px solid black;
	border-collapse: collapse;
	border-spacing:0;
	margin: 0 auto;
}
span.counter{
	position: absolute;
	bottom: 11px;
	right: 90px;
	background: rgba(255, 0, 0, 0.5);
	border-radius: 0.5em;
	padding: 0 .5em 0 .5em;
	font-size: 0.75em;
}
.brd_content{
	margin : 5px;
	resize: vertical;
	font-family: Nanum Gothic;
	height: 60px;
}
.writeOne{
	margin : 5px;
	width: 60px;
	height: 60px;
}
</style>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(function(){
		var id = "<%=session.getAttribute("m_no")%>";		
		$.getJSON('http://localhost:8181/${pageContext.request.contextPath}/OnelineJsonList?pageNum=${pageNum}&searchType=${searchType}&searchTxt=${searchTxt}',
				function(data){
			$.each(data,function(){
				var text = (id == this.m_no) ? "<a class='update'>수정</a><a class='delete'>삭제</a>" : "";
				$('.listContainer').append('<tr><td>'+this.m_nick+
					'</td><td>'+this.brd_content+'</td><td>'+
					this.brd_reg_date+"</td><td>"
					+ text +
					"</td></tr>");
			});
		});
		$('.brd_content').keyup(function(){ 
			var text = $('.brd_content').val().length;
			$('.counter').text(text + '/150');			
		});
		/* $('.brd_content').focus(function(){ 
			var text = $('.brd_content').val().length;
			$('.counter').text(text + '/150');			
		}); */
		
	 	$('.writeOne').click(function(){
			//if(number == null || number == "" || number == "null"){
	 		//	if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")) {
	 		//		location.href = "${pageContext.request.contextPath}/member/login.do";
	 		//	} else {
	 		//		return;
	 		//	}
	 		//}else{
	 			$('#writeFrm').attr('action','${pageContext.request.contextPath}/oneLineBoard/write.do').attr('method', 'post').submit();
	 		//}
	 		//return;
		});
		$(document).on("click",".update",function(){
			
		});
	});
	
	function locate(pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		
		$.getJSON("http://localhost:8181/${pageContext.request.contextPath}/OnelineJsonList?pageNum=" + pageNum + "&searchType=" + searchType.value + "&searchTxt=" + searchTxt.value,
				function(data){
			$.each(data,function(){
				var text = (id == this.m_no) ? "<a class='update'>수정</a><a class='delete'>삭제</a>" : "";
				$('.listContainer').append('<tr><td>'+this.m_nick+
					'</td><td>'+this.brd_content+'</td><td>'+
					this.brd_reg_date+"</td><td>"
					+ text +
					"</td></tr>");
			});
		});
	}
	
	
</script>
</head>
<body>
	<table class="insertContainer">
		<tr>
			<td>
				<form id="writeFrm">
					<input type="hidden" name="m_no" value="${sessionScope.m_no}">
					<textarea rows="3" cols="120" maxlength="150" class="brd_content" required="required" name="brd_content"></textarea><span class="counter">0/150</span>
				</form>
			</td>
			<td><button class="writeOne">글쓰기</button></td>
		</tr>
	</table>
	<p>
	<table class="listContainer">
	</table>
	<div align="center" id="pagingandsearch">
			<c:if test="${startPage != 1}">
				<a href="javascript:locate(1)">&lt;&lt;맨 앞으로</a>
			</c:if>
			<c:if test="${startPage > pagePerBlock}">
				<a href="javascript:locate(${startPage - pagePerBlock})">&lt;이전</a>
			</c:if>
 			<c:forEach var="i" begin="${startPage}" end="${endPage}">
 					<a href="javascript:locate(${i})">${i}</a>
			</c:forEach>
			<c:if test="${totalPage > endPage}">
				<a href="javascript:locate(${startPage + pagePerBlock})">다음&gt;</a>
			</c:if>
			<c:if test="${endPage != totalPage}">
				<a href="javascript:locate(${totalPage})">맨 뒤로&gt;&gt;</a>
			</c:if>
			<br>
			<select id="searchType">
				<c:set var="brd_content" value="brd_contents"/>
				<c:if test="${searchType eq brd_content}">
					<option value="brd_content" selected="selected">내용</option>
				</c:if>
				<c:if test="${searchType ne brd_content}">
					<option value="brd_content">내용</option>
				</c:if>
				<c:set var="m_nick" value="m_nick"/>
				<c:if test="${searchType eq m_nick}">
					<option value="m_nick" selected="selected">글쓴이</option>
				</c:if>
				<c:if test="${searchType ne m_nick}">
					<option value="m_nick">글쓴이</option>
				</c:if>
			</select>
			<input type="text" id="searchTxt" value="${searchTxt}">
			<input type="submit" value="검색" onclick="locate(1)">
		</div>
</body>
</html>