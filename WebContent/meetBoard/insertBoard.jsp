<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_meetboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		int ref = 0, re_step = 0, re_level = 0;
		String ip = request.getRemoteAddr();//아이피주소를 남기기위해 씀
		for (int i = 0; i <= 1000; i++) {
			J_MeetBoard meetboard = new J_MeetBoard();
			meetboard.setBrd_subject("모임게시판 제목"+i);
			meetboard.setBrd_content("모임게시판 내용"+i);
			 meetboard.setBrd_ip("127.0.0.1");
			 meetboard.setM_no(2);
			 meetboard.setMc_code("mc_study");
			 meetboard.setL_code("kr");
			bd.insert(meetboard);
		}
	%>
성공
</body>
</html>