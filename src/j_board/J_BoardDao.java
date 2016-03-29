package j_board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class J_BoardDao {
	private static J_BoardDao instance = new J_BoardDao();//싱글톤 생성
	private J_BoardDao() {}
	public static J_BoardDao getInstance(){
		return instance;
	}
	
	public Connection getConnection(){//커넥션 풀 
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}//getConnection
	
	public int insertBoard(J_Board board){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int brd_number = 0;
		
		String sql = "insert into j_board values(?,?,?,?,?,?,?,sysdate,?,'n',?,?,?)";
		String sql1 = "select nvl(max(brd_no),0)+1 from j_board";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if (rs.next())
				brd_number = rs.getInt(1);
			pstmt.close();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, brd_number);
			pstmt.setString(2, board.getBrd_subject()); 
			//한줄 게시판은 게시글제목 정보를 가지지 않으나 
			//J_board 테이블의 brd_subject 가 not null 로 정의 되어있어
			//임의의 값 'oneLine' 을 입력하였다.
			pstmt.setString(3, board.getBrd_content());
			pstmt.setString(4, board.getBrd_category());
			pstmt.setInt(5, board.getBrd_readcount());
			pstmt.setInt(6, board.getBrd_recommand());
			pstmt.setString(7, board.getBrd_ip());
			pstmt.setDate(8, board.getBrd_update_date());
			pstmt.setInt(9, board.getM_no());
			pstmt.setString(10, board.getL_code());
			pstmt.setString(11, board.getB_code());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}//insertOneline
	
	public List<J_Board> selectOneLine(){
		List<J_Board> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select m_nick, brd_reg_date, brd_content, brd_del_yn, a.m_no from j_board a, j_member b where a.m_no = b.m_no and b_code = 'olb';";
		try{
			
		}catch(Exception e){
			System.out.println("list.size : " + list.size());
			System.out.println("selectOneLine : " + e.getMessage());
		}finally {
			dbClose(rs, pstmt, conn);
		}
		return list;
	}//selectOneLine
	
	
	public void dbClose(ResultSet rs,PreparedStatement pstmt, Connection conn){
		try{
			if(rs != null){
				rs.close();
			}
			if(pstmt != null){
				pstmt.close();
			}
			if(conn != null){
				conn.close();
			}
		}catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}
	public void dbClose(PreparedStatement pstmt, Connection conn){	
		try{
			if(pstmt != null){
				pstmt.close();
			}
			if(conn != null){
				conn.close();
			}
		}catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}
}
