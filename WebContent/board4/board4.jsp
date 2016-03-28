<!-- 
<한줄게시판 입력창과 리스트를 보이는 jsp>

마지막 수정날짜 : 2016-03-24 오전 09:16
마지막 수정한 사람 : 이재설
 -->
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		var counter = document.getElementById("counter"); //id로 span 접근
		var content = document.getElementById("content"); //id로 textarea 접근
		counter.innerHTML = content.value.length + "/150"; //span 에 textarea 의 글자수를 세어 출력
	}
</script>
</head>
<body>

	<div style="border: 1px solid; padding: 10px 10px 10px 10px;" class="wrap">
		<form action="insertOnline.do" name="wrtierFrm" onsubmit="return chk()">
			<input type="hidden" name="" value="id">
			<!-- 세션값을 가져와서 담음 -->
			<textarea rows="3" cols="100" maxlength="150" id="content" name="brd_content" onkeyup="textCheck()"></textarea>
			<span id="counter">0/150</span>
			<input style="height: 50px; width: 120px;" type="submit" value="등록">
		</form>
	</div>
	<p>
	<div style="height: 500px; border: 1px solid; border-style: inset; padding: 10px 10px 10px 10px;" class="wrap">list</div>

</body>
</html>