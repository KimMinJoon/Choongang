package oneline_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_onelineboard.J_OneLineBoardDAO;
import service.CommandProcess;

public class DeleteRepAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int reply_no = Integer.parseInt(request.getParameter("reply_no"));
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int result = jobd.deleteRep(reply_no);
		
		request.setAttribute("result", result);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
		
		return "/oneLineBoard/deleteRepOneline.jsp";
	}

}
