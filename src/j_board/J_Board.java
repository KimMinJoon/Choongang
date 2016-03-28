package j_board;

import java.sql.Date;

public class J_Board {
	
	private int brd_no;
	private String brd_subject;
	private String brd_content;
	private String brd_category;
	private int brd_readcount;
	private int brd_recommend;
	private String brd_ip;
	private Date brd_reg_date; 
	private Date brd_update_date;
	private String brd_del_yn;
	private int m_no;
	private String l_code;
	private String b_code;
	
	public int getBrd_no() {
		return brd_no;
	}
	public void setBrd_no(int brd_no) {
		this.brd_no = brd_no;
	}
	public String getBrd_subject() {
		return brd_subject;
	}
	public void setBrd_subject(String brd_subject) {
		this.brd_subject = brd_subject;
	}
	public String getBrd_content() {
		return brd_content;
	}
	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}
	public String getBrd_category() {
		return brd_category;
	}
	public void setBrd_category(String brd_category) {
		this.brd_category = brd_category;
	}
	public int getBrd_readcount() {
		return brd_readcount;
	}
	public void setBrd_readcount(int brd_readcount) {
		this.brd_readcount = brd_readcount;
	}
	public int getBrd_recommend() {
		return brd_recommend;
	}
	public void setBrd_recommend(int brd_recommend) {
		this.brd_recommend = brd_recommend;
	}
	public String getBrd_ip() {
		return brd_ip;
	}
	public void setBrd_ip(String brd_ip) {
		this.brd_ip = brd_ip;
	}
	public Date getBrd_reg_date() {
		return brd_reg_date;
	}
	public void setBrd_reg_date(Date brd_reg_date) {
		this.brd_reg_date = brd_reg_date;
	}
	public Date getBrd_update_date() {
		return brd_update_date;
	}
	public void setBrd_update_date(Date brd_update_date) {
		this.brd_update_date = brd_update_date;
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
	public String getL_code() {
		return l_code;
	}
	public void setL_code(String l_code) {
		this.l_code = l_code;
	}
	public String getB_code() {
		return b_code;
	}
	public void setB_code(String b_code) {
		this.b_code = b_code;
	}
	
}
