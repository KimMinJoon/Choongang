<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/modern-business.css" rel="stylesheet">
<link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<!-- <link rel="stylesheet" type="text/css" href="../css/projectcss.css"> -->
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	function chk() {
		if (frm.check.value == "false") {
			alert("아이디 중복확인을 하세요");
			return false;
		}
		if (frm.m_passwd.value != frm.m_passwd2.value) {
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

	function emailchk() {
		var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if (regex.test(frm.m_email.value) === false) {
			alert("정확한 이메일 형식으로 입력해주세요");
		} else {
			var purl = "../member/emailChk.chk?m_email=" + frm.m_email.value;
			var pname = "emailpopup";
			var pwidth = 300;
			var pheight = 200;
			var pleft = (screen.availWidth - pwidth) / 2;
			var ptop = (screen.availHeight - pheight) / 2;
			var poption = "scrollbars=no,status=no,toolbar=no,resizable=0,location=no,menu=no,"
					+ "width="
					+ pwidth
					+ ",height="
					+ pheight
					+ ",left="
					+ pleft + ",top=" + ptop;
			window.open(purl, pname, poption);
		}
	}
	
	$(function() {
		$('#m_passwd').keydown(function() {
			var re = /s$/;
			var str_space = /\s/;
			if($("#m_passwd").val().length < 6) {
				$('#pass').html("<font>6~20자로 입력</font>");
			} else if(str_space.test($("#m_passwd").val())) {
				$('#pass').html("<font class=red>공백 불가능</font>");
			} else
				$('#pass').html("<font></font>");
		});
	});
	
	$(function() {
		$('#m_nick').keyup(function() { 
			/* #은 밑에 input type id를 말한다. */
			/* 포커스를 잃었을때를 실행하라 */
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
				/* 아이작스를 쓰겟다는 구문 */
				type : "POST",
				url : "nickChk.chk",
				data : {
					"m_nick" : $('#m_nick').val(),
					"m_no" : 0
					/* 아이디 엘레멘트의 값을 엠닉이라 명명하고 url로 보내겟다 */
				},
				success : function(data) {
					if ($.trim(data) == "FALSE") {
						$('#check').html("<font>사용가능</font>");
						frm.nickChk.value = "true";
					} else {
						$('#check').html("<font class=red>사용불가</font>");
						frm.nickChk.value = "false";
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
		<div class="col-md-offset-14 col-md-5">
   			<div class="form-area">
   				<form action="joinPro.do" name="frm" role="form" onsubmit="return chk()">
   					<input type="hidden" name="check" value="false">
   					<input type="hidden" name="nickChk" value="false">
		        	<br style="clear:both">
		        	<h3 style="margin-bottom: 25px; text-align: center;">회원가입</h3>
		        	<strong>이메일:</strong>
					<div class="form-group">
						<input type="email" class="form-control-75" id="m_email" name="m_email" required>
						<input type="button" value="중복체크" onclick="emailchk()">
					</div>
					<div class="form-group">
						<strong>비밀번호:</strong>
						<input type="password" class="form-control" id="m_passwd" name="m_passwd" required maxlength="20">
						<span id="pass"></span>
					</div>
					<div class="form-group">
						<strong>비밀번호 재확인:</strong>
						<input type="password" class="form-control" id="m_passwd2" name="m_passwd2" required maxlength="20">
					</div>
					<div class="form-group">
						<strong>닉네임:</strong>
						<input type="text" class="form-control-60" id="m_nick" name="m_nick" required maxlength="10">
						<span id="check"></span>
					</div>
					<div class="form-group">
						<strong>국적:</strong>
						<div>
							<select name="c_code" class="form-control-60">
							<c:forEach var="jc" items="${list}">
								<c:if test="${jc.c_major eq 'c'}">
								<option value="${jc.c_minor}">
									${jc.c_value}
								</option>
								</c:if>
							</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<strong>희망언어:</strong>
						<div>
							<select name="l_code" class="form-control-60">
							<c:forEach var="jc" items="${list}">
								<c:if test="${jc.c_major eq 'l'}">
									<option value="${jc.c_minor}">
										${jc.c_value}
									</option>
								</c:if>
							</c:forEach>							
							</select>
						</div>
					</div>
					<div style="margin-top: 40px; text-align: center;">
						<button type="submit" id="submit" name="submit" class="btn btn-primary">가입하기</button>
						<!-- <input type="button" value="취소" onclick="history.back(-1)"> -->
					</div>
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>