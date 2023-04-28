<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<!--   
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	-->
	<link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	<title>Update Info</title>
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
	<h1>Update User Information</h1>
	<div class="response_msg">
	<%
	    if(null!=request.getAttribute("message"))
	    {
	        out.println(request.getAttribute("message"));
	    }
	%>
	</div>
	<hr>
	<div class="update_section">
		<h2>Personal Information</h2>
		<form action="UpdatePersonal" method="post">
			<label>Phone Number:</label>
			<input type="text" name="phone" value="<%=session.getAttribute("phoneNo")%>"><br><br>
			<label>Name:</label>
			<input type="text" name="name" value="<%=session.getAttribute("name")%>"><br><br>
			<label>Address:</label>
			<input type="text" name="address" value="<%=session.getAttribute("address")%>"><br><br>
			<input type="submit" value="update" style="position:relative;left:20%;">
		</form>
		<%
		    if(null!=request.getAttribute("message"))
		    {
		        out.println(request.getAttribute("message"));
		    }
		%>
	</div>
	<hr>
	<div>
		<h2>Bank Details</h2>
		<form action="UpdateBank" method="post">
			<label>Bank Account Number:</label>
			<input type="text" name="bankacc" value="<%=session.getAttribute("bankAccountNo")%>" required><br><br>
			<input type="submit" value="update" style="position:relative;left:20%;">
		</form>		
	</div>
	<hr>
	<div>
		<h2>Card Details</h2>
		<div id="cardSection">
			<form action="UpdateCard" method="post">
			    <label>Credit Card Number:</label>
			    <input type="text" name="cardNo" value="<%=session.getAttribute("cardNo")%>" required><br><br>
			    <label>Expiration Date:</label>
			    <input type="date" name="cardExpiry" value="<%=session.getAttribute("cardExpiry")%>" required><br><br>
			    <label>CVV:</label>
			    <input type="text" name="cvv" value="<%=session.getAttribute("cvv")%>" required><br><br>
    			<input type="submit" value="Update" style="position:relative;left:20%;">
			</form>

  		</div>
	</div>
</body>
</html>
