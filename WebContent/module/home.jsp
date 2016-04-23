<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
	/* 에이작스로 두에서 뷰를 받아서 뿌려버림 개 편리하고 좋음 */
	$(function() {
		var sendData = 'pageNum=${pageNum}'; 
		$.post('${pageContext.request.contextPath}/meetBoard/homemeetlist_new.chk',sendData,function(data){
			$('#homemeetlist_new').html(data);
		});
	});
	
	 $(function() {
		var sendData = 'pageNum=${pageNum}'; 
		$.post('${pageContext.request.contextPath}/meetBoard/homemeetlist_reco.chk',sendData,function(data){
			$('#homemeetlist_reco').html(data);
		});
	});
	
	$(function() {
		var sendData = 'pageNum=${pageNum}'; 
		$.post('${pageContext.request.contextPath}/meetBoard/homemeetlist_read.chk',sendData,function(data){
			$('#homemeetlist_read').html(data);
		});
	});
</script>

</head>
<body>
	<center>
	<h2> 자바기반 웹개발자 양성과정 </h2>
	<br>
	<img alt=""	src="http://wp.firenzelodging.it/wp-content/uploads/2011/10/language-exchange.jpg" height="300">
	<p>
	처음 나오는 메인 화면 또는 Web_Project를 눌렀을때 나오는 메인화면(최신글, 좋아요 많은 글, 공지사항 등)
	<br>
	일단 home이라고 할게요.
	<table>
		<tr>
			<td id="homemeetlist_new"></td>
			<td id="homemeetlist_reco"></td>
			<td id="homemeetlist_read"></td>
		</tr>
	</table>
	</center>
</body>
</html>