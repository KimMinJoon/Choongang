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
		      session = sf.openSession(false);//이걸 안하면 커밋이안된다.!!!!!!왜? 트루가 커밋을 하겟다는의미이다.
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
			System.out.println("selectOneLine : " + e.getMessage());
		}
		return list;
	}//selectOneLine


	public int selectTotal(String searchType, String searchTxt){
		int total = 0;
		try{
			J_OneLineBoard jolb = new J_OneLineBoard();
			jolb.setSearchType(searchType);
			jolb.setSearchTxt(searchTxt);
			total = (Integer)session.selectOne("selectOnelineTotal",jolb);
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
			System.out.println("deleteBoard : " + e.getMessage());
			session.rollback();
		}
		return result;
	}//deleteBoard
	
	public int insertReply(J_OneLineReply jolr){
		int result = 0;//결과값
		try{
			result = session.insert("insertOneLineRep",jolr);
			session.commit();
		}catch(Exception e) {
			System.out.println("insertReply : " + e.getMessage());
			session.rollback();
		}
		return result;
	}//insertReply
	
	public int updateReply(J_OneLineReply jolr){
		int result = 0;
		try{
			result = session.update("updateReply",jolr);
			session.commit();
		}catch(Exception e){
			System.out.println("updateReply : " + e.getMessage());
			session.rollback();
		}
		return result;
	}//updateReply
	
	public int deleteRep(int reply_no){
		int result = 0;
		try{
			result = session.update("deleteRep",reply_no);
			session.commit();
		}catch(Exception e){
			System.out.println("deleteRep : " + e.getMessage());
			session.rollback();
		}
		return result;
	}//deleteRep
	
	public List<J_OneLineReply> selectReply(){
		List<J_OneLineReply> list = new ArrayList<>();
		try{
			list = session.selectList("selectReply");
		}catch(Exception e){
			System.out.println("selectReply : " + e.getMessage());
		}	 
		return list;
	}//selectReply
}
