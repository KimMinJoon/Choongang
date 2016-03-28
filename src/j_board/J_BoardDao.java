package j_board;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class J_BoardDao {
	private static J_BoardDao instance = new J_BoardDao();//싱글톤 생성
	private J_BoardDao() {}
	public static J_BoardDao getInstance(){
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
	}
	
}
