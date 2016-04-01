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

	public List<J_NoticeBoard> selectList(int startRow, int endRow) throws SQLException {
		List<J_NoticeBoard> list = new ArrayList<J_NoticeBoard>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from (select rowNum rn, a.* from (select mb.* from j_noticeboard mb, j_member m where mb.admin = m.m_email order by brd_no desc) a ) where rn between ? and ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);// 먼저 값을 읽어와야함
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				J_NoticeBoard nb = new J_NoticeBoard();
				nb.setBrd_no(rs.getInt("brd_no"));
				nb.setBrd_subject(rs.getString("brd_subject"));
				nb.setBrd_content(rs.getString("brd_content"));
				nb.setBrd_readcount(rs.getInt("brd_readcount"));
				nb.setBrd_reg_date(rs.getDate("brd_reg_date"));
				nb.setBrd_update_date(rs.getDate("brd_update_date"));
				nb.setBrd_del_yn(rs.getString("brd_del_yn"));
				nb.setAdmin(rs.getString("admin"));
				list.add(nb);
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

		return list;
	}

	public int insert(J_NoticeBoard noticeboard) throws SQLException {
		int result = 0;
		int number = 0;// brd_no이다~
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into j_noticeboard values(?,?,?,0,sysdate,sysdate,'n','Master')";
		// brdno,subject,content,readcount,recommend,ip,regdate,updatedate,delyn,m_no,mccode,lcode
		// 처음에 입력될때는 n으로 입력되야합니다~
		String sql1 = "select nvl(max(brd_no),0)+1 from j_noticeboard";
		// num이 처음에 널일수잇으니nvl쓰고 시퀀스 오토 구분없이 오라클 mysql 통합으로 사용가능함

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);// 먼저 값을 읽어와야함
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1); // 값을 세팅
			}
			pstmt.close();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, noticeboard.getBrd_subject());
			pstmt.setString(3, noticeboard.getBrd_content());
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

	public J_NoticeBoard select(int brd_no) throws SQLException {
		J_NoticeBoard nb = new J_NoticeBoard();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from j_noticeboard where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);// 먼저 값을 읽어와야함
			pstmt.setInt(1, brd_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				nb.setBrd_no(rs.getInt("brd_no"));
				nb.setBrd_subject(rs.getString("brd_subject"));
				nb.setBrd_content(rs.getString("brd_content"));
				nb.setBrd_reg_date(rs.getDate("brd_reg_date"));
				nb.setBrd_readcount(rs.getInt("brd_readcount"));
				nb.setAdmin(rs.getString("admin"));
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

		return nb;
	}

	public void updateHit(int brd_no) throws SQLException {

		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "update j_noticeboard set brd_readcount = brd_readcount+1 where brd_no=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);// 먼저 값을 읽어와야함
			pstmt.setInt(1, brd_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
	}

	public int update(J_NoticeBoard noticeboard) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_noticeboard set brd_subject=?,brd_content=? where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, noticeboard.getBrd_subject());
			pstmt.setString(2, noticeboard.getBrd_content());
			pstmt.setInt(3, noticeboard.getBrd_no());
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

	public int delete(int brd_no) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		// String sql = "delete from board1 where num=?";
		String sql = "update j_noticeboard set brd_del_yn='y' where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
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

}