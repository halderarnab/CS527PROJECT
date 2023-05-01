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
	<title>Sales Report</title>
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
					<li><a href="CreateAuctionPage.jsp">Create Auction</a></li>
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
				<div>		
				<% try {
							//Get the database connection
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();						
							//Create a SQL statement
							
							String query = "SELECT SUM(PRICE) FROM AUCTION A, BID B WHERE A.AUCTION_ID = B.AUCTION_ID";
							PreparedStatement ps = con.prepareStatement(query);
							ResultSet rs = ps.executeQuery();
							String total_earnings = "0";
							if(rs.next())
								total_earnings = rs.getString("sum(price)");												
				%>
					<h2 align="center">Sales Report</h2>
					<h3>Total Earnings: <%= total_earnings%></h3>
					<h3>Earning per Item: </h3>
					<h3>Earning per Item Type: </h3>
					<h3>Spending per User: </h3>
					<table style="width:100%" align="center">
						<tr>
							<th>No.</th>
							<th>Name</th>
							<th>Total Spent</th>
						</tr>
						<%	query = "SELECT E.NAME, SUM(PRICE) FROM AUCTION A, BID B, END_USER E WHERE A.AUCTION_ID = B.AUCTION_ID AND B.USER_ID = E.USER_ID GROUP BY E.USER_ID;";
							ps = con.prepareStatement(query);
							rs = ps.executeQuery();
							int count = 1;
							while(rs.next()){	
								%>
						<tr>
							<td><%=count %></td>
							<td><%=rs.getString("E.NAME") %></td>
							<td><%=rs.getString("SUM(PRICE)") %></td>							
							</tr>
							<%
								count++;
							} %>
					</table>
					<h3>Best Selling Item: </h3>
					<h3>Best Buyer: </h3>
					
				<%} catch(Exception e) {
						e.printStackTrace();
					}
				%>	
				</div>
			</div>
		</div>		
	</div>
	<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>