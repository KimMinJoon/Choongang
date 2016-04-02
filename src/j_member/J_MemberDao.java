package j_member;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.*;

import j_code.J_Code;

public class J_MemberDao {
	// 싱글톤 객체 생성을 낭비하지 않기위해
	private static J_MemberDao instance = new J_MemberDao();

	private J_MemberDao() {
	}

	public static J_MemberDao getInstance() {
		return instance;
	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();// 연결
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");// 커넥션
																					// 풀
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}// getConnection

	public int emailChk(String m_email) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_email from j_member where m_email=? and m_del_yn='n'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}

	public int nickChk(String m_nick) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_nick from j_member where m_nick=? and m_del_yn='n'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_nick);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}

	public int insert(J_Member mb) {
		int result = 0, m_number = 0, m_no = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into j_member values(?,?,?,?,sysdate,'n',null,?,?)";
		String sql1 = "select nvl(max(m_no),0)+1 from j_member";
		String sql2 = "select m_no from j_member where m_email=? and m_del_yn='y'";
		String sql3 = "update j_member set m_passwd=?, m_nick=?, m_reg_date=sysdate, m_del_yn='n', c_code=?, l_code=? where m_no=?";
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, mb.getM_email());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				m_no = rs.getInt(1);
				pstmt.close();
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, mb.getM_passwd());
				pstmt.setString(2, mb.getM_nick());
				pstmt.setString(3, mb.getC_code());
				pstmt.setString(4, mb.getL_code());
				pstmt.setInt(5, m_no);
				result = pstmt.executeUpdate();
			} else {
				pstmt.close();
				rs.close();
				pstmt = conn.prepareStatement(sql1);
				rs = pstmt.executeQuery();
				if (rs.next())
					m_number = rs.getInt(1);
				pstmt.close();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, m_number);
				pstmt.setString(2, mb.getM_email());
				pstmt.setString(3, mb.getM_passwd());
				pstmt.setString(4, mb.getM_nick());
				pstmt.setString(5, mb.getC_code());
				pstmt.setString(6, mb.getL_code());
				result = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}

	public int loginChk(String m_email, String m_passwd) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_no, m_passwd from j_member where m_email=? and m_del_yn='n'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbPass = rs.getString("m_passwd"); // ("password")
				if (dbPass.equals(m_passwd))
					result = rs.getInt("m_no"); // 일치
				else
					result = 0; // 암호가 다름
			} else
				result = -1; // 데이터 읽기 실패
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}

	public J_Member select(String m_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from j_member where m_no=? and m_del_yn='n'";
		J_Member mem = new J_Member();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mem.setM_email(rs.getString("m_email"));
				mem.setM_passwd(rs.getString("m_passwd"));
				mem.setM_nick(rs.getString("m_nick"));
				mem.setC_code(rs.getString("c_code"));
				mem.setL_code(rs.getString("l_code"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return mem;
	}

	public J_Info infoselect(String m_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_email, m_passwd, m_nick, (select c_value from j_code c where c.c_minor = m.c_code) as c_value, (select c_value from j_code c where c.c_minor = m.l_code) as l_value from j_member m where m_no=? and m_del_yn='n'";
		J_Info jif = new J_Info();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				jif.setI_email(rs.getString("m_email"));
				jif.setI_passwd(rs.getString("m_passwd"));
				jif.setI_nick(rs.getString("m_nick"));
				jif.setC_value(rs.getString("c_value"));
				jif.setL_value(rs.getString("l_value"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return jif;
	}

	public int update(J_Member mem) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_member set m_passwd=?, m_nick=?, c_code=?, l_code=? where m_email=? and m_del_yn='n'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem.getM_passwd());
			pstmt.setString(2, mem.getM_nick());
			pstmt.setString(3, mem.getC_code());
			pstmt.setString(4, mem.getL_code());
			pstmt.setString(5, mem.getM_email());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(pstmt, conn);
		}
		return result;
	}

	public int delete(int m_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_member set m_del_yn='y', m_out_date=sysdate where m_no=? and m_del_yn='n'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(pstmt, conn);
		}
		return result;
	}

	public int passwdChk(String m_no, String m_passwd) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_passwd from j_member where m_no=? and m_passwd=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_no);
			pstmt.setString(2, m_passwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}

	public List<J_Member> selectList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<J_Member> list = new ArrayList<>();
		String sql = "select * from j_member";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				J_Member c = new J_Member();
				c.setM_no(rs.getInt(1));
				c.setM_email(rs.getString(2));
				c.setM_passwd(rs.getString(3));
				c.setM_nick(rs.getString(4));
				c.setM_reg_date(rs.getDate(5));
				c.setM_del_yn(rs.getString(6));
				c.setM_out_date(rs.getDate(7));
				c.setC_code(rs.getString(8));
				c.setL_code(rs.getString(9));
				list.add(c);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
	}

	// conn과 pstmt,그리고 rs를 종료해주는 메서드
	// 나중에 닫을 때 편하게 사용하면된다!
	public void dbClose(PreparedStatement pstmt, Connection conn) {

		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// dbClose(pstmt,conn)

	public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} // dbClose(rs,pstmt,conn)
	}

}
