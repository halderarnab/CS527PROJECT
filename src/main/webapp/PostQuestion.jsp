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
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String question = request.getParameter("question");
		String email = session.getAttribute("email").toString();
		
		String query = "SELECT * FROM USER WHERE EMAIL = ?";
		PreparedStatement ps = con.prepareStatement(query);
		
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()) {
			String id = rs.getString("user_id");
			query = "INSERT INTO QUESTIONS (QUESTION, ANSWER, USER_ID) VALUES (?, ?, ?)";
			ps = con.prepareStatement(query);
			ps.setString(1, question);
			ps.setString(2, "Not Answered");
			ps.setString(3, id);
			ps.executeUpdate();
		}
		
		response.sendRedirect("QuestionsPage.jsp");

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		db.closeConnection(con);

		log("Insert successful.");
		
	} catch (Exception e) {
		e.printStackTrace();
		log("Insert failed.");
	}
	%>
</body>
</html>