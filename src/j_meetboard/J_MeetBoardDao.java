package j_meetboard;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class J_MeetBoardDao {
	
	
	// 싱글톤 생성
	private static J_MeetBoardDao instance = new J_MeetBoardDao();
	private J_MeetBoardDao() {	}
	public static J_MeetBoardDao getInstance() {
		return instance;
	}
	
	
	
	// 커넥션 풀
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
	}// getConnection

	
	
	
	
	//게시판 글쓰기 
	public int insert(J_MeetBoard meetboard) throws SQLException {
		int result = 0;
		int number = 0;//brd_no이다~
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into j_meetboard values(?,?,?,0,0,?,sysdate,sysdate,'n',?,?,?)";
		//									brdno,subject,content,readcount,recommend,ip,regdate,updatedate,delyn,m_no,mccode,lcode					
		//처음에 입력될때는 n으로 입력되야합니다~
		String sql1 = "select nvl(max(brd_no),0)+1 from j_meetboard";
		//num이 처음에 널일수잇으니nvl쓰고 시퀀스 오토  구분없이 오라클 mysql 통합으로 사용가능함
	
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);//먼저 값을 읽어와야함
			rs = pstmt.executeQuery();
			if (rs.next()){
				number = rs.getInt(1); //값을 세팅
			}
			pstmt.close();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, meetboard.getBrd_subject());
			pstmt.setString(3, meetboard.getBrd_content());
			pstmt.setString(4, meetboard.getBrd_ip());
			pstmt.setInt(5, meetboard.getM_no());
			pstmt.setString(6, meetboard.getMc_code());
			pstmt.setString(7, meetboard.getL_code());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return result;
	}
	
	
	
	//
	public int selectTotal() throws SQLException {
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from j_meetboard";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);//먼저 값을 읽어와야함
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
	
	
	public List<J_MeetBoard> selectList(int startRow,int endRow) throws SQLException {
		List<J_MeetBoard> list = new ArrayList<J_MeetBoard>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = 
				"select * from (select rowNum rn, a.* from (select * from j_meetboard order by brd_no desc) a ) where rn between ? and ?";
		// 댓글 정렬 해줌!
		//가장안에 a는 num을 기준으로 역순으로 테이블을 정렬하고 그 결과값을 테이블로 사용한다.
		// 그 테이블에 rowNum(테이블 기본 오름차순 순서번호값)을 주고 별칭을 rn으로 한다 그리고 a테이블의 모든 정보를 뒤에 출력
		// 그렇게 완성된 테이블을 rn을 기준으로 1~10번까지 출력하여 그 결과값을 보여준다. 
		//결론 254개의 글이 테이블에 존재할때  254,253,252,...244까지를 1~10으로 맵핑이되며 그 수를 1~10까지 모든 속성값을 출력하라
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);//먼저 값을 읽어와야함
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				J_MeetBoard meetboard = new J_MeetBoard();
				meetboard.setBrd_no(rs.getInt("brd_no"));
				meetboard.setBrd_subject(rs.getString("brd_subject"));
				meetboard.setBrd_content(rs.getString("brd_content"));
				meetboard.setBrd_reg_date(rs.getDate("brd_reg_date"));
				meetboard.setBrd_ip(rs.getString("brd_ip"));
				meetboard.setBrd_recommand(rs.getInt("brd_readcount"));
				meetboard.setBrd_dey_yn(rs.getString("brd_del_yn"));
				meetboard.setM_no(rs.getInt("m_no"));
				list.add(meetboard);
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
	
	
	
	
	
	
	
	
	
	
	
	
	///DB close 사용자함수 생성
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
			System.out.println(e.getMessage());
		}
	}
	public void dbClose(PreparedStatement pstmt, Connection conn) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
}
