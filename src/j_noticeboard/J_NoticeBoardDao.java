package j_noticeboard;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import j_onelineboard.J_OneLineBoardDAO;

public class J_NoticeBoardDao {
	private static J_NoticeBoardDao instance = new J_NoticeBoardDao();// 싱글톤
																		// 생성

	private J_NoticeBoardDao() {
	}

	public static J_NoticeBoardDao getInstance() {
		return instance;
	}

	public Connection getConnection(){//커넥션 풀 
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}// getConnection
}