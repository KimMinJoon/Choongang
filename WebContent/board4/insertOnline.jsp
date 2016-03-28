<%@page import="j_board.J_BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../session/sessionChk.jsp" %>
<jsp:useBean id="job" class="j_board.J_OnelineBoard"/>
<jsp:setProperty property="*" name="job"/>
<%
	String brd_content = request.getParameter("brd_content");
	J_BoardDao jbd = J_BoardDao.getInstance();
	int result = jbd.insertOneline(job);
	if(result > 0){
		
	}else{
		
	}
%>