package j_onelineboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import j_board.J_Board;

public class J_OneLineBoardDAO {
	private static J_OneLineBoardDAO instance = new J_OneLineBoardDAO();//싱글톤 생성
	private J_OneLineBoardDAO() {}
	public static J_OneLineBoardDAO getInstance(){
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
	
	public int insertBoard(J_OneLineBoard job){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int brd_number = 0;
		
		String sql = "insert into J_OneLineBoard values(?,?,sysdate,null,?,'n',?,null)";
		String sql1 = "select nvl(max(brd_no),0)+1 from J_OneLineBoard";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if (rs.next())
				brd_number = rs.getInt(1);
			pstmt.close();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_number);
			//한줄 게시판은 게시글제목 정보를 가지지 않으나 
			//J_board 테이블의 brd_subject 가 not null 로 정의 되어있어
			//임의의 값 'oneLine' 을 입력하였다.
			pstmt.setString(2, job.getBrd_content());
			pstmt.setString(3, job.getBrd_ip());
			pstmt.setInt(4, job.getM_no());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}//insertOneline
	
	public List<J_OneLineBoard> selectOneLine(int startRow, int endRow){
		List<J_OneLineBoard> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM (SELECT ROWNUM RN, A.* FROM(select m_nick, brd_no, fc_date_check(brd_reg_date) as dt, brd_content, brd_del_yn, a.m_no,(select count(*) from J_ONELINEREPLY c where c.brd_no = a.brd_no) rep_count from J_OneLineBoard a, j_member b where a.m_no = b.m_no and brd_del_yn = 'n' order by brd_no desc) A) WHERE RN BETWEEN ? AND ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				J_OneLineBoard jolb = new J_OneLineBoard();
				jolb.setM_nick(rs.getString("M_NICK"));
				jolb.setBrd_no(rs.getInt("BRD_NO"));
				jolb.setBrd_content(rs.getString("BRD_CONTENT"));
				jolb.setBrd_reg_date(rs.getString("DT"));
				jolb.setBrd_del_yn(rs.getString("BRD_DEL_YN"));
				jolb.setM_no(rs.getInt("M_NO"));
				jolb.setRep_count(rs.getInt("REP_COUNT"));
				
				list.add(jolb);
			}
		}catch(Exception e){
			System.out.println("selectOneLine : " + e.getMessage());
		}finally {
			dbClose(rs, pstmt, conn);
		}
		return list;
	}//selectOneLine
	
	public J_OneLineBoard selectOneLineByNo(int brd_no){
		J_OneLineBoard jolb  = new J_OneLineBoard();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select brd_no,m_nick, brd_reg_date,brd_content from J_OneLineBoard a , J_MEMBER b where a.m_no = b.m_no and brd_del_yn = 'n' and brd_no = ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				jolb.setBrd_no(rs.getInt("BRD_NO"));
				jolb.setM_nick(rs.getString("M_NICK"));
				jolb.setBrd_reg_date(rs.getString("BRD_REG_DATE"));
				jolb.setBrd_content(rs.getString("BRD_CONTENT"));
			}
		}catch(Exception e){
			System.out.println(jolb);
			System.out.println("selectOneLineByNo : " + e.getMessage());
		}finally {
			dbClose(rs, pstmt, conn);
		}
		return jolb;
	}//selectOneLineByNo
	
	public int selectTotal(){
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) FROM J_OneLineBoard WHERE BRD_DEL_YN = 'n'";
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				total = rs.getInt(1);
			}
		} catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			dbClose(rs, pstmt, conn);
		}
		return total;
	}//selectTotal
	
	public int updateBoard(J_OneLineBoard jolb){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update J_OneLineBoard set brd_content = ? , brd_update_date = sysdate where brd_no = ? and m_no = ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jolb.getBrd_content());
			pstmt.setInt(2,	jolb.getBrd_no());
			pstmt.setInt(3, jolb.getM_no());
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally {
			dbClose(pstmt, conn);
		}
		return result;
	}//updateBoard
	
	public int deleteBoard(int brd_no){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("brd_no : " + brd_no);
		String sql = "update j_onelineboard set brd_del_yn = 'y',brd_out_date = sysdate where brd_no = ? and brd_del_yn = 'n'";
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally {
			dbClose(pstmt, conn);
		}
		return result;
	}
	
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
	}//dbClose( rs,pstmt, conn)
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
	}//dbClose( pstmt, conn)
}
