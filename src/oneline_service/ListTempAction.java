package oneline_service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_onelineboard.J_OneLineBoard;
import j_onelineboard.J_OneLineBoardDAO;
import j_onelineboard.J_OneLineReply;
import service.CommandProcess;
import util.Paging;

public class ListTempAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		String brd_no = request.getParameter("brd_no");
		if(brd_no == null || brd_no.equals("null")||brd_no.equals("")){
			brd_no = "0";
		}
		
		if(searchType == null || searchType.equals("null")){
			searchType = "";
		}
		
		if(searchTxt == null || searchTxt.equals("null")){
			searchTxt = "";
		}
		String pageNum = request.getParameter("pageNum");

		if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
			pageNum = "1";
		}
		int nowPage = Integer.parseInt(pageNum);
		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int total = jobd.selectTotal(searchType, searchTxt);
		Paging paging = new  Paging(10, 10, nowPage, total);

		List<J_OneLineBoard> list = jobd.selectOneLine(paging.getStartRow(), paging.getEndRow(), searchType, searchTxt);
		List<J_OneLineReply> reList = jobd.selectReply();
		
		request.setAttribute("rowPerPage", paging.getRowPerPage());
		request.setAttribute("pagePerBlock", paging.getPagePerBlock());
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("totalBlock", paging.getTotalBlock());
		request.setAttribute("startPage", paging.getStartPage());
		request.setAttribute("endPage", paging.getEndPage());
		request.setAttribute("totalPage", paging.getTotalPage());
		request.setAttribute("total", paging.getTotal());
		request.setAttribute("list", list);
		request.setAttribute("reList", reList);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchTxt", searchTxt);
		request.setAttribute("brd_no", brd_no);
		
		return "/oneLineBoard/listTemp.jsp";
	}

}
