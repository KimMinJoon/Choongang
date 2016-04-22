package j_recommendboard;

import java.sql.Date;

public class J_RecoReply {
	private int re_no;
	private String re_content;
	private String re_reg_Date;
	private Date re_up_date;
	private String re_del_yn;
	private int m_no;
	private String m_nick;
	private int brd_no;

	public int getRe_no() {
		return re_no;
	}

	public void setRe_no(int re_no) {
		this.re_no = re_no;
	}

	public String getRe_content() {
		return re_content;
	}

	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}

	public String getRe_reg_Date() {
		return re_reg_Date;
	}

	public void setRe_reg_Date(String re_reg_Date) {
		this.re_reg_Date = re_reg_Date;
	}

	public Date getRe_up_date() {
		return re_up_date;
	}

	public void setRe_up_date(Date re_up_date) {
		this.re_up_date = re_up_date;
	}

	public String getRe_del_yn() {
		return re_del_yn;
	}

	public void setRe_del_yn(String re_del_yn) {
		this.re_del_yn = re_del_yn;
	}

	public int getM_no() {
		return m_no;
	}

	public void setM_no(int m_no) {
		this.m_no = m_no;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public int getBrd_no() {
		return brd_no;
	}

	public void setBrd_no(int brd_no) {
		this.brd_no = brd_no;
	}

	/*@Override
	public String toString() {
		return "J_RecoReply [re_no=" + re_no + ", re_content=" + re_content + ", re_reg_Date=" + re_reg_Date
				+ ", re_up_date=" + re_up_date + ", re_del_yn=" + re_del_yn + ", m_no=" + m_no + ", m_nick=" + m_nick
				+ ", brd_no=" + brd_no + "]";
	}*/
	
	
}
