package j_onelineboard;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Paging;


@WebServlet("/OnelineJsonList")
public class OnelineJsonList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("serachTxt");
		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int total = jobd.selectTotal(searchType, searchTxt);
		Paging paging = new Paging(10, 10, pageNum, total);
		List<J_OneLineBoard> list = jobd.selectOneLine(paging.getStartRow(), paging.getEndRow(), searchType, searchTxt);
		PrintWriter out = response.getWriter();
		if(){
			
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
