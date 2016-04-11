package recommend_service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_recommendboard.J_RecommendBoardDao;

public class DeleteProAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
				
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_RecommendBoardDao jdbd = J_RecommendBoardDao.getInstance();
		int result  = jdbd.delete(brd_no);
		
		request.setAttribute("brd_no", brd_no);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		
		return "/recommendBoard/deletePro.jsp";
	}

}
