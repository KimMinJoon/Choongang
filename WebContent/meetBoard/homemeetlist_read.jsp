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

	<table width="100%" class="text-center">
		<caption>
			<h4 class="modal-header">조회수 많은 게시물 5개</h4>
		</caption>
		<tr>
			<td width="65%">제목</td>
			<td width="20%">글쓴이</td>
			<td width="15%">조회수</td>
		</tr>
		<c:forEach var="brd" items="${list3 }">
		<c:if test="${ not empty list3}">
				<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
					<td class="text-left">
						<a href="../meetBoard/view.do?brd_no=${brd.brd_no}">${brd.brd_subject}</a>
					</td>
					<td>${brd.m_nick}</td>
					<td>${brd.brd_readcount}</td>
			</tr>
		</c:if>
		<tr height="1" bgcolor="#e2e2e2"><td colspan="3"></td></tr>
		
		<c:if test="${empty list3 }">
			<tr height="1" bgcolor="#e2e2e2"><td colspan="3"></td></tr>
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td colspan="3">데이터가 없습니다</td>
			</tr>
		</c:if>
		</c:forEach>
	</table>
</body>
</html>