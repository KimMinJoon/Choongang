<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function dechk() {
		var aa = confirm("정말로 탈퇴하시겠습니까?");
		if (aa) {
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body>
	
	<div class="container">
		<div class="col-lg-4 col-md-offset-2 toppad">
			<div class="panel panel-default panel-table">
				<form name="frm" action="mbdeletePro.temp" method="post" onsubmit="return dechk()">
					<input type="hidden" name="m_no" value="${no}">
					<input type="hidden" name="dbPass" value="${dbPass}">						
					<br style="clear: both">
					<h3 style="margin-bottom: 25px; text-align: center;">
						<em class="fa fa-trash"></em>
					</h3>
					<h6 style="margin-bottom: 25px; text-align: center;">
						정말로 탈퇴하시겠습니까?
					</h6>
					<div class="form-group text-center">
						<input type="password" name="m_passwd" maxlength="50" placeholder="비밀번호를 입력해 주세요."
							autofocus="autofocus" required>
					</div>
					<div class="panel-footer text-center">
						<span>
							<button type="submit" class="btn btn-sm btn-danger">
								탈퇴
							</button>
							<input type="button" value="취소" class="btn btn-sm btn-default" onclick="location.href='../module/main.jsp?pgm=/member/mypagetemp.jsp'">
						</span>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>