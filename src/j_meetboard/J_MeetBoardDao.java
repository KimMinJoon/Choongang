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
		//String sql = "select count(*) from j_meetboard mb, j_member m where mb.m_no = m.m_no and brd_del_yn='n'";
		
		/*String sql2="";
		
		if(searchType.equals("all")){
			sql2 = " and (brd_content like '%" + searchTxt + "%' or brd_subject like '%" + searchTxt + "%')";	
		} else if (searchType.equals("m_nick")){
			sql2 = " and " + searchType + " like '%" + searchTxt + "%'";
		} else {
			sql2 = " and " + searchType + " like '%" + searchTxt + "%'";
		} 
		if(!searchTxt.equals("")){
			sql += sql2;
		} */
		try {
			total = (Integer) session.selectOne("selectTotalJ_MeetBoard");
				
		} catch (Exception e) {
			System.out.println("selectTotal : " + e.getMessage());
		}
		return total;
	}


	
	public List<J_MeetBoard> selectList(int startRow, int endRow, String searchType, String searchTxt) {
		List<J_MeetBoard> list = new ArrayList<J_MeetBoard>();
		
		HashMap<String, Integer> hm = new HashMap<>();
		hm.put("startRow", startRow);
		hm.put("endRow", endRow);
		
		/*String sql2="";
		if(searchType.equals("all")){
			sql2 = " and (brd_content like '%" + searchTxt + "%' or brd_subject like '%" + searchTxt + "%')";
		} else {
			sql2 = " and " + searchType + " like '%" + searchTxt + "%'";
		}//조건 검색시 추가되어야할 QUERY
		
		if(searchTxt.equals("")){
			sql2 = "";
		}//검색내용이 없다면 검색을 하지 않고 모든 게시글을 가져오는 것으로 판단 */		
		
		//String sql = "select * from (select rowNum rn, a.* from (select mb.*, m.m_nick, c.c_value as c_value_cate, d.c_value as c_value_lang, nvl(rc.brd_recommend,0) as brd_recommend from j_meetboard mb, j_member m, j_code c, j_code d, (select brd_no, count(*) as brd_recommend from j_recommend group by brd_no) rc where rc.brd_no(+) = mb.brd_no and mb.m_no = m.m_no and mb.mc_code = c.c_minor and mb.l_code = d.c_minor and brd_del_yn='n'"+sql2+" order by mb.brd_no desc) a) where rn between ? and ?";
		
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
		System.out.println("Dao의 selectRecommend으로 들어오는 값입니다 : "+m_no+" "+brd_no);
		
		try{
			result = (int)session.selectOne("selectRecommend",hm);
			System.out.println("selectRecommend 하고 돌려받은 반환값입니다. : "+result);
		} catch(Exception e){
			System.out.println("selectRecommend : " + e.getMessage());
		}
		return result;
	}
	
	
	public int insert(J_MeetBoard meetboard) {
		int result = 0;
		int number = 0;// brd_no이다~
		//HashMap<String, Integer> hm = new HashMap<>();
		//String sql = "insert into j_meetboard values(?,?,?,0,?,sysdate,null,'n',?,?,?)";
		// brdno,subject,content,readcount,recommend,ip,regdate,updatedate,delyn,m_no,mccode,lcode
		// 처음에 입력될때는 n으로 입력되야합니다~
		//String sql1 = "select nvl(max(brd_no),0)+1 from j_meetboard";
		// num이 처음에 널일수잇으니nvl쓰고 시퀀스 오토 구분없이 오라클 mysql 통합으로 사용가능함

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
		//String sql = "update j_meetboard set brd_subject=?,brd_content=?,l_code=?,mc_code=?,brd_update_date=sysdate where brd_no=?";
		try {
			result = (int)session.update("update",meetboard);

		} catch (Exception e) {
			System.out.println("update : " + e.getMessage());
		}
		return result;
	}
	
	
	public int delete(int brd_no) {
		int result = 0;
		// String sql = "delete from board1 where num=?";
		//String sql = "update j_meetboard set brd_del_yn='y' where brd_no=?";
		try {
			result = (int)session.update("delete",brd_no);
			
		} catch (Exception e) {
			System.out.println("delete : " + e.getMessage());
		}
		return result;
	}
	

	public J_MeetBoard passwdChk(int brd_no) {
		J_MeetBoard meetboard = new J_MeetBoard();
		//String sql = "select m.m_passwd from j_meetboard mb, j_member m where mb.m_no = m.m_no and brd_no=?";
		try {
			String dbpass = (String)session.selectOne("passwdChk",brd_no);
			//System.out.println("passwdChk : " + dbpass);
			meetboard.setM_passwd(dbpass);
			
		} catch (Exception e) {
			System.out.println("passwdChk : " + e.getMessage());
		}
		return meetboard;
	}


	public int recommendChk(int m_no, int brd_no) {
		int result = 0;
		//String sql2 = "select * from j_recommend where m_no = ? and brd_no = ?";
		//String sql = "insert into j_recommend values(?,?,sysdate,'n')";
		//String sql3 = "delete from j_recommend where m_no = ? and brd_no = ?";	
			try {
				
				HashMap<String, Integer> hm = new HashMap<>();
				hm.put("m_no", m_no);
				hm.put("brd_no", brd_no);
				
				System.out.println("Dao의 recommendChk로 들어오는 값입니다 : "+m_no+" "+brd_no);
				
				result = (int)session.selectOne("recommendChk1",hm);
				System.out.println("recommendChk1 추천한 이력이있는지 없는지 확인 : " + result);
				
			/*	pstmt = conn.prepareStatement(sql2);// 먼저 값을 읽어와야함
				pstmt.setInt(1, m_no);
				pstmt.setInt(2, brd_no);
				rs = pstmt.executeQuery();*/
				if(result != 1){
					result = (int)session.insert("recommendChk2",hm);
					//System.out.println(m_no + " 의 " + brd_no + " 추천이력 확인");
					/*rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql3);
					pstmt.setInt(1, m_no);
					pstmt.setInt(2, brd_no);
					result = pstmt.executeUpdate();*/
					
					System.out.println("recommendChk2 추천이력이없으면 입력해라! : " + result);
					if(result > 0){
						result = 1; //추천 취소 성공
					}else{
						result = -1; //추천 실패
					}
				}else{
					result = (int)session.delete("recommendChk3",hm);
					//System.out.println(m_no + " 의 " + brd_no + " 추천이력 미확인");
					/*rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, brd_no);
					pstmt.setInt(2, m_no);
					result = pstmt.executeUpdate();*/
					if(result > 0){
						result = 0; //추천 성공
					}else{
						result = -1; //추천 취소 실패
					}
				}
			} catch (Exception e) {
				System.out.println("recommendChk : " + e.getMessage());
			}
		//System.out.println("result : " + result);
		return result; 
	}

}
