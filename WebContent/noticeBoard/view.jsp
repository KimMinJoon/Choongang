<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
</head>
<body>
	<c:set var="admin" value="${sessionScope.m_no}" />
	<table border="1" width="70%" align="center">
		<caption>
			<h2>게시판 보기</h2>
		</caption>
		<tr>
			<th>제목</th>
			<td>${jnb.brd_subject}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${jnb.brd_readcount}</td>
		</tr>
		<c:if test="${not empty jnb.brd_update_date}">
			<tr>
				<th>작성일</th>
				<td>${jnb.brd_reg_date}</td>
			</tr>
			<tr>
				<th>최근수정일</th>
				<td>${jnb.brd_reg_date}</td>
			</tr>
		</c:if>
		<c:if test="${empty jnb.brd_update_date}">
			<tr>
				<th>작성일</th>
				<td>${jnb.brd_reg_date}</td>
			</tr>
		</c:if>
		<tr>
			<th>내용</th>
			<td><pre>${jnb.brd_content}</pre></td>
			<!-- pre는 입력한 내용을 잇는 그래도 보여줌  -->
		</tr>
	</table>
	<p>
	<div align="center">
		<button
			onclick="location.href='../noticeBoard/list.do?pageNum=${pageNum}'">
			목록</button>
		<c:if
			test="${admin eq '1'}">
			<button
				onclick="location.href='../noticeBoard/updateForm.do?brd_no=${brd_no}&pageNum=${pageNum}'">수정</button>
			<!-- 이렇게해야 수정을 누르면 수정클릭한 해당 페이지로 보내준다. -->
			<button
				onclick="location.href='../noticeBoard/deleteForm.do?brd_no=${brd_no}&pageNum=${pageNum}'">삭제</button>
		</c:if>
	</div>
</body>
</html>