package oneline_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_onelineboard.J_OneLineBoardDAO;
import j_onelineboard.J_OneLineReply;
import service.CommandProcess;

public class UpdateReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String m_no = (String)session.getAttribute("m_no");
		String reply_no = request.getParameter("reply_no");
		String brd_no = request.getParameter("brd_no");
		String content = request.getParameter("content");
		String pageNum = request.getParameter("pageNum");
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		
		J_OneLineReply jolr = new J_OneLineReply();
		jolr.setBrd_no(Integer.parseInt(brd_no));
		jolr.setContent(content);
		jolr.setM_no(Integer.parseInt(m_no));
		jolr.setReply_no(Integer.parseInt(reply_no));
		
		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int result = jobd.updateReply(jolr);
		
		request.setAttribute("result", result);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchTxt", searchTxt);
		request.setAttribute("brd_no", brd_no);
		
		return "/oneLineBoard/updateOneLineReply.jsp";
	}
}
