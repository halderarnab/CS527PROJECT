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
	<script type="text/javascript">
		function showPopup() {
			document.getElementById('popup').style.display = 'block';
		}
		function hidePopup() {
			document.getElementById('popup').style.display = 'none';
		}
		function validateForm(currPrice, increment) {
		    var bidPrice = parseFloat(document.getElementById("bidPrice").value);
		    var autoBid = parseFloat(document.getElementById("autoBid").value);
		    if (bidPrice <= currPrice) {
		        alert("Bid amount must be greater than current price.");
		        return false;
		    }
		    if (bidPrice < (currPrice+increment)) {
		        alert("Bidding amount increment should be greter than the minimum increment value.");
		        return false;
		    }
		    if (autoBid <= bidPrice) {
		        alert("Auto bid limit should be greater than current bid amount. Even same amount does not make sense.");
		        return false;
		    }
		    return true;
		}

	</script>
	<style type="text/css">
		#popup {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(0,0,0,0.5);
		}
		#popup-container {
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			width: 300px;
			height: 200px;
			background-color: white;
			padding: 20px;
			border-radius: 5px;
			box-shadow: 0 0 5px rgba(0,0,0,0.5);
		}
	</style>
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
			//////////////////////////////////////////////////////////////////
			ResultSet resultCat = null;
			String strCat = "SELECT c.category_name, sc.sub_category_name FROM category c, sub_category sc WHERE c.category_id = sc.category_id and c.category_id = ? and sc.sub_category_id = ?";
			PreparedStatement ps1 = con.prepareStatement(strCat);
			ps1.setInt(1, category_id);
			ps1.setInt(2, sub_category_id);
			resultCat = ps1.executeQuery();
			//////////////////////////////////////////////////////////////////
			ResultSet resultBid = null;
			String strBid = "SELECT user_id, price, timestamp FROM bid WHERE auction_id = ? ORDER BY timestamp;";
			PreparedStatement ps2 = con.prepareStatement(strBid);
			ps2.setInt(1, auctionId);
			resultBid = ps2.executeQuery();
	%>
	
	<div style="height: 400px; width: 98%; border: 1px solid black; text-align: center; margin-left: 1%; display: inline-block;">
		<div style="height: 93%; width: 65%; float: left; display: inline-block; border: 1px solid black; margin-left: 1%; margin-top: 1%;">
			<img src =  "<%= "./images/auction/" + imageName %>" style="height:100%;">
		</div>
		<!--
		<div id="myButton" style=" cursor: pointer; height: 10%; width: 32%; border: 1px solid black; float: right; margin-right: 1%; margin-bottom: 1%; margin-top: 1%; display: inline-block;">
  			<form action="SubmitBid.jsp" method="post">
				<button onclick="showPopup()" type="submit">Bid Now</button>
			</form>
		</div>
		-->

	<button onclick="showPopup()" type="submit">Bid Now</button>
	<div id="popup">
		<div id="popup-container">
			<form action="PostBid" method="post" onsubmit="return validateForm(<%= currPrice %>, autoBid, <%= increment %>)">
				<p style="text-align: left;"><b>Current Price:</b> <%= currPrice %></p>
				<label for="bidPrice">Price:</label>
				<input type="text" id="bidPrice" name="bidPrice"><br><br>
				<label for="autoBid">Enter Auto Bid Upper Limit (If desired):</label>
				<input type="text" id="autoBid" name="autoBid"><br><br>
				<button type="submit">Submit Bid</button>
				<button type="button" onclick="hidePopup()">Close</button>
			</form>
		</div>
	</div>


		<div style="height: 79%; width: 32%; border: 1px solid black; float: right; margin-right: 1%; margin-bottom: 1%; display: inline-block; padding-top: 2%; padding-left: 2%; text-align: left">
				<p><b>Current Price:</b> <%= currPrice %></p>
				<p><b>Start Price:</b> <%= startPrice %></p>
				<p><b>Minimum Increment:</b> <%= increment %></p>
				<p><b>Seller Email:</b> <%= sellerEmail %></p>
				<p><b>Start Time:</b> <%= startTime %></p>
				<p><b>End Time:</b> <%= endTime %></p>
		</div>
	</div>
	
	<hr>
		<div style="height: 93%; width: 65%; float: left; display: inline-block; border: 1px solid black; margin-left: 1%; margin-top: 1%; padding-left: 1%; padding-bottom: 1%">
			<h5 style= "text-align: center">Item Description</h5>
			<hr>
			<p><%= description %> </p>
			<%if (resultCat.next()) { %>
			<p><b>Item category:</b> <%= resultCat.getString("category_name") %> </p>
			<p><b>Item sub-category:</b> <%= resultCat.getString("sub_category_name") %> </p>
			<%} %>
			<p><b>Item Condition:</b> <%= conditionn %> </p>
			<table style="border: 1px solid black;">
  				<thead>
    				<tr style="border: 1px solid black;">
      					<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Condition Category</th>
						<th style="border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Meaning</th>
					</tr>
				</thead>
				<tbody>
					<tr style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">A</td>
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">New (Unused)</td>
					</tr>
					<tr style="border: 1px solid black;">
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">B</td>
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">Used but like brand new with no scratches</td>
					</tr>
					<tr style="border: 1px solid black;">
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">C</td>
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">Used with minor scratches</td>
					</tr>
					<tr style="border: 1px solid black;">
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">D</td>
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">Used with visible scratches</td>
					</tr>
					<tr style="border: 1px solid black;">
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">E</td>
						<td style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">Junk (only good for parts)</td>
					</tr>
				</tbody>
			</table><br>
		</div>
		<div style="height: 93%; width: 32%; border: 1px solid black; float: right; margin-right: 1%; margin-top: 1%; display: inline-block;  padding-left: 1%; padding-right: 1%; text-align: left">
			<h5 style= "text-align: center">Bid History</h5>
			<hr>
			<table style="border: 1px solid black;">
  				<thead>
    				<tr style="border: 1px solid black;">
      					<th style="width: 10%; border: 1px solid black; padding-left: 1%; padding-right: 1%; ">User</th>
						<th style="width: 10%; border: 1px solid black; padding-left: 1%; padding-right: 1%; ">Price(in USD)</th>
						<th style="width: 30%; border: 1px solid black; padding-left: 1%; padding-right: 1%; ">DateTime</th>
					</tr>
				</thead>
				<tbody style="margin-right: 1%; margin-left: 1%;">
					<% while (resultBid.next()) { %>
						<tr style="border: 1px solid black; padding-left: 1%; padding-right: 1%;">
							<td style="width: 10%; border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultBid.getInt("user_id") %> </td>
							<td style="width: 10%; border: 1px solid black; padding-left: 1%; padding-right: 1%;"> <%= resultBid.getInt("price") %> </td>
							<td style="width: 30%; border: 1px solid black; padding-left: 1%; padding-right: 1%;"><%= resultBid.getTimestamp("timestamp") %></td>
						</tr>
					<% } %>
				</tbody>
			</table><br>	
		</div>
	
	<%	} catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		}%>

</body>
</html>