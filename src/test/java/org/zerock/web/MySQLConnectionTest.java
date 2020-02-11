package org.zerock.web;

import java.sql.*;

import org.junit.*;

public class MySQLConnectionTest {
	// MySQL Driver 5이하 : ".com.mysql.jdbc.Driver"
	// MySQL Driver 6이상
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	
	// MySQL 5.6 이하 : "jdbc:mysql://127.0.0.1:3306/book_ex";
	// MySQL 5.7 이상
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/book_ex?useSSL=false&serverTimezone=UTC";
	
	@Test
	public void testConnection() throws Exception {
		Class.forName(DRIVER);
		try(Connection conn = DriverManager.getConnection(URL, "zerock", "zerock")) {
			System.out.println();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
