package recommend_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoard;
import j_recommendboard.J_RecommendBoardDao;
import j_code.J_Code;
import j_code.J_CodeDao;
import java.util.List;

public class UpdateForm implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {

		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jrb = jrbd.select(brd_no);
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("jrb", jrb);
		request.setAttribute("list", list);
	
		return "/recommendBoard/updateForm.jsp";
		
	}
}