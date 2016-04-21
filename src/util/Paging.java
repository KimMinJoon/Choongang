package util;

public class Paging {

	private int rowPerPage;
	private int pagePerBlock;
	private int nowPage;
	private int total;
	private int totalPage;
	private int startRow;
	private int endRow;
	private int totalBlock;
	private int startPage;
	private int endPage;

	public Paging(int rowPerPage, int pagePerBlock, int nowPage, int total) {
		this.rowPerPage = rowPerPage;
		this.pagePerBlock = pagePerBlock;
		this.nowPage = nowPage;
		this.total = total;
		this.totalPage = (int) Math.ceil((double) total / rowPerPage);
		this.startRow = (nowPage - 1) * rowPerPage + 1;
		this.endRow = startRow + rowPerPage - 1;
		this.totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
		this.startPage = (nowPage - 1) / 10 * 10 + 1;
		this.endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		this.total = total - startRow + 1;
	}

	public int getRowPerPage() {
		return rowPerPage;
	}

	public int getPagePerBlock() {
		return pagePerBlock;
	}

	public int getNowPage() {
		return nowPage;
	}

	public int getTotal() {
		return total;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getStartRow() {
		return startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}
}
