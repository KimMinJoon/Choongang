/*
<국가_언어 db 처리하는 Dao.java>

마지막 수정날짜 : 2016-03-24 오전 11:47
마지막 수정한 사람 : 강진우
*/

package country_language;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class Country_LanguageDao {
	private static Country_LanguageDao instance = new Country_LanguageDao();
	private Country_LanguageDao() { }
	public static Country_LanguageDao getInstance() {
		return instance;
	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();// 연결
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");// 커넥션
																					// 풀
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}// getConnection

	public List<Country_Language> selectList(String sort) throws SQLException {
		// join 폼에서 sort(c,l)을 가져와서 찾고 데이터베이스의 value를 list에 추가
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select value from country_language where c_l=?";
		List<Country_Language> list = new ArrayList<>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sort);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Country_Language cl = new Country_Language();
				cl.setValue(rs.getString("value"));
				list.add(cl);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return list;
	}

}
