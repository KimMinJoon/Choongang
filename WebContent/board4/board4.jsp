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
    width: 95%;
    position: relative;
    display: inline-block;
}
.wrap textarea {
    width: 80%;
    resize: none;
    min-height: 4.5em;
    line-height:1.6em;
    max-height: 9em;
    vertical-align: top;
}
.wrap span {
    position: absolute;
    bottom: 5px;
    right: 5px;
}
#counter {
  background:rgba(255,0,0,0.5);
  border-radius: 0.5em;
  padding: 0 .5em 0 .5em;
  font-size: 0.75em;
}
</style>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<!-- jquery 사용 -->
<script type="text/javascript">
$(function() {
    $('#content').keyup(function (e){ //textarea 에 keyup 이벤트 발생시
        var content = $(this).val();
        $('#counter').html(content.length + '/300'); //입력한 텍스트 수를 받아 span 에 출력
    });
    $('#content').keyup(); 
    	//키업 이벤트가 최초 한번은 발생한 상태로 있음
    	//span 에 0/300 으로 출력되기 위함
});
</script>
</head>
<body>
	<div style="border: 3px solid; border-style: inset; padding: 10px 10px 10px 10px;" class="wrap">
		<form name="wrtierFrm" onsubmit="return chk()">
			<input type="hidden" name="" value="id"><!-- 세션값을 가져와서 담음 -->
			<textarea rows="3" cols="100" maxlength="300" id="content" name="brd_content" ></textarea>
			<span id="counter"></span>
			<input style="height:50px; width:160px;" type="submit" value="등록">
		</form>
		
	</div> 
	<div style="height:500px; border: 3px solid; border-style: inset; padding: 10px 10px 10px 10px;" class="wrap">
		list
	</div>
</body>
</html>