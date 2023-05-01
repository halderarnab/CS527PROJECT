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

		String answer = request.getParameter("answer");
		String qid = request.getParameter("qid");


		//Make an insert statement for the user table:
		String query = "UPDATE QUESTIONS SET ANSWER = ? WHERE QID = ?";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(query);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, answer);
		ps.setString(2, qid);
		//Run the query against the DB
		ps.executeUpdate();
		
		response.sendRedirect("AnswerQuestionsPage.jsp");

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