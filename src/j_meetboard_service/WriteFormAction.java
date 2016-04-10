package j_meetboard_service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_code.J_Code;
import j_code.J_CodeDao;
import service.CommandProcess;

public class WriteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();
		
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		
		return "meetBoard/writeForm.jsp";
	}

}
