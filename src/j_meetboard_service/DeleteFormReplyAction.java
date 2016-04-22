package j_meetboard_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_meetboard.J_MeetBoardReplyDao;
import j_onelineboard.J_OneLineBoardDAO;
import service.CommandProcess;

public class DeleteFormReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int re_no = Integer.parseInt(request.getParameter("re_no"));
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		J_MeetBoardReplyDao jobd = J_MeetBoardReplyDao.getInstance();
		int result = jobd.deleteReply(re_no);
		
		request.setAttribute("result", result);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
		
		return "/meetBoard/deleteFormReply.jsp";
	}

}
