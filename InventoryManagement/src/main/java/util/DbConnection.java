package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	
	 private static final String URL = "jdbc:mysql://localhost:3306/InventoryServletWeb";
	    private static final String USER = "root";
	    private static final String PASSWORD = "Nijaadh20#";
	    private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver"; 

	    static {
	        try {
	            Class.forName(DRIVER_CLASS);
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        }
	    }

	    public static Connection getConnection() throws SQLException {
	        return DriverManager.getConnection(URL, USER, PASSWORD);
	        
	    }

	    public static void closeConnection(Connection connection) {
	        if (connection != null) {
	            try {
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

}
