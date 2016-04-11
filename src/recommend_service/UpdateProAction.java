package recommend_service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoard;
import j_recommendboard.J_RecommendBoardDao;

public class UpdateProAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {

		String pageNum = request.getParameter("pageNum");
		
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jrb = new J_RecommendBoard();
		
		jrb.setBrd_no(Integer.parseInt(request.getParameter("brd_no")));
		jrb.setBrd_subject(request.getParameter("brd_subject"));
		jrb.setBrd_content(request.getParameter("brd_content"));
		jrb.setRc_code(request.getParameter("rc_code"));
		
		int result = jrbd.update(jrb);
		
		request.setAttribute("result", result);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("jrb", jrb);
		
		return "/recommendBoard/updatePro.jsp";
	}
}
