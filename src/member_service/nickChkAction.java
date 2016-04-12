package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_member.J_MemberDao;
import service.CommandProcess;

public class nickChkAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String m_nick = request.getParameter("m_nick");
		String m_no = request.getParameter("m_no");
		J_MemberDao jmd = J_MemberDao.getInstance();
		int result = jmd.nickCheck(m_nick, m_no);
		request.setAttribute("result", result);
		return "/member/nickChk.jsp";
	}

}
