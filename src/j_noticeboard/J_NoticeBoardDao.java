package j_noticeboard;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class J_NoticeBoardDao {
	private static J_NoticeBoardDao instance = new J_NoticeBoardDao();// 싱글톤
	private static SqlSession session; // 생성

	static {
		try {
			Reader reader = Resources.getResourceAsReader("configuration.xml");
			SqlSessionFactory sf = new SqlSessionFactoryBuilder().build(reader);
			session = sf.openSession(true);// 이걸 안하면 커밋이안된다.!!!!!!왜? 트루가 커밋을
											// 하겟다는의미이다.
			reader.close();
		} catch (Exception e) {
			System.out.println("sqlMap에러");

		}
	}

	private J_NoticeBoardDao() {
	}

	public static J_NoticeBoardDao getInstance() {
		return instance;
	}

	// 커넥션 풀 대신해서 마이바티스 사용

	public int selectTotal() {
		int total = 0;
		try {
			total = (Integer) session.selectOne("selectTotal");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return total;
	}

	public List<J_NoticeBoard> selectList(int startRow, int endRow) {
		List<J_NoticeBoard> list = null;
		HashMap<String, Integer> hm = new HashMap<>();
		hm.put("startRow", startRow);
		hm.put("endRow", endRow);
		try {
			list = session.selectList("selectListBoard", hm);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}

	public int insert(J_NoticeBoard noticeboard) {
		int result = 0;
		int number = 0;// brd_no이다~
		try {
			number = (int) session.selectOne("selectNumz");
			noticeboard.setBrd_no(number);
			result = session.insert("insertBoard", noticeboard);
			System.out.println("result넌뭐니 : "+result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public J_NoticeBoard select(int brd_no) {
		J_NoticeBoard nb = null;
		try {
			nb = (J_NoticeBoard) session.selectOne("selectBoard", brd_no);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return nb;
	}

	public void updateHit(int brd_no) {
		try {
			session.update("updateBoardHit", brd_no);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public int update(J_NoticeBoard noticeboard) {
		int result = 0;
		try {
			result = session.update("updateBoarData", noticeboard);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public int delete(int brd_no) {
		int result = 0;
		try {
			result = session.update("deleteBoard", brd_no);
			/*System.out.println("result : " + result);*/
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

}