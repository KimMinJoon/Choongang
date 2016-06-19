<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
	
	<table class="table text-center">
		<caption>
			<h3 class="modal-header" style="font-size: 18px;">#추천수 많은 모임</h3>
		</caption>
		<tr>
			<th width="62%">제목</th>
			<th width="20%">글쓴이</th>
			<th width="15%">추천수</th>
		</tr>
		<c:forEach var="brd" items="${list1 }">
		<c:if test="${ not empty list1}">
				<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
					<td class="text-left">
						<a href="../meetBoard/view.do?brd_no=${brd.brd_no}">${brd.brd_subject}</a> 
					</td>
					<td>${brd.m_nick}</td>
					<td>${brd.brd_recommend}</td>
			</tr>
		</c:if>
		</c:forEach>
		<c:if test="${empty list1 }">
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td colspan="3">데이터가 없습니다</td>
			</tr>
		</c:if>
	</table>
</body>
</html>