<%@page import="j_onelineboard.J_OneLineBoard"%>
<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function textCheck() {
		var counter = document.getElementById("counter");
		var content = document.getElementById("content");
		counter.innerHTML = content.value.length + "/150";
	}
	function isUpdateSubmit(m_no) {
 		if(m_no == null || m_no == "" || m_no == "null"){
 			if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")) {
 				location.href = "../module/main.jsp?pgm=/member/login.jsp";
 			} else {
 				return;
 			}
 		}else{
 			document.updateFrm.submit();
 		}
	}
</script>
<%
	String m_no = (String) session.getAttribute("m_no");
	
	int brd_no = 0;
	J_OneLineBoard jolb = null;
	
	if(request.getParameter("brd_no") != null){
		brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_OneLineBoardDAO jolbd = J_OneLineBoardDAO.getInstance();
		jolb = jolbd.selectOneLineByNo(brd_no);
	}
%>
</head>
<body>
<form action="../oneLineBoard/updateOneline.jsp" name="updateFrm">
		<c:if test="${not empty m_no}">
			<input type="hidden" name="m_no" value="${m_no}">
		</c:if>
			<input type="hidden" name="brd_no" value="<%=jolb.getBrd_no()%>">
		<!-- 세션값을 가져와서 담음 -->
		<textarea rows="3" cols="100" maxlength="150" id="content"
			name="brd_content" required="required" onkeyup="textCheck()"><%=jolb.getBrd_content()%></textarea>
		<span id="counter">0/150</span> <input
			style="height: 50px; width: 120px;" type="submit" value="등록"
			onclick="isUpdateSubmit(${m_no})">
</form>
</body>
</html>