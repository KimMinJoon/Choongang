package oneline_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_onelineboard.J_OneLineBoard;
import j_onelineboard.J_OneLineBoardDAO;
import service.CommandProcess;

public class InsertAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		J_OneLineBoard olb = new J_OneLineBoard();
		olb.setM_no(Integer.parseInt(request.getParameter("m_no")));
		olb.setBrd_content(request.getParameter("brd_content"));
		olb.setBrd_ip(request.getRemoteAddr());
		String searchType= request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		J_OneLineBoardDAO jold = J_OneLineBoardDAO.getInstance();
		int result = jold.insertBoard(olb);
		request.setAttribute("result", result);
		
		return "/oneLineBoard/insertOneline.jsp";
	}

}
