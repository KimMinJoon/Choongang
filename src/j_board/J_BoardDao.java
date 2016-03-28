package j_board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	}
	
	public int insertOneline(String m_no, String brd_content,String brd_ip){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int brd_number = 0;
		
		String sql = "insert into j_board values(?,'oneline',?,null,0,0,?,sysdate,null,'n',?,null,'olb')";
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
			pstmt.setString(2, brd_content);
			pstmt.setString(3, brd_ip);
			pstmt.setString(4, m_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
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
