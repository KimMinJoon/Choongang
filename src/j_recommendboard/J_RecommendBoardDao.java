package j_recommendboard;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class J_RecommendBoardDao {
	
	private static J_RecommendBoardDao instance = new J_RecommendBoardDao();
	private J_RecommendBoardDao() {	}
	public static J_RecommendBoardDao getInstance() {
		return instance;
	}
	
	public Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	
	public int selectTotal() throws SQLException {
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from j_recommendboard";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return total;
	}
	
	public List<J_RecommendBoard> selectList(int startRow,int endRow) throws SQLException {
		List<J_RecommendBoard> list = new ArrayList<J_RecommendBoard>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from (select rowNum rn, a.* from (select * from j_recommendboard order by brd_no desc) a ) where rn between ? and ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				J_RecommendBoard recommendboard = new J_RecommendBoard();
				recommendboard.setBrd_no(rs.getInt("brd_no"));
				recommendboard.setBrd_subject(rs.getString("brd_subject"));
				recommendboard.setBrd_content(rs.getString("brd_content"));
				recommendboard.setBrd_recommand(rs.getInt("brd_readcount"));
				recommendboard.setBrd_ip(rs.getString("brd_ip"));
				recommendboard.setBrd_reg_date(rs.getDate("brd_reg_date"));
				recommendboard.setBrd_dey_yn(rs.getString("brd_del_yn"));
				recommendboard.setRef(rs.getInt("ref"));
				recommendboard.setRe_step(rs.getInt("re_step"));
				recommendboard.setRe_level(rs.getInt("re_level"));
				recommendboard.setM_no(rs.getInt("m_no"));
				list.add(recommendboard);
			}				
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}		
		return list;
	}

}
