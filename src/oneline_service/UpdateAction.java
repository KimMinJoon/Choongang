package oneline_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_onelineboard.J_OneLineBoard;
import j_onelineboard.J_OneLineBoardDAO;
import service.CommandProcess;

public class UpdateAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String m_no = (String)session.getAttribute("m_no");
		String pageNum = request.getParameter("pageNum");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String brd_content = request.getParameter("brd_content");
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		
		J_OneLineBoard olb = new J_OneLineBoard();
		olb.setBrd_ip(request.getRemoteAddr());
		olb.setM_no(Integer.parseInt(m_no));
		olb.setBrd_no(brd_no);
		olb.setBrd_content(brd_content);
		
		J_OneLineBoardDAO jold = J_OneLineBoardDAO.getInstance();
		int result = jold.updateBoard(olb);
		
		request.setAttribute("result", result);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchTxt",searchTxt);
		return "/oneLineBoard/updateOneline.jsp";
	}
	
}
