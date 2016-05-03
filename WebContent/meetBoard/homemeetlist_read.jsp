<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>
<body>

	<p>
	<p>

	<table class="tab" align="center" width="80%" cellspacing="0" cellpadding="0">
		<caption>
			<h4>조회수 많은 게시물 5개</h4>
		</caption>
		<tr height="30">
			<th width="31%">제목</th>
			<th width="8%">글쓴이</th>
			<th width="8%">작성일</th>
			<th width="4%">조회수</th>
			<th width="4%">추천수</th>
		</tr>
		<c:forEach var="brd" items="${list3 }">
		<c:if test="${ not empty list3}">
				<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
					<td class="subject"><a href="../meetBoard/view.do?brd_no=${brd.brd_no}">
							${brd.brd_subject}</a> 
						<c:if test="${ brd_readcount > 10}">
							<img src='../images/hot.gif'>
						</c:if>
					</td>
					<td class="nickname">${brd.m_nick}</td>
			
					<td class="default">${brd.brd_reg_date}</td>

					<td class="default">${brd.brd_readcount}</td>

					<td class="default">${brd.brd_recommend}</td>
			</tr>
		</c:if>
		<tr height="1" bgcolor="#e2e2e2"><td colspan="8"></td></tr>
		
		<c:if test="${empty list3 }">
			<tr height="1" bgcolor="#e2e2e2"><td colspan="5"></td></tr>
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td colspan="7" class="default">데이터가 없습니다</td>
			</tr>
		</c:if>
		</c:forEach>
	</table>
</body>
</html>