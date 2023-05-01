<%@page import="com.cs527.pkg.ApplicationDB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs527.pkg.*"%>    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		int userid = Integer.parseInt(request.getParameter("userid"));
		String newEmail = request.getParameter("email");
		String newName = request.getParameter("name");
		String newPass = request.getParameter("password");
		String newPhNo = request.getParameter("phone_no");
		String newAddress = request.getParameter("address");
		String operation = request.getParameter("operation");

		

		String query = "";
		PreparedStatement ps;
		if(operation.equalsIgnoreCase("update")) {
			query = "UPDATE END_USER SET NAME = ?, PHONE_NO = ?, ADDRESS = ? WHERE USER_ID = ?";
			ps = con.prepareStatement(query);
			ps.setString(1, newName);
			ps.setString(2, newPhNo);
			ps.setString(3, newAddress);
			ps.setInt(4, userid);
			ps.executeUpdate();
			
			query = "UPDATE USER SET PASSWORD = ?, EMAIL = ? WHERE USER_ID = ?";
			ps = con.prepareStatement(query);
			ps.setString(1, newPass);
			ps.setString(2, newEmail);
			ps.setInt(3, userid);
			ps.executeUpdate();
		}
		else{
			query = "DELETE FROM END_USER WHERE USER_ID = ?"; 
			ps = con.prepareStatement(query);
			ps.setInt(1, userid);
			ps.executeUpdate();
			query = "DELETE FROM USER WHERE USER_ID = ?";
			ps = con.prepareStatement(query);
			ps.setInt(1, userid);
			ps.executeUpdate();
		}		
		response.sendRedirect("ManageAccountsPage.jsp");

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		db.closeConnection(con);

		log(operation + " successful.");
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>