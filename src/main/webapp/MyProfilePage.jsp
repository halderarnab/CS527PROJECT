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
					<li><a href="QuestionsPage.jsp">Q&A</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<!-- <li><a href="#">Sign Up <i class = "fa fa-user-plus"></i></a></li> -->
					<%if(session.getAttribute("email").equals("admin")){ %>
						<li><a href="AdminPage.jsp">Administrator</a></li>
					<%}%>
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
						<hr>
						<button class = "btn btn-default btn-lg size" type="button" value="load" onclick="window.location='InterestPage.jsp'" >My Interests</button>
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
			ResultSet resultUserAlert = null;

			ResultSet resultInterests = null;
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
			////////////////////////////////////////////////////////////////
			
				String interestQuery = "SELECT interest_id, interest_name FROM interest WHERE user_id = ? and alert_created = 0;";
	 			PreparedStatement ps6 = con.prepareStatement(interestQuery);
	 			ps6.setInt(1, userId);
	 	  		resultInterests = ps6.executeQuery();
	 			/* out.println("interestQuery:"+ps6.toString()); */

	 	  		while(resultInterests.next())
	 	  		{
					String 	interestName = resultInterests.getString("interest_name");
					int interestId =  resultInterests.getInt("interest_id");
					
					String existInterest = "SELECT name FROM auction WHERE name LIKE ?;";
		 			PreparedStatement ps7 = con.prepareStatement(existInterest);
		 			ps7.setString(1, "%" + interestName + "%");
		 			/* out.println("existInterest:"+ps7.toString()); */
		 			ResultSet resultExistInterest = ps7.executeQuery();
		 			if(resultExistInterest.next())
		 			{
		 				String alertMsg = "An item you might be interested in '" + interestName +"' is up for auction";
		 				String insertAlert = "Insert into user_alert (user_id,alert_message) VALUES(?,?);";
			 			PreparedStatement ps8 = con.prepareStatement(insertAlert);
			 			ps8.setInt(1, userId);
			 			ps8.setString(2, alertMsg);
			 			ps8.execute();
			 			
			 			/* out.println("alertMsg:"+ps8.toString()); */

			 			
			 			String updateInterst = "UPDATE interest SET alert_created = 1 where interest_id = ?";
			 			PreparedStatement ps9 = con.prepareStatement(updateInterst);
			 			ps9.setInt(1, interestId);
			 			ps9.execute();
			 			/* out.println("updateInterst:"+ps9.toString()); */
			 			
			 			
		 				break;
		 			}
	 	  		}
				
	 			String strUserAlert = "SELECT alert_message, alert_time FROM user_alert WHERE user_id = ? AND ALERT_TIME >= (NOW() - INTERVAL 1 MONTH) ORDER BY ALERT_TIME DESC;";
	 			PreparedStatement ps5 = con.prepareStatement(strUserAlert);
	 			ps5.setInt(1, userId);
	 	  		resultUserAlert = ps5.executeQuery();
	%>
	<div>
		<hr>
		<form method="post" action="MyProfilePage.jsp" style="padding-left: 1%; ">
			<label class="login_fields">User email:</label>
  			<input type="text" name="user_email" />
  			<input type="submit" value="View Records" />
		</form>
		<div style="height: 93%; width: 48%; border: 1px solid black; float: left; margin-left: 1%; margin-right: 1%; margin-top: 1%; display: inline-block;  padding-left: 1%; padding-right: 1%; text-align: left">
			<h5 style= "text-align: center">User side Auction History</h5>
			<hr>
			<table style="border: 1px solid black; margin-right: 1%; margin-left: 1%; align: center; width: 98%;">
  				<thead>
    				<tr style="border: 1px solid black;">
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">User email</th>
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Auction Name</th>
					</tr>
				</thead>
				<tbody style="margin-right: 1%; margin-left: 1%; align: center; width: 98%;">
					<% while (resultBidHistory.next()) { %>
						<tr style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">
							<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultBidHistory.getString("email") %> </td>
							<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultBidHistory.getString("name") %> </td>
						</tr>
					<% } %>
				</tbody>
			</table><br>	
		</div>
		<div style="height: 93%; width: 48%; border: 1px solid black; float: left; margin-left: 1%; margin-right: 1%; margin-top: 1%; display: inline-block;  padding-left: 1%; padding-right: 1%; text-align: left">
			<h5 style= "text-align: center">Seller side Auction History</h5>
			<hr>
			<table style="border: 1px solid black; margin-right: 1%; margin-left: 1%; align: center; width: 98%;">
  				<thead>
    				<tr style="border: 1px solid black;">
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Seller email</th>
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Auction Name</th>
					</tr>
				</thead>
				<tbody style="margin-right: 1%; margin-left: 1%; align: center; width: 98%;">
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
		<div style="height: 93%; width: 98%; border: 1px solid black; align: center; margin-left: 1%; margin-right: 1%; margin-top: 1%; display: inline-block;  padding-left: 1%; padding-right: 1%; text-align: left">
		<h5 style= "text-align: center">Last 30 days Alerts</h5>
		<hr>
		<table style="border: 1px solid black; align: center; width: 98%; margin-right: 1%; margin-left: 1%;">
  			<thead>
    			<tr style="border: 1px solid black;">
    				<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; width: 50%;">Alert Message</th>
     				<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; width: 50%;">Date and Time</th>
				</tr>
			</thead>
			<tbody style="margin-right: 1%; margin-left: 1%; align: center; width: 98%; align: center;">
				<% while (resultUserAlert.next()) { %>
					<tr style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%; width: 50%;"> <%= resultUserAlert.getString("alert_message") %> </td>
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%; width: 50%;"> <%= resultUserAlert.getTimestamp("alert_time") %> </td>
					</tr>
				<% } %>
			</tbody>
		</table><br>	
	</div>
	<%	} catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		}%>
	<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>