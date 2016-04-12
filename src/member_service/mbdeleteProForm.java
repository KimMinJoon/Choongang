package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CommandProcess;
import j_member.J_MemberDao;

public class mbdeleteProForm implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		HttpSession session = request.getSession();
		String m_no = (String) session.getAttribute("m_no");
		String m_passwd = request.getParameter("m_passwd");

		J_MemberDao jmd = J_MemberDao.getInstance();
		int chk = jmd.passwdChk(m_no, m_passwd);
		if (chk == 1) {
			result = jmd.delete(Integer.parseInt(m_no));
			request.setAttribute("result", result);
		}
		request.setAttribute("result", result);

		return "/member/mbdeletePro.jsp";

	}
}