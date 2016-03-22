<!--
<로그인 폼 jsp>
1. 확인
확인 버튼을 누르면 loginPro.jsp를 실행
(loginPro.jsp는 아직 구현 못했습니다.)
loginPro.jsp가 성공하면 로그인 성공. (+로그인 되면 마이페이지, 로그아웃 생기게 세션 작업)

마지막 수정날짜 : 2016-03-22 오전 10:09
마지막 수정한 사람 : 곽지은
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	<form action="../member/loginPro.jsp" name="frm">
		<table class="tab" cellpadding="10" align="center">
			<caption>
				<h2>로그인</h2>
			</caption>
			<tr>
				<td><input type="text" name="id" placeholder="아이디" required="required"></td>
			</tr>
			<tr>
				<td><input type="password" name="password" placeholder="비밀번호" required="required"></td>
			</tr>
			<tr>
				<td align="center"><input type="submit" value="확인"></td>
			</tr>
		</table>
	</form>

	<p>
	<div align="center">
		<a href="main.jsp?pgm=/member/join.jsp">
		<font style="text-decoration: underline;" size="2"> 회원가입 </font>
		</a>
	</div>

</body>
</html>