package j_meetboard_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class ViewAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String m_no = (String) session.getAttribute("m_no");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		J_MeetBoard brd = bd.select(brd_no);
		// System.out.println("추천수 가져올때 값 : " + brd.getBrd_recommend());
		int recommend = 0;
		if (m_no != null) {
			recommend = bd.selectRecommend(Integer.parseInt(m_no), brd_no);
		}
		
		bd.updateHit(brd_no);
		
		request.setAttribute("m_no", m_no);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("brd", brd);
		System.out.println(recommend);
		request.setAttribute("recommend", recommend);
		
		return "/meetBoard/view.jsp";

	}
}
