package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CommandProcess;
import j_member.J_Member;
import j_member.J_MemberDao;
import j_code.J_Code;
import j_code.J_CodeDao;
import java.util.*;

public class mbupdateAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String m_no = (String) session.getAttribute("m_no");
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();
		J_MemberDao mdo = J_MemberDao.getInstance();
		J_Member jm = mdo.select(m_no);
		
		request.setAttribute("list", list);
		request.setAttribute("jm", jm);
		
		return "/member/mbupdate.jsp";
		
	}
}
