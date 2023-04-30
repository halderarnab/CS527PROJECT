<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>My Profile</title>
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
					<li><a href="#">Create Auction</a></li>
					<li><a href="#">Place Bid</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<!-- <li><a href="#">Sign Up <i class = "fa fa-user-plus"></i></a></li> -->
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
				<div id = "context">		
					<form action="updateInfo.jsp" method="POST">		
						<button class = "btn btn-default btn-lg size">Edit Info</button>
					</form>
					<hr>
					<form action="WelcomePage.jsp" method="POST">		
						<button class = "btn btn-default btn-lg size">Order History</button>
					</form>
					<hr>
					<form action="WelcomePage.jsp" method="POST">
						<button class = "btn btn-default btn-lg size">Create New Auction</button>
					</form>
				</div>
			</div>
		</div>		
	</div>
	<%
		int userId = (int) session.getAttribute("userId");
		String userEmail = (String) session.getAttribute("email");
		//int auctionId = Integer.parseInt((int) session.getAttribute("auctionId"));

	 	try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
	 		
			ResultSet resultBidHistory = null;
			ResultSet resultSellHistory = null;
	 		String enteredUserEmail = request.getParameter("user_email");
	 		if (enteredUserEmail != null && !enteredUserEmail.isEmpty()) {
	 			//String strBidHistory = "select distinct b.user_id, a.name from bid b, auction a where user_id = ? and b.auction_id = a.auction_id;";
	 			String strBidHistory = "select distinct u.email, a.name from bid b, auction a, user u where u.email= ? and b.auction_id = a.auction_id and b.user_id = u.user_id;";
	 			PreparedStatement ps1 = con.prepareStatement(strBidHistory);
	 			ps1.setString(1, enteredUserEmail);
	 	  		resultBidHistory = ps1.executeQuery();
	 	  		////////////////////////////////////////////////////////////////
	 			String strSellHistory = "select seller_email, name from auction where seller_email = ?;";
	 			PreparedStatement ps2 = con.prepareStatement(strSellHistory);
	 			ps2.setString(1, enteredUserEmail);
	 			resultSellHistory = ps2.executeQuery();
			} else{
				//Create a SQL statement
				//String strBidHistory = "select distinct b.user_id, a.name from bid b, auction a where user_id = ? and b.auction_id = a.auction_id;";
				String strBidHistory = "select distinct u.email, a.name from bid b, auction a, user u where b.user_id = ? and b.auction_id = a.auction_id and b.user_id = u.user_id;";
				PreparedStatement ps3 = con.prepareStatement(strBidHistory);
				ps3.setInt(1, userId);
				resultBidHistory = ps3.executeQuery();
				////////////////////////////////////////////////////////////////
				String strSellHistory = "select seller_email, name from auction where seller_email = ?;";
				PreparedStatement ps4 = con.prepareStatement(strSellHistory);
				ps4.setString(1, userEmail);
				resultSellHistory = ps4.executeQuery();
			}
	%>
	<div>
		<hr>
		<form method="post" action="MyProfilePage.jsp" style="padding-left: 1%; ">
			<label class="login_fields">User email:</label>
  			<input type="text" name="user_email" />
  			<input type="submit" value="View Records" />
		</form>
		<div style="height: 93%; width: 45%; border: 1px solid black; float: left; margin-left: 1%; margin-right: 1%; margin-top: 1%; display: inline-block;  padding-left: 1%; padding-right: 1%; text-align: left">
			<h5 style= "text-align: center">User side Auction History</h5>
			<hr>
			<table style="border: 1px solid black;">
  				<thead>
    				<tr style="border: 1px solid black;">
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">User email</th>
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Auction Name</th>
					</tr>
				</thead>
				<tbody style="margin-right: 1%; margin-left: 1%;">
					<% while (resultBidHistory.next()) { %>
						<tr style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">
							<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultBidHistory.getString("email") %> </td>
							<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultBidHistory.getString("name") %> </td>
						</tr>
					<% } %>
				</tbody>
			</table><br>	
		</div>
		<div style="height: 93%; width: 45%; border: 1px solid black; float: left; margin-left: 1%; margin-right: 1%; margin-top: 1%; display: inline-block;  padding-left: 1%; padding-right: 1%; text-align: left">
			<h5 style= "text-align: center">Seller side Auction History</h5>
			<hr>
			<table style="border: 1px solid black;">
  				<thead>
    				<tr style="border: 1px solid black;">
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Seller email</th>
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Auction Name</th>
					</tr>
				</thead>
				<tbody style="margin-right: 1%; margin-left: 1%;">
					<% while (resultSellHistory.next()) { %>
						<tr style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">
							<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultSellHistory.getString("seller_email") %> </td>
							<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultSellHistory.getString("name") %> </td>
						</tr>
					<% } %>
				</tbody>
			</table><br>	
		</div>
	</div>
	<%	} catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		}%>
	<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>