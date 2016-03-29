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
<script type="text/javascript">
	function textCheck() {
		var counter = document.getElementById("counter");
		var content = document.getElementById("content");
		counter.innerHTML = content.value.length + "/150";
	}

/* 	function isSubmit() { 
		if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")) {
			location.href = "../module/main.jsp?pgm=/member/login.jsp";
		} else {
			return;
		}
	} */
</script>
</head>
<%
	J_BoardDao jbd = J_BoardDao.getInstance();
	List<J_Board> list = jbd.selectOneLine();
%>
<body>
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;"
		class="wrap">
		<form action="insertOneline.jsp" name="wrtierFrm">
<!-- 			onsubmit="return isSubmit()"> -->
			<input type="hidden" name="b_code" value="olb">
			<input type="hidden" name="brd_subject" value="oneline">
			<c:if test="${not empty m_no}">
				<input type="hidden" name="m_no" value="${m_no}">
			</c:if>
			<input type="hidden" name="m_no" value="1">
			<!-- 세션값을 가져와서 담음 -->
			<textarea rows="3" cols="100" maxlength="150" id="content"
				name="brd_content" required="required" onkeyup="textCheck()"></textarea>
			<span id="counter">0/150</span> <input
				style="height: 50px; width: 120px;" type="submit" value="등록">
<!-- 				onclick="isSubmit()"> -->
		</form>
	</div>
	<p>
	<div
		style="height: 500px; border: 1px solid; border-style: inset; padding: 10px 10px 10px 10px;"
		class="wrap">
		<c:if test="${empty list}">
			
		</c:if>
		<c:if test="${not empty list}">
			
		</c:if>
	</div>

</body>
</html>