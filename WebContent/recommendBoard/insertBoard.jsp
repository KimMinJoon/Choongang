<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		J_RecommendBoardDao bd = J_RecommendBoardDao.getInstance();
		int ref = 0, re_step = 0, re_level = 0;
		String ip = request.getRemoteAddr();

		for (int i = 0; i <= 10000; i++) {
			J_RecommendBoard jrb = new J_RecommendBoard();
			jrb.setBrd_subject("bobby♥ bobby♥ bobby♥ bobby♥ bobby♥" + i);
			jrb.setBrd_content("♥♥♥♥♥♥♥♥♥♥" + i);
			jrb.setBrd_ip(ip);
			jrb.setRef(ref);
			jrb.setRe_level(re_level);
			jrb.setRe_step(re_step);
			jrb.setM_no(1);
			jrb.setMc_code("mc_exlang");
			jrb.setL_code("l_default");
			bd.insert(jrb);
		}
	%>
	성공
</body>
</html>