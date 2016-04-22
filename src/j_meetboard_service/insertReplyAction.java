package j_meetboard_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_meetboard.J_MeetBoardReply;
import j_meetboard.J_MeetBoardReplyDao;
import service.CommandProcess;

public class insertReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		HttpSession session = request.getSession();
		String m_no = (String)session.getAttribute("m_no");
		String re_content = request.getParameter("re_content");
		
		J_MeetBoardReplyDao jmbrd = J_MeetBoardReplyDao.getInstance();
		J_MeetBoardReply jmbr = new J_MeetBoardReply();
		
		jmbr.setBrd_no(brd_no);
		jmbr.setRe_content(re_content);
		jmbr.setM_no(Integer.parseInt(m_no));
		
		int result = jmbrd.insertReply(jmbr);
		
		request.setAttribute("result", result);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
	
		return "/meetBoard/insertReplyPro.jsp";
	}

}
