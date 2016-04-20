package recommend_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoardDao;
import j_recommendboard.J_RecoReply;

public class UpdateReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String m_no = (String)session.getAttribute("m_no");
		String brd_no = request.getParameter("brd_no");
		String pageNum = request.getParameter("pageNum");
		String re_no = request.getParameter("re_no");
		String re_content = request.getParameter("re_content");
		
		J_RecoReply jrr = new J_RecoReply();
		jrr.setBrd_no(Integer.parseInt(brd_no));
		jrr.setRe_content(re_content);
		jrr.setM_no(Integer.parseInt(m_no));
		jrr.setRe_no(Integer.parseInt(re_no));
		
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		int result = jrbd.updateReply(jrr);
		
		request.setAttribute("result", result);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("brd_no", brd_no);
		
		return "/recommendBoard/updaterecoReply.jsp";
	}
}
