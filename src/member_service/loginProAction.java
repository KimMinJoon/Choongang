package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.CommandProcess;
import j_member.J_Member;
import j_member.J_MemberDao;

public class loginProAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		
		J_Member jm = new J_Member();
		HttpSession session = request.getSession();
		jm.setM_email(request.getParameter("m_email"));
		jm.setM_passwd(request.getParameter("m_passwd"));		
		
		J_MemberDao jmd = J_MemberDao.getInstance();
		int result = jmd.loginChk(jm.getM_email(), jm.getM_passwd());
		
		if(result > 0 ) {
			session.setAttribute("m_no", result+"");
		}
		
		request.setAttribute("result", result);
		
		return "/member/loginPro.jsp";
		
	}
}
