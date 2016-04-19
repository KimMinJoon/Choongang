package j_recommendboard;

import java.io.Reader;
import java.util.*;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

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
	
	/*public int insert(J_RecommendBoard recommendboard) {
		int result = 0, number = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into j_recommendboard values(?,?,?,0,?,sysdate,null,'n',?,?,?,?,?)";
		String sql1 = "select nvl(max(brd_no),0)+1 from j_recommendboard";
		String sql2 = "update j_recommendboard set re_step=re_step+1 where ref=? and re_step>?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1);
			pstmt.close();
			if (recommendboard.getBrd_no() != 0) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, recommendboard.getRef());
				pstmt.setInt(2, recommendboard.getRe_step());
				pstmt.executeUpdate();
				pstmt.close();
				recommendboard.setRe_level(recommendboard.getRe_level() + 1);
				recommendboard.setRe_step(recommendboard.getRe_step() + 1);
			} else {
				recommendboard.setRef(number);
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, recommendboard.getBrd_subject());
			pstmt.setString(3, recommendboard.getBrd_content());
			pstmt.setString(4, recommendboard.getBrd_ip());
			pstmt.setInt(5, recommendboard.getRef());
			pstmt.setInt(6, recommendboard.getRe_step());
			pstmt.setInt(7, recommendboard.getRe_level());
			pstmt.setInt(8, recommendboard.getM_no());
			pstmt.setString(9, recommendboard.getRc_code());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}*/
	
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
	
}
