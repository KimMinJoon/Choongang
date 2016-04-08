package notice_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_noticeboard.J_NoticeBoardDao;
import service.CommandProcess;

public class DeleteProAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_NoticeBoardDao jnbd = J_NoticeBoardDao.getInstance();
		int result = jnbd.delete(brd_no);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		return "/noticeBoard/deletePro.jsp";
	}

}
