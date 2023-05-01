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
		String bidid = request.getParameter("bidid");

		String query = "DELETE FROM BID WHERE BID_ID = ?"; 
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, bidid);		
		ps.executeUpdate();
		
		response.sendRedirect("ManageBidsPage.jsp");

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		db.closeConnection(con);

		log("Delete successful.");
		
	} catch (Exception e) {
		e.printStackTrace();
		log("Delete failed.");
	}
%>
</body>
</html>