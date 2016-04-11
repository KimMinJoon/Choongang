package recommend_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoard;
import j_recommendboard.J_RecommendBoardDao;

public class WriteProAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		J_RecommendBoard jrb = new J_RecommendBoard();
		jrb.setBrd_no(Integer.parseInt(request.getParameter("brd_no")));
		jrb.setBrd_subject(request.getParameter("brd_subject"));
		jrb.setBrd_content(request.getParameter("brd_content"));				
		jrb.setBrd_ip(request.getParameter("brd_ip"));
		jrb.setRef(Integer.parseInt(request.getParameter("ref")));
		jrb.setRe_step(Integer.parseInt(request.getParameter("re_step")));
		jrb.setRe_level(Integer.parseInt(request.getParameter("re_level")));
		jrb.setM_no(Integer.parseInt(request.getParameter("m_no")));
		jrb.setRc_code(request.getParameter("rc_code"));
		String pageNum = request.getParameter("pageNum");
		String ip = request.getRemoteAddr();
		jrb.setBrd_ip(ip);
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		int result = jrbd.insert(jrb);
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		
		return "/recommendBoard/writePro.jsp";
	}
}