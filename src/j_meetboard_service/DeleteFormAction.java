package j_meetboard_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class DeleteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		J_MeetBoard meetboard = bd.passwdChk(brd_no);
		String dbPass = meetboard.getM_passwd();
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("meetboard", meetboard);
		request.setAttribute("dbPass", dbPass);
		request.setAttribute("brd_no", brd_no);
		
		return "/meetBoard/deleteForm.jsp";
	}

}
