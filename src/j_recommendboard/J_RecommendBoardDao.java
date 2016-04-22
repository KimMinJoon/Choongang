package j_recommendboard;

import java.io.Reader;
import java.util.*;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import j_onelineboard.J_OneLineReply;

public class J_RecommendBoardDao {
	
	private static J_RecommendBoardDao instance = new J_RecommendBoardDao();
	private static SqlSession session;
	private J_RecommendBoardDao() {	}
	public static J_RecommendBoardDao getInstance() {
		return instance;
	}
	
	static {
	    try {
	      Reader reader = Resources.getResourceAsReader("configuration.xml");
	      SqlSessionFactory sf = new SqlSessionFactoryBuilder().build(reader); 
	      session = sf.openSession(true);
	      reader.close(); 
	    }catch (Exception e) {
	    	System.out.println("sqlMap에러");
	    }
	}
	
	public int selectTotal(String searchType, String searchTxt) {
		int total = 0;
		try {
			J_RecommendBoard jrb = new J_RecommendBoard();
			jrb.setSearchType(searchType);
			jrb.setSearchTxt(searchTxt);
			total = (Integer) session.selectOne("selectrecoTotal");
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return total;
	}
	
	public void updateHit(int brd_no) {
		try {
			session.update("updaterecoHit", brd_no);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public List<J_RecommendBoard> selectList(int startRow, int endRow, String searchType, String searchTxt) {
		List<J_RecommendBoard> list = new ArrayList<J_RecommendBoard>();
		J_RecommendBoard jrb = new J_RecommendBoard();
		jrb.setStartRow(startRow);
		jrb.setEndRow(endRow);
		jrb.setSearchType(searchType);
		jrb.setSearchTxt(searchTxt);
		
		try {
			list = session.selectList("selectrecoList", jrb);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}
	
	public int insert(J_RecommendBoard recommendboard) {
		int result = 0, number = 0;
		try {
			number = (int)session.selectOne("insertNum");
			if (recommendboard.getBrd_no() > 0) {
				session.update("stepreco", recommendboard);
				recommendboard.setRe_level(recommendboard.getRe_level() + 1);
				recommendboard.setRe_step(recommendboard.getRe_step() + 1);
			} else {
				recommendboard.setRef(number);
			}
			recommendboard.setBrd_no(number);
			result = session.insert("insertreco", recommendboard);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	public J_RecommendBoard select(int brd_no) {
		J_RecommendBoard jrb = null;
		try {
			jrb = (J_RecommendBoard) session.selectOne("selectreco", brd_no);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return jrb;
	}
	
	public int update(J_RecommendBoard recommendboard) {
		int result = 0;
		try {
			result = session.update("updatereco", recommendboard);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public int delete(int brd_no) {
		int result = 0;
		try {
			result = session.update("deletereco", brd_no);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	public J_RecommendBoard pwdCheck(int brd_no) {
		J_RecommendBoard recommendboard = new J_RecommendBoard();
		try {
			String m_passwd = (String)session.selectOne("pwdrecoCheck",brd_no);
			recommendboard.setM_passwd(m_passwd);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return recommendboard;
	}
	
	public int selectRecommend(String m_no, int brd_no) {
		int result = 0;
		int mno = Integer.parseInt(m_no);
		HashMap<String, Integer> hm = new HashMap<>();
		hm.put("m_no", mno);
		hm.put("brd_no", brd_no);
		try {
			result = (int)session.selectOne("selectrecoRecommend", hm);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	public int recoCheck(String m_no, int brd_no) {
		int result = 0;
		int mno = Integer.parseInt(m_no);
			try {
				HashMap<String, Integer> hm = new HashMap<>();
				hm.put("m_no", mno);
				hm.put("brd_no", brd_no);
				result = (int)session.selectOne("recoCheck1", hm);
				if(result != 1){
					result = (int)session.insert("recoCheck2", hm);
					if(result > 0){
						result = 1;
					}else{
						result = -1;
					}
				}else {
					result = (int)session.delete("recoCheck3", hm);
					if(result > 0){
						result = 0;
					}else{
						result = -1;
					}
				}
			}catch (Exception e) {
				System.out.println("recoCheck : " + e.getMessage());
			}
		return result; 
	}
	
	public List<J_RecoReply> selectReply(int brd_no){
		List<J_RecoReply> list = new ArrayList<>();
		try{
			list = session.selectList("selectrecoRp", brd_no);
		}catch(Exception e){
			System.out.println("selectrecoRp : " + e.getMessage());
		}	 
		return list;
	}//selectrecoReply
	
	public int insertReply(J_RecoReply jrr){
		int result = 0;
		int number = 0;
		try {
			number = (int)session.selectOne("insertRpNum");
			jrr.setRe_no(number);
			result = session.insert("insertrecoRp", jrr);
		}catch(Exception e) {
			System.out.println("insertrecoRp : " + e.getMessage());
		}
		return result;
	}//insertrecoReply
	
	public int updateReply(J_RecoReply jrr){
		int result = 0;
		try {
			result = session.update("updaterecoRp", jrr);
		}catch(Exception e){
			System.out.println("updaterecoRp : " + e.getMessage());
		}
		return result;
	}//updaterecoReply
	
	public int deleteReply(int re_no){
		int result = 0;
		try {
			result = session.update("deleterecoRp", re_no);
		}catch(Exception e){
			System.out.println("deleterecoRp : " + e.getMessage());
		}
		return result;
	}//deleterecoReply
	
}
