package j_meetboard_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class UpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		J_MeetBoard meetboard = new J_MeetBoard();
		meetboard.setBrd_no(Integer.parseInt(request.getParameter("brd_no")));
		meetboard.setBrd_subject(request.getParameter("brd_subject"));
		meetboard.setBrd_content(request.getParameter("brd_content"));
		meetboard.setL_code(request.getParameter("l_code"));
		meetboard.setMc_code(request.getParameter("mc_code"));
		
		int result = bd.update(meetboard);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		request.setAttribute("meetboard", meetboard);
		
		return "/meetBoard/updatePro.jsp";
	}

}
