<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/modern-business.css" rel="stylesheet">
<link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	function chk() {
		if(frm.m_passwd.value != frm.m_passwd2.value) {
			alert("비밀번호를 다시 입력하세요");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
		}
		if(frm.m_passwd.value.length < 6) {
			alert("비밀번호는 6~20자로 입력해주세요");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
		}
		if(frm.m_passwd.value.indexOf(" ")>=0) {
			alert("비밀번호는 공백없이 입력해 주세요.");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
	    }
		if(frm.m_nick.value.length < 2) {
			alert("닉네임은 2~10자로 입력해주세요");
			frm.m_nick.value = "";
			frm.m_nick.focus();
			return false;
		}
		if(frm.m_nick.value.indexOf(" ")>=0) {
			alert("닉네임은 공백없이 입력해 주세요.");
			frm.m_nick.value = "";
			frm.m_nick.focus();
			return false;
	    }
		var regex = /^[가-힝A-Za-z0-9]{2,10}$/;
		if (regex.test(frm.m_nick.value) === false) {
			alert("닉네임이 한글 또는 영문 또는 숫자가 아닙니다. ");
			frm.m_nick.value = "";
			frm.m_nick.focus();
			return false;
		}
		if (frm.nickChk.value == "false") {
			alert("닉네임을 다시 확인하세요");
			frm.m_nick.focus();
			return false;
		}
		return true;
	}
	
	$(function() {
		$('#m_nick').keyup(function() {
			var regex = /^[가-힝A-Za-z0-9]{2,10}$/;
			var str_space = /\s/;
			if (regex.test($('#m_nick').val()) === false) {
				$('#check').html("<font>한글,영문,숫자 2~10자</font>");
				if($("#m_nick").val().length < 2) {
					$('#check').html("<font>2~10자로 입력</font>");
				}
				if(str_space.test($('#m_nick').val())) {
					$('#check').html("<font class=red>공백 불가능</font>");
				}
			}else {
			$.ajax({
				type : "POST",
				url : "../member/nickChk.chk",
				data : {
					"m_nick" : $('#m_nick').val(),
					"m_no" : $('#m_no').val()
				},
				success : function(data) {
					if ($.trim(data) == "FALSE") {
						$('#check').html("<font>사용가능</font>");
						frm.nickChk.value = "true";
					} else if($.trim(data) == "TRUE"){
						$('#check').html("<font class=red>사용불가</font>");
						frm.nickChk.value = "false";
					} else {
						$('#check').html("<font></font>");
						frm.nickChk.value = "true";
					}						
				}
			});
			}
		});
	});
</script>
</head>
<body>
	
	<div class="container">
		<div class="row">
			<div class="col-lg-4 col-md-offset-2 toppad">
				<div class="panel panel-default panel-table">
					<form action="mbupdatePro.temp" name="frm" onsubmit="return chk()" class="form-horizontal">
						<input type="hidden" name="check" value="false">
						<input type="hidden" name="nickChk" value="false">
						<input type="hidden" name="m_no" id="m_no" value="${m_no}">
						<fieldset>
							<br style="clear: both">
							<h3 style="margin-bottom: 25px; text-align: center;">
								<em class="fa fa-pencil"></em>
							</h3>
							<div class="form-group">
								<label for="m_email" class="col-lg-4 control-label"><b>이메일</b></label>
								<div class="col-lg-8">
									<input type="hidden" name="m_email" value="${jm.m_email}"> <label>${jm.m_email}</label>
								</div>
							</div>
							<div class="form-group">
								<label for="m_passwd" class="col-lg-4 control-label"><b>비밀번호</b></label>
								<div class="col-lg-8">
									<input type="password" name="m_passwd" id="m_passwd" value="${jm.m_passwd}" required="required" maxlength="20">
									<span id="pass"> </span>
								</div>
							</div>
							<div class="form-group">
								<label for="m_passwd2" class="col-lg-4 control-label"><b>재확인</b></label>
								<div class="col-lg-8">
									<input type="password" name="m_passwd2" required="required" maxlength="20">
								</div>
							</div>
							<div class="form-group">
								<label for="m_nick" class="col-lg-4 control-label"><b>닉네임</b></label>
								<div class="col-lg-8">
									<input type="text" name="m_nick" id="m_nick" value="${jm.m_nick}" required="required" maxlength="10">
									<br>
									<span id="check"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="c_code" class="col-lg-4 control-label"><b>국적</b></label>
								<div class="col-lg-8">
									<select name="c_code" class="form-control-30">
									<c:forEach var="jc" items="${list}">
									<c:if test="${jc.c_major eq 'c'}">
										<option value="${jc.c_minor}"
										<c:if test="${jc.c_minor == jm.c_code}">
										selected
										</c:if>>
										${jc.c_value}
										</option>
									</c:if>
									</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="l_code" class="col-lg-4 control-label"><b>희망언어</b></label>
								<div class="col-lg-8">
									<select name="l_code" class="form-control-30">
									<c:forEach var="jc" items="${list}">
									<c:if test="${jc.c_major eq 'l'}">
										<option value="${jc.c_minor}"
										<c:if test="${jc.c_minor == jm.l_code}">
											selected
										</c:if>>
											${jc.c_value}
										</option>
									</c:if>
									</c:forEach>
									</select>
								</div>
							</div>
							<div class="panel-footer text-center">
								<span>
									<button type="submit" class="btn btn-sm btn-default"> 수정  </button>
									<input type="button" class="btn btn-sm btn-default" value="취소" onclick="location.href='../module/main.jsp?pgm=/member/mypagetemp.jsp'">
								</span>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>