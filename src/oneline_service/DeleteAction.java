package oneline_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_onelineboard.J_OneLineBoardDAO;
import service.CommandProcess;

public class DeleteAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		J_OneLineBoardDAO jold = J_OneLineBoardDAO.getInstance();
		int result = jold.deleteBoard(brd_no);
		
		request.setAttribute("result", result);
		request.setAttribute("pageNum", pageNum);
		return "/oneLineBoard/deleteOneline.jsp";
	}

}
