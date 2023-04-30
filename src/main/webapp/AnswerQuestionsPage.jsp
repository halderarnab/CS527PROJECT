<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs527.pkg.*"%>    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Answer Questions</title>
	<link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
</head>
<style>
	table, th, td {
		border: 1px solid black; 
		padding: 1em 1em 1em 1em;
		text-align: center;
	}
</style>
<body>
	<nav class = "navbar navbar-default">
		<div class="container">
			<div class="navbar-header">	
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-nav-demo" aria-expanded="false">
					 <span class="sr-only">Toggle navigation</span> 
					 <span class="icon-bar"></span> 
					 <span class="icon-bar"></span> 
					 <span class="icon-bar"></span>
				 </button>			 
				<a href="CustomerRepHomePage.jsp" class="navbar-brand">Buy Me</a>
			</div>			
			<div class="collapse navbar-collapse" id="bs-nav-demo">				
				<ul class="nav navbar-nav navbar-right">					
					<li>
						<form id="lgout" action="logout" method="POST">						
							<a href="#" onclick="document.querySelector('#lgout').submit()">Log out <i class = "fa fa-user"></i></a>
						</form>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<div class = "container">
		<div class = "row">
			<div class = "col-lg-12">
				<div>
					<%try {
						//Get the database connection
						ApplicationDB db = new ApplicationDB();	
						Connection con = db.getConnection();						
						//Create a SQL statement
						Statement stmt = con.createStatement();
					
					%>
					<a href="CustomerRepHomePage.jsp">Back</a>
					<h2 align="center">Unanswered Questions</h2><br>
					<table id="cust_rep" style="width:100%" align="center">
						<tr>
							<th>No.</th>
							<th>Email</th>
							<th>Questions</th>
							<th>Answers</th>
						</tr>
						<%	String query = "SELECT * FROM QUESTIONS Q, USER U WHERE Q.USER_ID = U.USER_ID AND ANSWER = 'Not Answered' ORDER BY QID" ;
							PreparedStatement ps = con.prepareStatement(query);
														
							ResultSet result = ps.executeQuery();							
							
							int count = 1;
							while(result.next()) {
						%>
							<tr>
								<td><%=count %></td>
								<td style="word-break: break-all"><%=result.getString("email") %></td>
								<td style="word-break: break-all"><%=result.getString("question") %></td>
								<td style="word-break: break-all">
									<form action="AnswerQuestion.jsp" method="POST">
										<input type="text" name="answer" placeholder="<%=result.getString("answer") %>">
										<input type="hidden" name="qid" value=<%=result.getString("qid") %>><br><br>
										<input type="submit" value="Submit">
									</form>							
								</td>																			
							</tr>
						<%
								count++;
							}							
						%>
					</table>
					<h2 align="center">Answered Questions</h2><br>
					<table id="cust_rep" style="width:100%" align="center">
						<tr>
							<th>No.</th>
							<th>Email</th>
							<th>Questions</th>
							<th>Answers</th>
						</tr>
						<% 	query = "SELECT * FROM QUESTIONS Q, USER U WHERE Q.USER_ID = U.USER_ID AND ANSWER != 'Not Answered' ORDER BY QID" ;
							ps = con.prepareStatement(query);
														
							result = ps.executeQuery();							
							
							count = 1;
							while(result.next()) {
						%>
							<tr>
								<td><%=count %></td>
								<td style="word-break: break-all"><%=result.getString("email") %></td>
								<td style="word-break: break-all"><%=result.getString("question") %></td>
								<td style="word-break: break-all"><%=result.getString("answer") %></td>																					
							</tr>
						<%
								count++;
							}
							con.close();
							db.closeConnection(con);
						} catch(Exception e) {
							e.printStackTrace();
						}
						%>
					</table>
					<br>
					<a href="CustomerRepHomePage.jsp">Back</a>
				</div>
			</div>
		</div>		
	</div>
	
	<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>