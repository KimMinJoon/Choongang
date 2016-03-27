<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="sessionChk.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<table class="tab" cellpadding="10" align="center">
		<caption> <h2> Mypage </h2> </caption>
		<tr>
		<td class="c"> <a href="main.jsp?pgm=/member/update.jsp" > 회원정보수정 </a> </td>
		</tr>
		<tr>
		<td class="c"> <a href="main.jsp?pgm=/member/friend.jsp" > 친구/관심글 </a> </td>
		</tr>
		<tr>
		<td class="c"> <a href="main.jsp?pgm=/member/message.jsp" > 쪽지함 </a> </td>
		</tr>
		<tr > 
		<td class="c"> <a href="main.jsp?pgm=/member/secession.jsp"> 탈퇴 </a>
		</td>	
		</tr>
		
	</table>
</body>
</html>