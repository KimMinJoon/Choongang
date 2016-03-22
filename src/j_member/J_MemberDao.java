package j_member;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;

import com.mysql.jdbc.PreparedStatement;

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
