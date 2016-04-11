package recommend_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoard;
import j_recommendboard.J_RecommendBoardDao;
import j_code.J_Code;
import j_code.J_CodeDao;
import java.util.List;

public class WriteForm implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		
		String pageNum = request.getParameter("pageNum");

		int brd_no = 0, ref = 0, re_step = 0, re_level = 0;
		if (request.getParameter("brd_no") != null) {
			brd_no = Integer.parseInt(request.getParameter("brd_no"));
			J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
			J_RecommendBoard jdb = jrbd.select(brd_no);
			ref = jdb.getRef();
			re_step = jdb.getRe_step();
			re_level = jdb.getRe_level();
		}
		
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("ref", ref);
		request.setAttribute("re_step", re_step);
		request.setAttribute("re_level", re_level);
		request.setAttribute("list", list);
		
		return "/recommendBoard/writeForm.jsp";
	}
}