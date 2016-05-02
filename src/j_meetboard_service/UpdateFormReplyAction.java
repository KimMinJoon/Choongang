package j_meetboard_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import j_meetboard.J_MeetBoardReply;
import j_meetboard.J_MeetBoardReplyDao;
import service.CommandProcess;

public class UpdateFormReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String m_no = (String)session.getAttribute("m_no");
		String re_no = request.getParameter("re_no");
		String brd_no = request.getParameter("brd_no");
		String re_content = request.getParameter("re_content");
		String pageNum = request.getParameter("pageNum");
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		
		J_MeetBoardReply jmbr = new J_MeetBoardReply();
		jmbr.setBrd_no(Integer.parseInt(brd_no));
		jmbr.setRe_content(re_content);
		jmbr.setM_no(Integer.parseInt(m_no));
		jmbr.setRe_no(Integer.parseInt(re_no));
		
		J_MeetBoardReplyDao jmbrd = J_MeetBoardReplyDao.getInstance();
		int result = jmbrd.updateReply(jmbr);
		
		request.setAttribute("result", result);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchTxt", searchTxt);
		request.setAttribute("brd_no", brd_no);
		
		return "/meetBoard/updateFormReplyPro.jsp";
	}

}
