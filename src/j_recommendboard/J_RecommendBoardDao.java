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
		String sql = "select * from (select rowNum rn, a.* from (select jrb.* ,m.m_nick, c.c_value from j_recommendboard jrb, j_member m, j_code c where jrb.m_no = m.m_no and jrb.mc_code = c.c_minor order by brd_no desc) a ) where rn between ? and ?";
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
				recommendboard.setBrd_readcount(rs.getInt("brd_readcount"));
				recommendboard.setBrd_recommend(rs.getInt("brd_recommend"));
				recommendboard.setBrd_ip(rs.getString("brd_ip"));
				recommendboard.setBrd_reg_date(rs.getDate("brd_reg_date"));
				recommendboard.setBrd_update_date(rs.getDate("brd_update_date"));
				recommendboard.setBrd_dey_yn(rs.getString("brd_del_yn"));
				recommendboard.setRef(rs.getInt("ref"));
				recommendboard.setRe_step(rs.getInt("re_step"));
				recommendboard.setRe_level(rs.getInt("re_level"));
				recommendboard.setM_no(rs.getInt("m_no"));
				recommendboard.setM_nick(rs.getString("m_nick"));
				recommendboard.setC_value(rs.getString("c_value"));
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
	
	public int insert(J_RecommendBoard recommendboard) throws SQLException {
		int result = 0, number = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into j_recommendboard values(?,?,?,0,0,?,sysdate,sysdate,'n',?,?,?,?,?)";
		String sql1 = "select nvl(max(brd_no),0)+1 from j_recommendboard";
		String sql2 = "update j_recommendboard set re_step=re_step+1 where ref=? and re_step > ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1);
			pstmt.close();
			if (recommendboard.getBrd_no() != 0) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, recommendboard.getRef());
				pstmt.setInt(2, recommendboard.getRe_step());
				pstmt.executeUpdate();
				pstmt.close();
				recommendboard.setRe_level(recommendboard.getRe_level() + 1);
				recommendboard.setRe_step(recommendboard.getRe_step() + 1);
			} else {
				recommendboard.setRef(number);
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, recommendboard.getBrd_subject());
			pstmt.setString(3, recommendboard.getBrd_content());
			pstmt.setString(4, recommendboard.getBrd_ip());
			pstmt.setInt(5, recommendboard.getRef());
			pstmt.setInt(6, recommendboard.getRe_step());
			pstmt.setInt(7, recommendboard.getRe_level());
			pstmt.setInt(8, recommendboard.getM_no());
			pstmt.setString(9, recommendboard.getMc_code());
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

}
