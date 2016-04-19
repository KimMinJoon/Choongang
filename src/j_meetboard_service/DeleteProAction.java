package j_meetboard_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class DeleteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		int result = bd.delete(brd_no);
		
		//System.out.println("deleteProAction : "+result);
		
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		
		return "/meetBoard/deletePro.jsp";
	}

}
