package j_noticeboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import j_meetboard.J_MeetBoard;

public class J_NoticeBoardDao {
	private static J_NoticeBoardDao instance = new J_NoticeBoardDao();// 싱글톤
																		// 생성

	private J_NoticeBoardDao() {
	}

	public static J_NoticeBoardDao getInstance() {
		return instance;
	}

	public Connection getConnection() {// 커넥션 풀
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}// getConnection

	public int selectTotal() throws SQLException {
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from j_noticeboard";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);// 먼저 값을 읽어와야함
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
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
		return total;
	}
}