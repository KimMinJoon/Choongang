package recommend_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoard;
import j_recommendboard.J_RecommendBoardDao;

public class DeleteForm implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		
		String pageNum = request.getParameter("pageNum");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jrb = jrbd.pwdCheck(brd_no);
		String dbPass = jrb.getM_passwd();
		
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("jrb", jrb);
		request.setAttribute("dbPass", dbPass);
		
		return "/recommendBoard/deleteForm.jsp";
	}
}