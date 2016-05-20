<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/modern-business.css" rel="stylesheet">
<link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div class="container">
		<div class="col-md-offset-13 col-md-3">
   			<div class="form-area">
	       		<form role="form" action="loginPro.do">
		        	<br style="clear:both">
		        	<h3 style="margin-bottom: 25px; text-align: center;">Welcome back.</h3>
					<div class="form-group">
						<input type="text" id="m_email" name="m_email" class="form-control-100 input-sm chat-input" placeholder="이메일" />
						<br>
						<input type="password" id="m_passwd" name="m_passwd" class="form-control-100 input-sm chat-input" placeholder="비밀번호" />
						<br>
					</div>
					<div class="wrapper">
						<span class="group-btn">
							<input type="submit" class="btn btn-primary btn-md" value="로그인">
						</span>
						<p>
					</div>
					<div align="center">
					<b style="text-decoration: underline;"><a href="join.do">회원가입</a></b>
					</div>
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>