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
	    } catch (Exception e) { System.out.println("sqlMap에러"); 
	    
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
		
		//String sql = "select mb.*, m.m_nick as m_nick, c.c_value as c_value_lang, d.c_value as c_value_cate, rc.brd_recommend as brd_recommend from j_meetboard mb, j_member m, j_code c, j_code d, (select count(*) brd_recommend from j_recommend where brd_no=?) rc"
		//		+ " where mb.brd_no=? and mb.m_no = m.m_no and mb.l_code = c.c_minor and mb.mc_code = d.c_minor";
		try {
			
			meetboard = (J_MeetBoard)session.selectOne("select",brd_no);
			
			/*if (rs.next()) {
				meetboard.setBrd_no(rs.getInt("brd_no"));
				meetboard.setM_no(rs.getInt("m_no"));
				meetboard.setBrd_subject(rs.getString("brd_subject"));
				meetboard.setBrd_content(rs.getString("brd_content"));
				meetboard.setBrd_reg_date(rs.getDate("brd_reg_date"));
				meetboard.setBrd_update_date(rs.getDate("brd_update_date"));
				meetboard.setBrd_recommend(rs.getInt("brd_recommend"));
				meetboard.setBrd_readcount(rs.getInt("brd_readcount"));
				meetboard.setM_nick(rs.getString("m_nick"));
				meetboard.setMc_code(rs.getString("mc_code"));
				meetboard.setL_code(rs.getString("l_code"));
				meetboard.setC_value_lang(rs.getString("c_value_lang"));
				meetboard.setC_value_cate(rs.getString("c_value_cate"));
			}*/
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		return meetboard;
	}
	
	public void updateHit(int brd_no) {
		//String sql = "update j_meetboard set brd_readcount = brd_readcount+1 where brd_no=?";
		try {
			session.selectList("updateHit",brd_no);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	
	public int selectRecommend(int m_no, int brd_no){
		int result = 0;
		//String sql = "select * from j_recommend where m_no = ? and brd_no = ?";
		HashMap<String, Integer> hm = new HashMap<>();
		hm.put("m_no", m_no);
		hm.put("brd_no", brd_no);
		
		try{
			result = (int)session.selectOne("selectRecommend",hm);
				
		} catch(Exception e){
			System.out.println("selectRecommend : " + e.getMessage());
		}
		return result;
	}//selectRecommend
	
	
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
			
			result = (int)session.selectOne("insert",meetboard);
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		return result;
	}

	
	
	
	
	
	

/*	// 게시판 글쓰기
	
	

	public int recommendChk(int m_no, int brd_no) {
		Connection conn = null;
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql2 = "select * from j_recommend where m_no = ? and brd_no = ?";
		String sql = "insert into j_recommend values(?,?,sysdate,'n')";
		String sql3 = "delete from j_recommend where m_no = ? and brd_no = ?";	
		conn = getConnection();
			try {
				pstmt = conn.prepareStatement(sql2);// 먼저 값을 읽어와야함
				pstmt.setInt(1, m_no);
				pstmt.setInt(2, brd_no);
				rs = pstmt.executeQuery();
				if(rs.next()){
					//System.out.println(m_no + " 의 " + brd_no + " 추천이력 확인");
					rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql3);
					pstmt.setInt(1, m_no);
					pstmt.setInt(2, brd_no);
					result = pstmt.executeUpdate();
					if(result > 0){
						result = 1; //추천 취소 성공
					}else{
						result = -1; //추천 실패
					}
				}else{
					//System.out.println(m_no + " 의 " + brd_no + " 추천이력 미확인");
					rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, brd_no);
					pstmt.setInt(2, m_no);
					result = pstmt.executeUpdate();
					if(result > 0){
						result = 0; //추천 성공
					}else{
						result = -1; //추천 취소 실패
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				dbClose(rs, pstmt, conn);
			}
		//System.out.println("result : " + result);
		return result; 
	}

	public J_MeetBoard passwdChk(int brd_no) {
		J_MeetBoard meetboard = new J_MeetBoard();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m.m_passwd from j_meetboard mb, j_member m where mb.m_no = m.m_no and brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);// 먼저 값을 읽어와야함
			pstmt.setInt(1, brd_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				meetboard.setM_passwd(rs.getString("m_passwd"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return meetboard;
	}

	

	
	public int update(J_MeetBoard meetboard) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_meetboard set brd_subject=?,brd_content=?,l_code=?,mc_code=?,brd_update_date=sysdate where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, meetboard.getBrd_subject());
			pstmt.setString(2, meetboard.getBrd_content());
			pstmt.setString(3, meetboard.getL_code());
			pstmt.setString(4, meetboard.getMc_code());
			pstmt.setInt(5, meetboard.getBrd_no());
			System.out.println(meetboard);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println(meetboard);
			System.out.println(e.getMessage());
		} finally {
			dbClose(pstmt, conn);
		}
		return result;
	}

	public int delete(int brd_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		// String sql = "delete from board1 where num=?";
		String sql = "update j_meetboard set brd_del_yn='y' where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(pstmt, conn);
		}
		return result;
	}
	
	
	
	

	/// DB close 사용자함수 생성
	public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}

	public void dbClose(PreparedStatement pstmt, Connection conn) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}*/
}
