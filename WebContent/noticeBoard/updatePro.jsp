<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<jsp:useBean id="noticeboard" class="j_noticeboard.J_NoticeBoard"></jsp:useBean>
	<jsp:setProperty property="*" name="noticeboard" />
	<%
		String pageNum = request.getParameter("pageNum");
		J_NoticeBoardDao bd = J_NoticeBoardDao.getInstance();
		int result = bd.update(noticeboard);
		System.out.print("result : " + result);
		if (result > 0) {
	%>
	<script type="text/javascript">
		alert("수정 성공");
		location.href="../noticeBoard/list.jsp?pageNum=<%=pageNum%>";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("잘해!");
		history.go(-1);
	</script>
	<%
		}
	%>
</body>
</html>