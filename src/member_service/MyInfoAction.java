package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_member.J_Member;
import j_member.J_MemberDao;
import service.CommandProcess;

public class MyInfoAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String m_no  = (String)session.getAttribute("m_no");
		J_MemberDao jmd = J_MemberDao.getInstance();
		J_Member jif = jmd.infoselect(m_no);
		request.setAttribute("jif", jif);
		
		return "/member/myinfo.jsp";
		}

}
