package j_member;

import java.io.Reader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import j_noticeboard.J_NoticeBoard;
import oracle.net.aso.e;

public class J_MemberDao {
	// 싱글톤 객체 생성을 낭비하지 않기위해
	private static J_MemberDao instance = new J_MemberDao();
	private static SqlSession session; // 생성

	static {
		try {
			Reader reader = Resources.getResourceAsReader("configuration.xml");
			SqlSessionFactory sf = new SqlSessionFactoryBuilder().build(reader);
			session = sf.openSession(true);// 이걸 안하면 커밋이안된다.!!!!!!왜? 트루가 커밋을
											// 하겟다는의미이다.
			reader.close();
		} catch (Exception e) {
			System.out.println("sqlMap에러");

		}
	}

	private J_MemberDao() {
	}

	public static J_MemberDao getInstance() {
		return instance;
	}

	// 커넥션 풀 대신해서 마이바티스 사용

	public int emailCheck(String m_email) {
		int result = 0;
		/*
		 * Connection conn = null; PreparedStatement pstmt = null; ResultSet rs
		 * = null; String sql =
		 * "select m_email from j_member where m_email=? and m_del_yn='n'";
		 */
		try {
			result = (int) session.selectOne("emailChk", m_email);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public int nickCheck(String m_nick, String m_no) {
		int result = 0;
		J_Member mb = new J_Member();
		mb.setM_no(Integer.parseInt(m_no));
		mb.setM_nick(m_nick);
		String orgNick = "";
		String db_nick = "";
		try {
			orgNick = (String) session.selectOne("nickChk", m_no);
			db_nick = (String) session.selectOne("nickChk2", mb);
			if (orgNick != null) {
				/*
				 * System.out.println("db_nick1 : " + db_nick);
				 * System.out.println("orgNick1 : " + orgNick);
				 */
				if (db_nick.equals(orgNick))
					result = 0;
				else
					result = 1;

			} else {
				/*
				 * System.out.println("db_nick2 : " + db_nick);
				 * System.out.println("orgNick2 : " + orgNick);
				 */
				if (db_nick != null)
					result = 0;
				else
					result = -1;
			}

		} catch (Exception e) {
			System.out.println("nickCheck : " + e.getMessage());
		}
		return result;
	}

	public int insert(J_Member mb) {
		int result = 0, m_number = 0, m_no = 0;

		/*
		 * Connection conn = null; PreparedStatement pstmt = null; ResultSet rs
		 * = null; String sql =
		 * "insert into j_member values(?,?,?,?,sysdate,null,'n',?,?)"; String
		 * sql1 = "select nvl(max(m_no),0)+1 from j_member"; String sql2 =
		 * "select m_no from j_member where m_email=? and m_del_yn='y'"; String
		 * sql3 =
		 * "update j_member set m_passwd=?, m_nick=?, m_reg_date=sysdate, m_del_yn='n', c_code=?, l_code=? where m_no=?"
		 * ;
		 */
		try {

			/*
			 * conn = getConnection(); pstmt = conn.prepareStatement(sql2);
			 * pstmt.setString(1, mb.getM_email()); rs = pstmt.executeQuery();
			 * if (rs.next()) { m_no = rs.getInt(1); pstmt.close(); }
			 */
			m_no = (int) session.selectOne("selectmno", mb);
			System.out.println("m_nojoin : "+m_no);
			

			if (m_no > 0) {
				result = session.update("updateData", mb);
			} else {
			m_number = (int) session.selectOne("selectNum");
				mb.setM_no(m_number);
				result = session.insert("insertMember", mb);
			}

			/*
			 * pstmt = conn.prepareStatement(sql3); pstmt.setString(1,
			 * mb.getM_passwd()); pstmt.setString(2, mb.getM_nick());
			 * pstmt.setString(3, mb.getC_code()); pstmt.setString(4,
			 * mb.getL_code()); pstmt.setInt(5, m_no); result =
			 * pstmt.executeUpdate();
			 * 
			 * } else {
			 */

			/*
			 * pstmt.close(); rs.close(); pstmt = conn.prepareStatement(sql1);
			 * rs = pstmt.executeQuery(); if (rs.next()) m_number =
			 * rs.getInt(1);
			 */

			/*
			 * pstmt.close(); pstmt = conn.prepareStatement(sql);
			 * pstmt.setInt(1, m_number); pstmt.setString(2, mb.getM_email());
			 * pstmt.setString(3, mb.getM_passwd()); pstmt.setString(4,
			 * mb.getM_nick()); pstmt.setString(5, mb.getC_code());
			 * pstmt.setString(6, mb.getL_code());
			 * 
			 * result = pstmt.executeUpdate(); }
			 */
		} catch (Exception e)

		{
			System.out.println(e.getMessage());
		}

		return result;

	}

	public int loginChk(String m_email, String m_passwd) {
		int result = 0;
		/*
		 * Connection conn = null; PreparedStatement pstmt = null; ResultSet rs
		 * = null; String sql =
		 * "select m_no, m_passwd from j_member where m_email=? and m_del_yn='n'"
		 * ;
		 */
		try {
			String dbpass = (String) session.selectOne("loginChkk", m_email);

			/*
			 * conn = getConnection(); pstmt = conn.prepareStatement(sql);
			 * pstmt.setString(1, m_email); rs = pstmt.executeQuery();
			 */
			System.out.println("dbpass : " + dbpass);
			if (dbpass.equals(m_passwd)) {
				result = (int)session.selectOne("selectmno2", m_email);
			} else
				result = 0;

			/*
			 * if (rs.next()) { String dbPass = rs.getString("m_passwd"); //
			 * ("password") if (dbPass.equals(m_passwd)) result =
			 * rs.getInt("m_no"); // 일치 else result = 0; // 암호가 다름 } else result
			 * = -1; // 데이터 읽기 실패
			 */ } catch (Exception e)

		{
			System.out.println(e.getMessage());
		}
		/*
		 * finally
		 * 
		 * { dbClose(rs, pstmt, conn); }
		 */ return result;
	}

	public J_Member select(String m_no) {
		J_Member mem = null;
		try {
			mem = (J_Member) session.selectOne("selectMember", m_no);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mem;
	}

	
	public J_Member infoselect(int m_no) {
		/*Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_email, m_passwd, m_nick, (select c_value from j_code c where c.c_minor = m.c_code) as c_value, (select c_value from j_code c where c.c_minor = m.l_code) as l_value from j_member m where m_no=? and m_del_yn='n'";*/
		J_Member jif = null;
		try {
			System.out.println("m_no정보야와라 : "+ m_no);
			jif = (J_Member)session.selectOne("selectInfoz", m_no);
			System.out.println("jif정보야와라 : "+ jif);
			/*conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				jif.setM_email(rs.getString("m_email"));
				jif.setM_passwd(rs.getString("m_passwd"));
				jif.setM_nick(rs.getString("m_nick"));
				jif.setC_value(rs.getString("c_value"));
				jif.setL_value(rs.getString("l_value"));*/
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		return jif;
	}

	public int update(J_Member mem) {
		int result = 0;
		/*Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_member set m_passwd=?, m_nick=?, c_code=?, l_code=? where m_email=? and m_del_yn='n'";*/
		try {
			result = session.update("updateInfo", mem);
			/*conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem.getM_passwd());
			pstmt.setString(2, mem.getM_nick());
			pstmt.setString(3, mem.getC_code());
			pstmt.setString(4, mem.getL_code());
			pstmt.setString(5, mem.getM_email());
			result = pstmt.executeUpdate();*/
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} /*finally {
			dbClose(pstmt, conn);
		}*/
		return result;
	}
	
	public int delete(int m_no) {
		int result = 0;
		/*Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_member set m_del_yn='y', m_out_date=sysdate where m_no=? and m_del_yn='n'";*/
		try {
			result = session.update("deleteMem", m_no);
			/*conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_no);
			result = pstmt.executeUpdate();*/
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		return result;
	}
	 	
	public int passwdChk(String m_no, String m_passwd) {
		int result = 0;
		String chk = "";
		HashMap<String, String> hm = new HashMap<>();
		hm.put("m_no", m_no);
		hm.put("m_passwd", m_passwd);
		/*Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_passwd from j_member where m_no=? and m_passwd=?";
		*/
		try {
			chk = (String)session.selectOne("passwdChk",hm);
			if (chk != null) {
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		return result;
	}

}
