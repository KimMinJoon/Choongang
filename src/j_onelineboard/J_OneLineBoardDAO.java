/**
 * 한줄게시판 DAO 클래스
 * 한줄게시판에 보여질 모든 데이터베이스 정보를 가져오는 역할을 수행
 * 
 * @version 1.1.1
 * @author 이재설
 */
package j_onelineboard;

import java.io.Reader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import j_meetboard.J_MeetBoardDao;


public class J_OneLineBoardDAO {
	// 싱글톤 생성
		private static J_OneLineBoardDAO instance = new J_OneLineBoardDAO();
		private static SqlSession session;
		private J_OneLineBoardDAO() {
		}

		public static J_OneLineBoardDAO getInstance() {
			return instance;
		}

		// 커넥션 풀 대신해서 마이바티스 사용
		static {
		    try {
		      Reader reader = 
		    	Resources.getResourceAsReader("configuration.xml");
		      SqlSessionFactory sf = new SqlSessionFactoryBuilder().build(reader);
		      //session = sf.openSession(true);//이걸 안하면 커밋이안된다.!!!!!!왜? 트루가 커밋을 하겟다는의미이다.
		      reader.close();
		    } catch (Exception e) { 
		    	System.out.println("sqlMap에러");
		    }
		}
	

	public int insertBoard(J_OneLineBoard job){
		int result = 0;//결과값
		try{
			result = session.insert("insertOneLine",job);
			session.commit();
		}catch(Exception e) {
			System.out.println("insertBoard : " + e.getMessage());
			session.rollback();
		}
		return result;
	}//insertOneline
	
	
	public List<J_OneLineBoard> selectOneLine(int startRow, int endRow, String searchType, String searchTxt){
		List<J_OneLineBoard> list = new ArrayList<>();
		J_OneLineBoard jolb = new J_OneLineBoard();
		jolb.setStartRow(startRow);
		jolb.setEndRow(endRow);
		jolb.setSearchType(searchType);
		jolb.setSearchTxt(searchTxt);
		try{ 
			list = session.selectList("selectOneLine",jolb);
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}//selectOneLine


	public int selectTotal(String searchType, String searchTxt){
		int total = 0;
		try{
			J_OneLineBoard jolb = new J_OneLineBoard();
			jolb.setSearchType(searchType);
			jolb.setSearchTxt(searchTxt);
			total = (Integer)session.selectOne("selectTotal",jolb);
		}catch(Exception e){
			System.out.println("selectTotal : " + e.getMessage());
		}
		return total;
	}//selectTotal
	
	public int updateBoard(J_OneLineBoard jolb){
		int result = 0;
		try{
			result = session.update("updateOneline",jolb);
			session.commit();
		}catch(Exception e){
			System.out.println("updateBoard : " + e.getMessage());
			session.rollback();
		}
		return result;
	}//updateBoard
	

	public int deleteBoard(int brd_no){
		int result = 0;
		
		try{
			result = session.update("deleteOneline",brd_no);
			session.update("deleteOnelineCascade",brd_no);
			session.commit();
		}catch(Exception e){
			System.out.println("updateBoard : " + e.getMessage());
			session.rollback();
		}
		return result;
	}//deleteBoard
	
	public int insertReply(J_OneLineReply jolr){
		int result = 0;
		int rpl_number = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		System.out.println(jolr);
		
		String sql = "insert into J_onelineReply values (?,?,?,sysdate,null,?,'n',null)";
		String sql1 = "select nvl(max(REPLY_NO),0)+1 from J_onelineReply";
		
		
		return result;
	}//insertReply
	
	public int updateReply(J_OneLineReply jolr){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE J_ONELINEREPLY SET CONTENT = ? WHERE REPLY_NO = ? AND DEL_YN = 'n'";
		
		
		return result;
	}//updateReply
	
	public int deleteRep(int reply_no){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE J_ONELINEREPLY SET OUT_DATE = SYSDATE, DEL_YN = 'y' WHERE REPLY_NO = ? AND DEL_YN = 'n'";
		
		
		return result;
	}//deleteRep
	
	public List<J_OneLineReply> selectReply(){
		List<J_OneLineReply> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT REPLY_NO,BRD_NO, CONTENT, FC_DATE_CHECK(REG_DATE) AS REG_DATE, M_NICK, A.M_NO FROM J_ONELINEREPLY A, J_MEMBER B WHERE A.M_NO = B.M_NO AND DEL_YN = 'n'";
	
		
		return list;
	}//selectReply
}
