package recommend_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoardDao;

public class DeleteReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int re_no = Integer.parseInt(request.getParameter("re_no"));
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		int result = jrbd.deleteReply(re_no);
		
		request.setAttribute("result", result);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
		
		return "/recommendBoard/deleterecoReply.jsp";
	}

}
