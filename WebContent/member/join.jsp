<!--
<회원가입 폼 jsp>
1. 중복체크
중복체크 버튼을 누르면 위의 스크립트 emailchk()로 갔다가 팝업창을 열고
팝업창은 url로 emailchk.jsp를 실행
(emailchk.jsp는 아직 구현 못했습니다.)

2. 확인
확인 버튼을 누르면 joinPro.jsp를 실행
(joinPro.jsp는 아직 구현 못했습니다.)
joinPro.jsp가 성공하면 회원가입 성공.

마지막 수정날짜 : 2016-03-22 오전 10:00
마지막 수정한 사람 : 곽지은
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_code.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	function chk() {
		if (frm.m_passwd.value != frm.m_passwd2.value) {
			alert("암호를 다시 입력하세요");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
		}
		if(frm.check.value == "false") {
			alert("아이디 중복확인을 하세요");
			return false;
		}
		return true;
	}
		
	function emailchk() {
		var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
		if(regex.test(frm.m_email.value) === false) {
			alert("정확한 이메일 형식으로 입력해주세요");
		} else {
		var purl = "../member/emailchk.jsp?m_email=" + frm.m_email.value;
		var pname = "emailpopup";
		var pwidth = 300;
		var pheight = 200;
		var pleft = (screen.availWidth - pwidth) / 2;
		var ptop = (screen.availHeight - pheight) / 2;
		var poption = "scrollbars=no,status=no,toolbar=no,resizable=0,location=no,menu=no,"
				+ "width=" + pwidth + ",height=" + pheight + ",left=" + pleft + ",top=" + ptop;
		window.open(purl, pname, poption);
		}
	}
	$(function(){
	      $('#m_nick').blur(function(){
	         $.ajax({
	            type:"POST",
	            url:"../member/nickchk.jsp",
	            data:{
	               "m_nick":$('#m_nick').val()
	            },
	            success:function(data){
	               if($.trim(data)=="TRUE"){
	                  $('#check').html("사용가능");
	               }else{
	                  $('#check').html("사용불가");
	               }
	            }
	         });
	      });
	   });
</script>
</head>
<body>

	<%
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList(0);
	%>

	<form action="../member/joinPro.jsp" name="frm" onsubmit="return chk()">
	<input type="hidden" name="check" value="false">
		<table class="tab" cellpadding="10" align="center">
			<caption>
				<h2>회원가입</h2>
			</caption>
			<tr height="50">
				<td class="join1"><font class="red">*</font>이메일</td>
				<td><input type="email" name="m_email" required="required">
					<input type="button" value="중복체크" onclick="emailchk()"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>암호</td>
				<td><input type="password" name="m_passwd" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>암호확인</td>
				<td><input type="password" name="m_passwd2" required="required"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>닉네임</td>
				<td><input type="text" name="m_nick" id="m_nick" required="required" maxlength="10">
				<span id="check"></span>
				</td>
			</tr>
			<tr height="50">
				<td class="join1">국적</td>
				<td><select name="c_code">
						<option value="0">해당없음</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("c")) {
						%>
						<option value=<%=jc.getC_minor()%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
				</select></td>

			</tr>
			<tr height="50">
				<td class="join1">희망언어</td>
				<td><select name="l_code">
						<option value="0">해당없음</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value=<%=jc.getC_minor()%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">
					&nbsp; <input type="button" value="취소" onclick="history.back(-1)">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>