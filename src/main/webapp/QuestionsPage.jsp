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
	<title>Q&A</title>
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
				<a href="WelcomePage.jsp" class="navbar-brand">Buy Me</a>
			</div>			
			<div class="collapse navbar-collapse" id="bs-nav-demo">
				<ul class="nav navbar-nav">
					<!-- <li class = "active" ><a href="#">Home</a></li> -->
					<li><a href="./WelcomePage.jsp">Create Auction</a></li>
					<li><a href="#">Place Bid</a></li>
					<li class="active"><a href="QuestionsPage.jsp">Q&A</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<%if(session.getAttribute("email").equals("admin")){ %>
						<li><a href="AdminPage.jsp">Administrator</a></li>
					<%}%>
					<li><a href="MyProfilePage.jsp">My Profile Page</a></li>
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
				<div >			
					<h2 align="center">Add Question</h2><br>		
					<form action="PostQuestion.jsp" method="POST" align="center">						
						<input type="text" name="question" placeholder="300 words or less" size="100" maxlength="300" required><br><br>
						<input type="submit" value="Post Question">
					</form>
					<h2 align="center">Questions and Answers</h2><br>					
					<table id="cust_rep" style="width:100%" align="center">
						<tr>
							<th>No.</th>
							<th>Questions</th>
							<th>Answers</th>
						</tr>
						<% try {
							//Get the database connection
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();						
							//Create a SQL statement
							Statement stmt = con.createStatement();
							
							String email = session.getAttribute("email").toString();
							
							String query = "SELECT * FROM USER WHERE EMAIL = ?";
							PreparedStatement ps = con.prepareStatement(query);
							
							ps.setString(1, email);
							ResultSet result = ps.executeQuery();
							result.next();
							query = "SELECT * FROM QUESTIONS WHERE USER_ID = ?" ;
							ps = con.prepareStatement(query);
							ps.setString(1, result.getString("user_id"));
							result = ps.executeQuery();
							
							int count = 1;
							while(result.next()) {
						%>
							<tr>
								<td><%=count %></td>
								<td style="word-break: break-all"><%=result.getString("question") %></td>
								<td style="word-break: break-all"><%=result.getString("answer") %></td>							
								<%-- <td>
								<form action="EditCustomerRepPage.jsp" method="POST">
									<input type="submit" value="Edit">
									<input type="hidden" name="empid" value=<%=result.getString("employee_id") %>>
								</form>
								</td>		 --%>						
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
				</div>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>