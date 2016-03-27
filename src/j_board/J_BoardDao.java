package j_board;

import java.io.Reader;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class J_BoardDao {
	private static SqlSession session;
	private static J_BoardDao instance = new J_BoardDao();//싱글톤 생성
	private J_BoardDao() {}
	public static J_BoardDao getInstance(){
		return instance;
	}
	static {
	    try {
	      Reader reader = 
	    	Resources.getResourceAsReader("configuration.xml");
	      SqlSessionFactory sf = new SqlSessionFactoryBuilder().build(reader); 
	      session = sf.openSession(true);//이걸 안하면 커밋이안된다.!!!!!!왜? 트루가 커밋을 하겟다는의미이다.
	      reader.close(); 
	    } catch (Exception e) { System.out.println("sqlMap에러"); }
	}

	
	public int selectTotal() throws SQLException {
		int total = 0;
		
		try {
			total = (Integer) session.selectOne("selectTotal");
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			
		}
		return total;
	}
	
	public List<J_MeetBoard> selectList(int startRow,int endRow) throws SQLException {
		List<J_MeetBoard> list = null;
		HashMap<String, Integer> hm = new HashMap<>();
		
		hm.put("startRow", startRow);
		hm.put("endRow", endRow);
		
		try {
			list = session.selectList("selectListJ_MeetBoard",hm);//
				
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			
		}
		
		return list;
	}
	
	
}
