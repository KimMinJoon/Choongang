<%

	String m_no = (String) session.getAttribute("m_no");
		if (m_no == null || m_no.equals("") || m_no.equals("null")) {
			response.sendRedirect("../module/main.jsp?pgm=/member/login.jsp");
		}
	
%>
