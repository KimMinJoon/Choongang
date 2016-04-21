package j_member;

import java.io.Reader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import j_noticeboard.J_NoticeBoard;
import oracle.net.aso.e;

public class J_MemberDao {
	// 싱글톤 객체 생성을 낭비하지 않기위해
	private static J_MemberDao instance = new J_MemberDao();
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

	private J_MemberDao() {
	}

	public static J_MemberDao getInstance() {
		return instance;
	}

	// 커넥션 풀 대신해서 마이바티스 사용

	public int emailCheck(String m_email) {
		int result = 0;

		try {
			result = (int) session.selectOne("emailChk", m_email);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public int nickCheck(String m_nick, String m_no) {
		int result = 0;
		J_Member mb = new J_Member();
		mb.setM_no(Integer.parseInt(m_no));
		mb.setM_nick(m_nick);
		String orgNick = "";
		String db_nick = "";
		try {
			orgNick = (String) session.selectOne("nickChk", m_no);
			db_nick = (String) session.selectOne("nickChk2", mb);
			if (orgNick != null) {

				if (db_nick.equals(orgNick))
					result = 0;
				else
					result = 1;

			} else {

				if (db_nick != null)
					result = 0;
				else
					result = -1;
			}

		} catch (Exception e) {
			System.out.println("nickCheck : " + e.getMessage());
		}
		return result;
	}

	public int insert(J_Member mb) {
		int result = 0, m_number = 0, m_no = 0;

		try {
			m_no = (int) session.selectOne("selectmno", mb);
			System.out.println("m_nojoin : " + m_no);

			if (m_no > 0) {
				result = session.update("updateData", mb);
			} else {
				m_number = (int) session.selectOne("selectNum");
				mb.setM_no(m_number);
				result = session.insert("insertMember", mb);
			}

		} catch (Exception e)

		{
			System.out.println(e.getMessage());
		}

		return result;

	}

	public int loginChk(String m_email, String m_passwd) {
		int result = 0;

		try {
			String dbpass = (String) session.selectOne("loginChkk", m_email);

			System.out.println("dbpass : " + dbpass);
			if (dbpass.equals(m_passwd)) {
				result = (int) session.selectOne("selectmno2", m_email);
			} else
				result = 0;
		} catch (Exception e)

		{
			System.out.println(e.getMessage());
		}

		return result;
	}

	public J_Member select(String m_no) {
		J_Member mem = null;
		try {
			mem = (J_Member) session.selectOne("selectMember", m_no);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mem;
	}

	public J_Member infoselect(int m_no) {
		J_Member jif = null;
		try {

			jif = (J_Member) session.selectOne("selectInfoz", m_no);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return jif;
	}

	public int update(J_Member mem) {
		int result = 0;
		try {
			result = session.update("updateInfoz", mem);
		} catch (Exception e) {
			System.out.println("정보수정:"+e.getMessage());
		}
		return result;
	}

	public int delete(int m_no) {
		int result = 0;
		try {
			result = session.update("deleteMem", m_no);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public int passwdChk(String m_no, String m_passwd) {
		int result = 0;
		String chk = "";
		HashMap<String, String> hm = new HashMap<>();
		hm.put("m_no", m_no);
		hm.put("m_passwd", m_passwd);
		try {
			chk = (String) session.selectOne("passwdChkk", hm);
			if (chk != null) {
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

}
