<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String m_no = (String)session.getAttribute("m_no");
	String brd_no = request.getParameter("like_brd_no");
	String str = "";
	J_MeetBoardDao jmb = J_MeetBoardDao.getInstance();
	int result = jmb.recommendChk(Integer.parseInt(m_no),Integer.parseInt(brd_no));
	//int resultValue = Integer.parseInt(result);
	if(result > 0) {
		str = "TRUE";
	}else if(result == 0){
		str = "FALSE";
	}else{
		%>
		<script type="text/javascript">
			alert("추천 실패");
		</script>
		<%
	}
	out.print(str);
	/* str은 join.jsp의 엠닉의 data로 다시 돌아간다. */
%>