package j_meetboard_service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import j_meetboard.J_MeetBoardReply;
import j_meetboard.J_MeetBoardReplyDao;
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
		J_MeetBoardReplyDao jmbrd = J_MeetBoardReplyDao.getInstance();
		
		List<J_MeetBoardReply> list = jmbrd.selectListReply(brd_no);
		
		//List<J_MeetBoard> list = bd.selectList(startRow, endRow, searchType, searchTxt);
		// System.out.println("추천수 가져올때 값 : " + brd.getBrd_recommend());
		int recommend = 0;
		System.out.println("ViewAction에서 받아오는 m_no입니다. : " + m_no);
		if (m_no != null) {
			recommend = bd.selectRecommend(Integer.parseInt(m_no), brd_no);
		}
		
		bd.updateHit(brd_no);
		
		request.setAttribute("list", list);
		request.setAttribute("m_no", m_no);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("brd", brd);
		request.setAttribute("recommend", recommend);
		
		return "/meetBoard/view.jsp";

	}
}
