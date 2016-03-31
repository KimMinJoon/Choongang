package j_onelineboard;

import java.sql.Date;

public class J_OneLineBoard {
	private int brd_no;
	private String brd_content;
	private String brd_reg_date;
	private Date brd_update_date;
	private String brd_ip;
	private String brd_del_yn;
	private int m_no;
	private String m_nick;
	private int grp;
	
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
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
	public String getBrd_content() {
		return brd_content;
	}
	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}
	public String getBrd_reg_date() {
		return brd_reg_date;
	}
	public void setBrd_reg_date(String brd_reg_date) {
		this.brd_reg_date = brd_reg_date;
	}
	public Date getBrd_update_date() {
		return brd_update_date;
	}
	public void setBrd_update_date(Date brd_update_date) {
		this.brd_update_date = brd_update_date;
	}
	public String getBrd_ip() {
		return brd_ip;
	}
	public void setBrd_ip(String brd_ip) {
		this.brd_ip = brd_ip;
	}
	public String getBrd_del_yn() {
		return brd_del_yn;
	}
	public void setBrd_del_yn(String brd_del_yn) {
		this.brd_del_yn = brd_del_yn;
	}
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	@Override
	public String toString() {
		return "J_OneLineBoard [brd_no=" + brd_no + ", brd_content=" + brd_content + ", brd_reg_date=" + brd_reg_date
				+ ", brd_update_date=" + brd_update_date + ", brd_ip=" + brd_ip + ", brd_del_yn=" + brd_del_yn
				+ ", m_no=" + m_no + ", m_nick=" + m_nick + ", grp=" + grp + "]";
	}
}
