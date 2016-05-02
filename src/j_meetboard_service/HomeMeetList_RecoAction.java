package j_meetboard_service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class HomeMeetList_RecoAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		String m_no = (String) session.getAttribute("m_no");
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		List<J_MeetBoard> list1 = bd.selectList_home_reco();
		request.setAttribute("m_no", m_no);
		request.setAttribute("list1", list1);
		
		return "/meetBoard/homemeetlist_reco.jsp";
		
	}
}
