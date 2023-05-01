<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Available Auctions</title>
	<link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	</head>
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
				</ul>
				<ul class="nav navbar-nav navbar-right">
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

		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM auction;" ;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
		
		<center><b ><font size="+3">Available Auctions</font></b></center><br><br><br>
		
		
		
		<% while (result.next()) { %>
			<form action="AuctionIndividual.jsp" method="post">
				<img style="float:left" src =  <%=  "./images/auction/" + result.getString("image_name") %> width ="150" height="150">
		
				<p><b><%= result.getString("name") %></b></p>
				<p> <%= result.getString("description") %> </p>
				<p> <b>Start Time:</b> <%= result.getString("start_timestamp") %></p>
				<p> <b>End Time: </b> <%= result.getString("end_timestamp") %></p>
				<%
					String imageName = result.getString("image_name");
					session.setAttribute("imageName", imageName);
					session.setAttribute("auctionId", result.getInt("auction_id"));
				%>
				<button type="submit"> Go To Auction</button>
				<br>
				<hr style="clear: both;">
			</form>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
			
			<%} catch (Exception e) {
			out.print(e);
		}%>
			

	

	</body>
</html>