<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../css/projectcss.css">
</head>
<body>

	<!-- Page Content -->
    <div class="container">

        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Notice
                    <small>공지사항</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../module/main.jsp">Home</a>
                    </li>
                    <li class="active">Notice</li>
                </ol>
            </div>
        </div>
	</div>
	
	<p>
	<p>
	
	<table class="tab" align="center" width="50%">
		<tr height="30">
			<th width="2%"> </th>
			<th width="34%">제목</th>
			<th width="8%">작성일</th>
			<th width="6%">조회수</th>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="brd" items="${list}">
				<tr height="1" bgcolor="#e2e2e2"><td colspan="4"></td></tr>
				<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
					<td></td>
					<td class="subject">
						<a href="../noticeBoard/view.do?brd_no=${brd.brd_no}&pageNum=${nowPage}">${brd.brd_subject}</a>
					</td>
					<td class="default">
						${brd.brd_reg_date}
					</td>
					<td class="default">
						${brd.brd_readcount}
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<tr height="1" bgcolor="#e2e2e2"><td colspan="7"></td></tr>
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td colspan="4" class="default">데이터가 없습니다</td>
			</tr>
		</c:if>
	</table>
	
	<br>
	
	<div align="center">
		<c:if test="${startPage > pagePerBlock}">
			<a href="../noticeBoard/list.do?pageNum=${startPage-pagePerBlock}">[이전]</a>
			<a href="../noticeBoard/list.do?pageNum=1">[1]</a>
			...
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:if test="${i == nowPage}">
				<b class="b">[${i}]</b>
			</c:if>
			<c:if test="${i != nowPage}">
				<a href="../noticeBoard/list.do?pageNum=${i}">[${i}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${totalPage > endPage }">
			...
			<a href="../noticeBoard/list.do?pageNum=${totalPage}">[${totalPage}]</a>
			<a href="../noticeBoard/list.do?pageNum=${startPage+pagePerBlock}">[다음]</a>
		</c:if>
		<p>
		<p>
		<c:set var="admin" value="${sessionScope.m_no}"/>
		<c:if test="${admin eq '1'}">
			<button	onclick="location.href='../noticeBoard/writeForm.do?pageNum=${pageNum}'">글쓰기</button>
		</c:if>
	</div>
</body>
</html>