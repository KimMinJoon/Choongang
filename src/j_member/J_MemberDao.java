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

	public int inchk(String m_email) throws SQLException {
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
