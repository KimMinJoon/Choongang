<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*" errorPage="/error/DBError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.onload = function(){
		var m_no = <%= (String) session.getAttribute("m_no")%>;
		if (m_no == null || m_no == "" || m_no == "null") {
			alert("로그인이 필요한 페이지 입니다.");
			 location.href="../module/main.jsp?pgm=/member/login.jsp";
		}
	}
</script>
</head>
<body>
	<jsp:useBean id="mb" class="j_member.J_Member"></jsp:useBean>
	<jsp:setProperty property="*" name="mb" />
	<%
		J_MemberDao mdo = J_MemberDao.getInstance();
		int result = mdo.update(mb);
		if (result > 0) {
	%>
	<script type="text/javascript">
		alert("수정 완료");
		location.href = "../module/main.jsp?pgm=/member/mypagetemp.jsp";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("수정 실패");
		history.go(-1);
	</script>
	<%
		}
	%>
</body>
</html>