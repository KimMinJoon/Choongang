package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_member.J_MemberDao;
import service.CommandProcess;

public class emailChkAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String m_email = request.getParameter("m_email");
		J_MemberDao jmd = J_MemberDao.getInstance();
		int result = jmd.emailCheck(m_email);
		System.out.println("result : "+result);
		request.setAttribute("result", result);
		request.setAttribute("m_email", m_email);
		System.out.println("result : "+result);

		return "/member/emailChk.jsp";
	}
}
