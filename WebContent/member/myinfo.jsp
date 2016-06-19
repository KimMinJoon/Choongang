<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../session/sessionChk.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div class="container">
		<div class="row">
			<div class="col-lg-4 col-md-offset-2 toppad">
				<div class="panel panel-default panel-table">
					<form action="mbupdatePro.temp" name="frm" onsubmit="return chk()" class="form-horizontal">	
						<fieldset>
							<br style="clear: both">
							<h3 style="margin-bottom: 25px; text-align: center;">
								<img alt="pic" src="../images/1P.jpg" height="150">
							</h3>
							<div class="form-group">
								<label for="m_email" class="col-lg-4 control-label"><b>이메일</b></label>
								<div class="col-lg-8">
									<label>${jif.m_email}</label>
								</div>
							</div>
							<div class="form-group">
								<label for="m_nick" class="col-lg-4 control-label"><b>닉네임</b></label>
								<div class="col-lg-8">
									<label>${jif.m_nick}</label>
								</div>
							</div>
							<div class="form-group">
								<label for="c_code" class="col-lg-4 control-label"><b>국적</b></label>
								<div class="col-lg-8">
									<label>${jif.c_value}</label>
								</div>
							</div>
							<div class="form-group">
								<label for="l_code" class="col-lg-4 control-label"><b>희망언어</b></label>
								<div class="col-lg-8">
									<label>${jif.l_value}</label>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>