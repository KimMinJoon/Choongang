package recommend_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoardDao;
import j_recommendboard.J_RecoReply;

public class InsertReplyAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		HttpSession session = request.getSession();
		String m_no = (String)session.getAttribute("m_no");
		String re_content = request.getParameter("re_content");
		
		J_RecommendBoardDao jrdb = J_RecommendBoardDao.getInstance();
		
		J_RecoReply jrr = new J_RecoReply();
		jrr.setBrd_no(brd_no);
		jrr.setRe_content(re_content);
		jrr.setM_no(Integer.parseInt(m_no));
		
		int result = jrdb.insertReply(jrr);
		
		request.setAttribute("result", result);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
	
		return "/recommendBoard/insertrecoReply.jsp";
	}

}
