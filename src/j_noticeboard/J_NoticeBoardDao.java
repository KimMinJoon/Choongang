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
		String sql = "select * from (select rowNum rn, a.* from (select mb.* ,m.m_email from j_noticeboard mb, j_member m where mb.m_no = m.m_no order by brd_no desc) a ) where rn between ? and ?";
		// 댓글 정렬 해줌!
		// 가장안에 a는 num을 기준으로 역순으로 테이블을 정렬하고 그 결과값을 테이블로 사용한다.
		// 그 테이블에 rowNum(테이블 기본 오름차순 순서번호값)을 주고 별칭을 rn으로 한다 그리고 a테이블의 모든 정보를 뒤에
		// 출력
		// 그렇게 완성된 테이블을 rn을 기준으로 1~10번까지 출력하여 그 결과값을 보여준다.
		// 결론 254개의 글이 테이블에 존재할때 254,253,252,...244까지를 1~10으로 맵핑이되며 그 수를 1~10까지
		// 모든 속성값을 출력하라

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
				nb.setAdmin(rs.getString("m_email"));
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
}