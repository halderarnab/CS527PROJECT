<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Auction</title>
	<link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	<script>
		var myButton = document.getElementById("myButton");
			myButton.addEventListener("click", function() {
				window.location.href = "updateInfo.jsp";
			});
	</script>
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
	<%
		String imageName = (String) session.getAttribute("imageName");
		//int auctionId = Integer.parseInt((int) session.getAttribute("auctionId"));
		int auctionId = (int) session.getAttribute("auctionId");

	 	try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			ResultSet resultAuc = null;
			String strAuc = "SELECT * FROM auction where auction_id = ?";
			PreparedStatement ps = con.prepareStatement(strAuc);
			ps.setInt(1, auctionId);
			
			//Run the query against the database.
			resultAuc = ps.executeQuery();
			
			String aucName = null;
			String description = null;
			int startPrice = 0;
			int increment = 0;
			String sellerEmail = null;
			java.sql.Timestamp startTime = null;
			java.sql.Timestamp endTime = null;
			String conditionn = null;
			int category_id = 0;
			int sub_category_id = 0;
			if (resultAuc.next()) {
				aucName = resultAuc.getString("name");
				description = resultAuc.getString("description");
				startPrice = resultAuc.getInt("start_price");
				increment = resultAuc.getInt("increment");
				sellerEmail = resultAuc.getString("seller_email");
				startTime = resultAuc.getTimestamp("start_timestamp");
				endTime = resultAuc.getTimestamp("end_timestamp");
				conditionn = resultAuc.getString("conditionn");
				category_id = resultAuc.getInt("category_id");
				sub_category_id = resultAuc.getInt("sub_category_id");
			}
			//////////////////////////////////////////////////////////////////
			String strPrice = "{? = CALL calc_curr_auc_price(?)}";
			CallableStatement cStmt = con.prepareCall("{? = CALL calc_curr_auc_price(?)}");
			cStmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cStmt.setInt(2, auctionId);
			cStmt.execute();
			int currPrice = cStmt.getInt(1);
	%>
	
	<h3 style="width: 98%; text-align: center; margin-left: 1%; margin-bottom: 1%;"><%= aucName %></h3>
	<p style="margin-left: 1%;"><b>Current Price:</b> <%= currPrice %></p>
	<form action="loginCheck" method="post">
		<label class="login_fields">Email:</label>
		<input type="text" name="email" placeholder="johndoe@gmail.com" required><br>
		<label class="login_fields">Password:</label>
		<input type="password" name="password" placeholder="Password" required><br>
		<input type="submit" value="Login" class="login_fields">
	</form>
	
	
	<%	} catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		}
	%>

</body>
</html>