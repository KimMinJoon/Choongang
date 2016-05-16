<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<script type="text/javascript">
	function locate(pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		location.href="list.do?pageNum="+pageNum+"&searchType="+searchType.value+"&searchTxt="+searchTxt.value;
	}
</script>
</head>
<body>
	
	<p>
	<p>
	
	<table class="tab" align="center" width="70%" cellspacing="0" cellpadding="0">
		<caption><h2>추천 게시판</h2></caption>
		<tr height="30">
			<th width="3%"></th>
			<th width="10%">말머리</th>
			<th width="31%">제목</th>
			<th width="8%">글쓴이</th>
			<th width="8%">작성일</th>
			<th width="4%">조회</th>
			<th width="4%">추천</th>
		</tr>
		
		<c:set var="tot" value="${total}" />
		<c:if test="${not empty list}">
			<c:forEach var="jrb" items="${list}">
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td class="default">${tot}</td>
				<td class="default">
				<c:if test="${jrb.rc_value eq '말머리 없음'}">
					<font class="category"> </font>
				</c:if>
				<c:if test="${jrb.rc_value ne '말머리 없음'}">
					<font class="category"> [${jrb.rc_value}] </font>
				</c:if>
				</td>
				<td class="subject">
				<c:if test="${jrb.re_level > 0}">
					<c:set var="w" value="${jrb.re_level*10}"></c:set>
					<img alt="" src="../images/level.gif" width="${w}" height="10">
					<img alt="" src="../images/re.gif">
				</c:if>
				<a href="view.do?brd_no=${jrb.brd_no}&pageNum=${nowPage}">${jrb.brd_subject}</a>
				<c:if test="${jrb.brd_readcount > 20}">
					<img src='../images/hot.gif'>
				</c:if>
				</td>
				<td class="nickname">${jrb.m_nick}</td>
				<td class="default">${jrb.brd_reg_date}</td>
				<td class="default">${jrb.brd_readcount}</td>
				<td class="default">${jrb.recocount}</td>
				</tr>
				<tr height="1" bgcolor="#e2e2e2"><td colspan="7"></td></tr>
				<c:set var="tot" value="${tot - 1}"></c:set>
		</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<tr height="1" bgcolor="#e2e2e2"><td colspan="7"></td></tr>
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td colspan="7" class="default">데이터가 없습니다</td>
			</tr>
		</c:if>
	</table>
	
	<br>
		
	<div class="list">
		<c:if test="${startPage > pagePerBlock}">
			<a href="javascript:locate(${startPage-pagePerBlock})">[이전]</a>
			<a href="javascript:locate(1)">[1]</a>				
			...
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:if test="${i eq nowPage}">
				<b class="b">[${i}]</b>
			</c:if>
			<c:if test="${i ne nowPage}">
				<a href="javascript:locate(${i})">[${i}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${totalPage > endPage}">
			...
			<a href="javascript:locate(${totalPage})">[${totalPage}]</a>
			<a href="javascript:locate(${startPage+pagePerBlock})">[다음]</a>
		</c:if>

		<p>
		<button onclick="location.href='writeForm.do?pageNum=${pageNum}'">글쓰기</button>
		
		<p>
		
		<select id="searchType">
			<c:if test="${searchType eq 'all'}">
				<option value="all" selected="selected">제목 + 내용</option>
			</c:if>
			<c:if test="${searchType ne 'all'}">
				<option value="all">제목 + 내용</option>
			</c:if>
				
			<c:if test="${searchType eq 'brd_subject'}">
				<option value="brd_subject" selected="selected">제목</option>
			</c:if>
			<c:if test="${searchType ne 'brd_subject'}">
				<option value="brd_subject">제목</option>
			</c:if>
			
			<c:if test="${searchType eq 'brd_content'}">	
				<option value="brd_content" selected="selected">내용</option>
			</c:if>
			<c:if test="${searchType ne 'brd_content'}">
				<option value="brd_content">내용</option>
			</c:if>
				
			<c:if test="${searchType eq 'm_nick'}">
				<option value="m_nick" selected="selected">글쓴이</option>
			</c:if>
			<c:if test="${searchType ne 'm_nick'}">
				<option value="m_nick">글쓴이</option>
			</c:if>
			</select>
			<input type="text" id="searchTxt" value="${searchTxt}">
			<input type="submit" value="검색" onclick="locate(1)">
	</div>

</body>
</html>
