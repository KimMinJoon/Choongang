import java.sql.Date;

public class J_Member {
	
	private int m_no;
	private String m_email;
	private Date m_reg_date;
	private String m_passwd; 
	private String m_del_yn;
	private String l_code;
	private String c_code;

	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public Date getM_reg_date() {
		return m_reg_date;
	}
	public void setM_reg_date(Date m_reg_date) {
		this.m_reg_date = m_reg_date;
	}
	public String getM_passwd() {
		return m_passwd;
	}
	public void setM_passwd(String m_passwd) {
		this.m_passwd = m_passwd;
	}
	public String getM_del_yn() {
		return m_del_yn;
	}
	public void setM_del_yn(String m_del_yn) {
		this.m_del_yn = m_del_yn;
	}
	public String getL_code() {
		return l_code;
	}
	public void setL_code(String l_code) {
		this.l_code = l_code;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	@Override
	public String toString() { //스프링할때 로그포지라는걸 쓴다 일단 좋은거 설정해주는게 좋습니다.
		return "J_Member [m_no=" + m_no + ", m_email=" + m_email + ", m_reg_date=" + m_reg_date + ", m_passwd="
				+ m_passwd + ", m_del_yn=" + m_del_yn + ", l_code=" + l_code + ", c_code=" + c_code + "]";
	}
	
}
