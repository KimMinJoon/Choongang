package oneline_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_onelineboard.J_OneLineBoardDAO;
import j_onelineboard.J_OneLineReply;
import service.CommandProcess;

public class InsertReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		HttpSession session = request.getSession();
		String m_no = (String)session.getAttribute("m_no");
		String content = request.getParameter("content");
		
		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		
		J_OneLineReply olr = new J_OneLineReply();
		olr.setBrd_no(brd_no);
		olr.setContent(content);
		olr.setM_no(Integer.parseInt(m_no));
		
		int result = jobd.insertReply(olr);
		
		request.setAttribute("result", result);
		request.setAttribute("pageNum", pageNum);
	
		return "/oneLineBoard/insertReplyOneline.jsp";
	}

}
