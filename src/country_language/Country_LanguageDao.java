package country_language;

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

	public List<Country_Language> selectList1() throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select value from country_language where c_l='c'";
		List<Country_Language> list = new ArrayList<>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
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

	public List<Country_Language> selectList2() throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select value from country_language where c_l='l'";
		List<Country_Language> list = new ArrayList<>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
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
