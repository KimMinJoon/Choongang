package member_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CommandProcess;
import j_code.J_Code;
import j_code.J_CodeDao;
import java.util.List;

public class joinAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();
		
		request.setAttribute("list", list);
		
		return "/member/join.jsp";
		
	}
}
