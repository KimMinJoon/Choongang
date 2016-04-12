package j_meetboard_service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_code.J_Code;
import j_code.J_CodeDao;
import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class UpdateFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		J_MeetBoard meetboard = bd.select(brd_no);
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();
		request.setAttribute("meetboard", meetboard);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("list", list);
		
		return "/meetBoard/updateForm.jsp";
	}

}
