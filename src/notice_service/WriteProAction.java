package notice_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_noticeboard.J_NoticeBoard;
import j_noticeboard.J_NoticeBoardDao;
import service.CommandProcess;

public class WriteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		J_NoticeBoard jbd = new J_NoticeBoard();
		jbd.setBrd_no(Integer.parseInt(request.getParameter("brd_no")));
		jbd.setBrd_subject(request.getParameter("brd_subject"));
		jbd.setBrd_content(request.getParameter("brd_content"));
		jbd.setAdmin(request.getParameter("admin"));
		String pageNum = request.getParameter("pageNum");
		J_NoticeBoardDao jnbd = J_NoticeBoardDao.getInstance();

		int result = jnbd.insert(jbd);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		return "writePro.jsp";
	}

}
