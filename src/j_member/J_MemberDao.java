package j_member;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;

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

	public int emailChk(String m_email) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_email from j_member where m_email = ?";
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
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}

	public int nickChk(String m_nick) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_nick from j_member where m_nick = ?";
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
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}

	public int insert(J_Member mb) throws SQLException {
		int result = 0, m_number = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into j_member values(?,?,?,?,sysdate,'n',?,?)";
		String sql1 = "select nvl(max(m_no),0)+1 from j_member";
		try {
			conn = getConnection();
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
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}

	public int loginChk(String m_email, String m_passwd) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_no, m_passwd from j_member where m_email=?";
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
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}

	public J_Member select(String m_no) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from j_member where m_no = ?";
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
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return mem;
	}

	public int update(J_Member mem) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_member set m_passwd=?, m_nick=?, c_code=?, l_code=? where m_email=?";
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
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}

	public int delete(int m_no) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from j_member where m_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}

	public int passwdChk(String m_no, String m_passwd) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m_passwd from j_member where m_passwd = ? and m_no = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_passwd);
			pstmt.setString(2, m_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
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
			// TODO Auto-generated catch block
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // dbClose(rs,pstmt,conn)
	}

}
