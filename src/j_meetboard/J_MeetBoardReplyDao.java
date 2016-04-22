package j_meetboard;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import j_onelineboard.J_OneLineReply;

public class J_MeetBoardReplyDao {
	
		// 싱글톤 생성
		private static J_MeetBoardReplyDao instance = new J_MeetBoardReplyDao();
		private static SqlSession session;
		private J_MeetBoardReplyDao() {	}
		public static J_MeetBoardReplyDao getInstance() {
			return instance;
		}
		
		// 커넥션 풀 대신해서 마이바티스 사용
		static {
		    try {
		      Reader reader = 
		    	Resources.getResourceAsReader("configuration.xml");
		      SqlSessionFactory sf = new SqlSessionFactoryBuilder().build(reader); 
		      session = sf.openSession(true);//이걸 안하면 커밋이안된다.!!!!!!왜? 트루가 커밋을 하겟다는의미이다.
		      reader.close(); 
		    } catch (Exception e) { 
		    	System.out.println("sqlMap에러"); 
		    }
		}
		
		public int insertReply(J_MeetBoardReply jmbr) {
			int result = 0;//결과값
			int number = 0;
			try{
				number = (int)session.selectOne("insertNumberReply");
				jmbr.setRe_no(number);
				result = session.insert("insertReply",jmbr);
				session.commit();
			}catch(Exception e) {
				System.out.println("insertReply : " + e.getMessage());
				session.rollback();
			}
			return result;
		}
		
		public List<J_MeetBoardReply> selectListReply(int brd_no) {
			List<J_MeetBoardReply> list = new ArrayList<J_MeetBoardReply>();
			try {
				list = session.selectList("selectListReply",brd_no);
			} catch (Exception e) {
				System.out.println("selectListReply : " + e.getMessage());
			} 
			return list;
		}
		
		public int updateReply(J_MeetBoardReply jmbr){
			int result = 0;
			try{
				result = session.update("updateMeetboardReply",jmbr);
				session.commit();
			}catch(Exception e){
				System.out.println("updateMeetboardReply : " + e.getMessage());
				session.rollback();
			}
			return result;
		}//updateReply
		
		
		public int deleteReply(int re_no){
			int result = 0;
			try{
				result = session.update("deleteReply",re_no);
				session.commit();
			}catch(Exception e){
				System.out.println("deleteReply : " + e.getMessage());
				session.rollback();
			}
			return result;
		}//deleteRep
		
}
