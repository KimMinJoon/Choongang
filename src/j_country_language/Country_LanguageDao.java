/*
<국가_언어 db 처리하는 Dao.java>

마지막 수정날짜 : 2016-03-24 오전 11:47
마지막 수정한 사람 : 강진우
*/

package j_country_language;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class Country_LanguageDao {
	private static Country_LanguageDao instance = new Country_LanguageDao();

	private Country_LanguageDao() {
	}

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

	public List<J_Country_Language> selectList(int cl) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<J_Country_Language> list = new ArrayList<>();
		String sql = "select * from country_language ";
		String sql2 = " where c_l=?";
		try {
			conn = getConnection();
			if (cl != 0) {
				sql += sql2;
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cl);
			} else {
				pstmt = conn.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				J_Country_Language c = new J_Country_Language();
				c.setCode(rs.getString(1));
				c.setC_l(rs.getString(2));
				c.setValue(rs.getString(3));
				list.add(c);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
	}

}
