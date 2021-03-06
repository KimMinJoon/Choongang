package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_member.J_Member;
import j_member.J_MemberDao;

public class joinProAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		
		J_Member jm = new J_Member();
		jm.setM_email(request.getParameter("m_email"));
		jm.setM_passwd(request.getParameter("m_passwd"));
		jm.setM_nick(request.getParameter("m_nick"));
		jm.setC_code(request.getParameter("c_code"));
		jm.setL_code(request.getParameter("l_code"));
		
		J_MemberDao jmd = J_MemberDao.getInstance();
		int result = jmd.insert(jm);
		System.out.println("result가입 : "+ result);
		
		request.setAttribute("result", result);
		
		return "/member/joinPro.jsp";
		
	}
}
