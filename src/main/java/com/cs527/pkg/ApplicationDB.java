package com.cs527.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {
	
	public ApplicationDB(){
		
	}

	public Connection getConnection() throws ClassNotFoundException{
		
		//Create a connection string
		//String connectionUrl = "jdbc:mysql://localhost:3306/BarBeerDrinkerSample";
		//Connection connection = null;
		Connection con = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			//Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			//con = DriverManager.getConnection("jdbc:postgresql:://localhost:3306/cs527project1db?user=root&password=kautjosh&ssl=true");
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme", "root", "MySQLServer812#");
			
			//Class.forName("com.mysql.jdbc.Driver").getDeclaredConstructor().newInstance();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", "root");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		return con;
		
	}
	
	public void closeConnection(Connection con){
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws ClassNotFoundException {
		ApplicationDB dao = new ApplicationDB();
		Connection con = dao.getConnection();
		
		System.out.println(con);		
		dao.closeConnection(con);
	}
	
	

}
