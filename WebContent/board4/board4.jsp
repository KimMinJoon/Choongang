<!-- 
<한줄게시판 입력창과 리스트를 보이는 jsp>

마지막 수정날짜 : 2016-03-24 오전 09:16
마지막 수정한 사람 : 이재설
 -->
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
<body>
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;"
		class="wrap">
		<form action="insertOneline.jsp" name="wrtierFrm">
<!-- 			onsubmit="return isSubmit()"> -->
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
		class="wrap">list</div>

</body>
</html>