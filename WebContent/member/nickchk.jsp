<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_member.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String m_nick = request.getParameter("m_nick");
	String str = "";
	J_MemberDao jm = J_MemberDao.getInstance();
	int result = jm.nickChk(m_nick);
	if(result > 0) {
		str = "FALSE";
	}else{
		str = "TRUE";
	}
	out.print(str);
%>