package j_meetboard;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class J_MeetBoardDao {
	// 싱글톤 생성
	private static J_MeetBoardDao instance = new J_MeetBoardDao();
	private static SqlSession session;
	private J_MeetBoardDao() {	}
	public static J_MeetBoardDao getInstance() {
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
	
	public int selectTotal(String searchType, String searchTxt){
		int total = 0;
		try {
			J_MeetBoard jmb = new J_MeetBoard();
			jmb.setSearchType(searchType);
			jmb.setSearchTxt(searchTxt);
			total = (Integer) session.selectOne("selectTotalJ_MeetBoard", jmb);
		} catch (Exception e) {
			System.out.println("selectTotal : " + e.getMessage());
		}
		return total;
	}

	public List<J_MeetBoard> selectList(int startRow, int endRow, String searchType, String searchTxt) {
		List<J_MeetBoard> list = new ArrayList<J_MeetBoard>();
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("startRow", startRow);
		hm.put("endRow", endRow);
		hm.put("searchType", searchType);
		hm.put("searchTxt", searchTxt);
		
		try {
			list = session.selectList("selectListJ_MeetBoard",hm);
		} catch (Exception e) {
			System.out.println("selectList : " + e.getMessage());
		}
		return list;
	}
	
	public J_MeetBoard select(int brd_no) {
		J_MeetBoard meetboard = null;
		try {
			meetboard = (J_MeetBoard)session.selectOne("select",brd_no);
			
		} catch (Exception e) {
			System.out.println("select : " + e.getMessage());
		} 
		return meetboard;
	}
	
	public void updateHit(int brd_no) {
		try {
			session.update("updateHit",brd_no);
		} catch (Exception e) {
			System.out.println("updateHit : " + e.getMessage());
		}
	}
	
	public int selectRecommend(int m_no, int brd_no){
		int result = 0;
		HashMap<String, Integer> hm = new HashMap<>();
		hm.put("m_no", m_no);
		hm.put("brd_no", brd_no);
		
		try{
			result = (int)session.selectOne("selectRecommend",hm);
		} catch(Exception e){
			System.out.println("selectRecommend : " + e.getMessage());
		}
		return result;
	}
	
	public int insert(J_MeetBoard meetboard) {
		int result = 0;
		int number = 0;// brd_no이다~
		try {
			number = (int)session.selectOne("insertNumber");
			meetboard.setBrd_no(number);
			result = (int)session.insert("insert",meetboard);
		} catch (Exception e) {
			System.out.println("insert : " + e.getMessage());
		} 
		return result;
	}

	public int update(J_MeetBoard meetboard) {
		int result = 0;
		try {
			result = (int)session.update("update",meetboard);

		} catch (Exception e) {
			System.out.println("update : " + e.getMessage());
		}
		return result;
	}
	
	public int delete(int brd_no) {
		int result = 0;
		try {
			result = (int)session.update("delete",brd_no);
			
		} catch (Exception e) {
			System.out.println("delete : " + e.getMessage());
		}
		return result;
	}

	public J_MeetBoard passwdChk(int brd_no) {
		J_MeetBoard meetboard = new J_MeetBoard();
		try {
			String dbpass = (String)session.selectOne("passwdChk",brd_no);
			meetboard.setM_passwd(dbpass);
			
		} catch (Exception e) {
			System.out.println("passwdChk : " + e.getMessage());
		}
		return meetboard;
	}

	public int recommendChk(int m_no, int brd_no) {
		int result = 0;
			try {
				
				HashMap<String, Integer> hm = new HashMap<>();
				hm.put("m_no", m_no);
				hm.put("brd_no", brd_no);
				result = (int)session.selectOne("recommendChk1",hm);
				if(result != 1){
					result = (int)session.insert("recommendChk2",hm);
					if(result > 0){
						result = 1;
					}else{
						result = -1; //추천 실패
					}
				}else{
					result = (int)session.delete("recommendChk3",hm);
					if(result > 0){
						result = 0; //추천 성공
					}else{
						result = -1; //추천 취소 실패
					}
				}
			} catch (Exception e) {
				System.out.println("recommendChk : " + e.getMessage());
			}
		return result; 
	}
	
	public List<J_MeetBoard> selectList_home_reco() {
		List<J_MeetBoard> list1 = new ArrayList<J_MeetBoard>();
		
		try {
			list1 = session.selectList("selectListJ_MeetBoard_home_reco");
			
		} catch (Exception e) {
			System.out.println("selectListJ_MeetBoard_home_reco : " + e.getMessage());
		} 
		return list1;
	}
	
	public List<J_MeetBoard> selectList_home_new() {
		List<J_MeetBoard> list2 = new ArrayList<J_MeetBoard>();
		
		try {
			list2 = session.selectList("selectListJ_MeetBoard_home_new");
			
		} catch (Exception e) {
			System.out.println("selectListJ_MeetBoard_home_new : " + e.getMessage());
		} 
		return list2;
	}
	
	public List<J_MeetBoard> selectList_home_read() {
		List<J_MeetBoard> list3 = new ArrayList<J_MeetBoard>();
		
		try {
			list3 = session.selectList("selectListJ_MeetBoard_home_read");
			
		} catch (Exception e) {
			System.out.println("selectListJ_MeetBoard_home_read : " + e.getMessage());
		} 
		return list3;
	}

}
