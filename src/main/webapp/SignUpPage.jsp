<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.cs527.pkg.*"%>    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Edit Accounts</title>
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
				<a href="LoginPage.jsp" class="navbar-brand">Buy Me</a>
			</div>			
			<div class="collapse navbar-collapse" id="bs-nav-demo">				
				<ul class="nav navbar-nav navbar-right">					
					<li><a href="LoginPage.jsp">Log In <i class = "fa fa-user"></i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class = "container">
		<div class = "row">
			<div class = "col-lg-12">
				<div id="context">
					<form action="signup" method="post" class="signup_box">
						<label>Name:</label> 
						<input type="text" name="name" placeholder="John Doe" required><br>
						<label>Email:</label> 
						<input type="text" name="email" placeholder="johndoe@gmail.com" required><br>
						<label>Phone no.:</label> 
						<input type="text" name="phone" placeholder="1234567890"required><br>
						<label>Address:</label> 
						<input type="text" name="address" placeholder="10 XYZ Street"required><br>
						<label>Password:</label> 
						<input type="password" name="password" placeholder="Password" required><br> 
						<label>Re-enter Password:</label> 
						<input type="password" name="repassowrd" placeholder="Re-enter Password" required><br> 
						<input type="submit" value="Submit">
					</form>					
				</div>
			</div>
		</div>
	</div>
</body>
</html>