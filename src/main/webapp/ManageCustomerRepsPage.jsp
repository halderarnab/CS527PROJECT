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
	<title>Manage Customer Representatives</title>
	<link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
</head>
<style>
	table, th, td {
		border: 1px solid black; 
		padding: 1% 1% 1% 1%;
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
					<li><a href="QuestionsPage.jsp">Q&A</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<%if(session.getAttribute("email").equals("admin")){ %>
						<li class="active"><a href="AdminPage.jsp">Administrator</a></li>
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
					<h2 align="center">Add Customer Representative</h2><br>		
					<form action="AddCustomerRep.jsp" method="POST" style="border: 1px solid black; padding: 1% 1% 1% 1%" align="center">
						<label>Customer Representative Email</label>
						<input type="text" name="email" placeholder="johndoe@gmail.com" required><br>
						<label>Password</label>
						<input type="text" name="password" placeholder="Password" required><br>
						<label>Phone Number</label>
						<input type="text" name="phone_no" placeholder="1234567890" required><br>
						<input type="submit" value="Add Representative">
					</form>
					<h2 align="center">Customer Representatives</h2><br>					
					<table id="cust_rep" style="width:100%" align="center">
						<tr>
							<th>Employee ID</th>
							<th>Email</th>
							<th>Phone Number</th>
							<th>Password</th>
							<th>Manage</th>
						</tr>
						<% try {
							//Get the database connection
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();						
							//Create a SQL statement
							Statement stmt = con.createStatement();
							String query = "SELECT * FROM USER, CUSTOMER_REPRESENTATIVE WHERE EMPLOYEE_ID = USER_ID" ;
							//Run the query against the database.
							ResultSet result = stmt.executeQuery(query);
							while(result.next()) {
						%>
							<tr>
								<td><%=result.getString("employee_id") %></td>
								<td><%=result.getString("email") %></td>
								<td><%=result.getString("phone_no") %></td>
								<td><%=result.getString("password") %></td>								
								<td>
								<form action="EditCustomerRepPage.jsp" method="POST">
									<input type="submit" value="Edit">
									<input type="hidden" name="empid" value=<%=result.getString("employee_id") %>>
								</form>
								</td>								
							</tr>
						<%
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