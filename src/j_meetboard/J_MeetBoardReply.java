package j_meetboard;

import java.sql.Date;

public class J_MeetBoardReply {
	  private int re_no;
	  private int m_no;
	  private int brd_no;
	  private String re_content;
	  private Date re_reg_date;
	  private Date re_update_date;
	  private String del_yn;
	  private String m_nick;
	  
	public int getRe_no() {
		return re_no;
	}
	public void setRe_no(int re_no) {
		this.re_no = re_no;
	}
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	public int getBrd_no() {
		return brd_no;
	}
	public void setBrd_no(int brd_no) {
		this.brd_no = brd_no;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public Date getRe_reg_date() {
		return re_reg_date;
	}
	public void setRe_reg_date(Date re_reg_date) {
		this.re_reg_date = re_reg_date;
	}
	public Date getRe_update_date() {
		return re_update_date;
	}
	public void setRe_update_date(Date re_update_date) {
		this.re_update_date = re_update_date;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getM_nick() {
		return m_nick;
	}
	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	
}
