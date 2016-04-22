package recommend_service;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import j_recommendboard.J_RecommendBoard;
import j_recommendboard.J_RecommendBoardDao;
import j_recommendboard.J_RecoReply;
import service.CommandProcess;

public class ViewAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String m_no = (String) session.getAttribute("m_no");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jrb = jrbd.select(brd_no);
		jrbd.updateHit(brd_no);
		
		int recommend = 0;
		if (m_no != null) {
			recommend = jrbd.selectRecommend(m_no, brd_no);
		}
		
		List<J_RecoReply> rpList = jrbd.selectReply(brd_no);
		
		request.setAttribute("m_no", m_no);
		request.setAttribute("brd_no", brd_no);		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("jrb", jrb);
		request.setAttribute("recommend", recommend);
		request.setAttribute("rpList", rpList);

		return "/recommendBoard/view.jsp";
	}
}