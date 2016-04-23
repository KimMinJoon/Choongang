package j_meetboard_service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class HomeMeetList_NewAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		String m_no = (String) session.getAttribute("m_no");
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		List<J_MeetBoard> list2 = bd.selectList_home_new();
		request.setAttribute("m_no", m_no);
		request.setAttribute("list2", list2);
		
		return "/meetBoard/homemeetlist_new.jsp";
		
	}
}
