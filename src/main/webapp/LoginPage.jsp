<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	<title>Login Page</title>
	<link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">	
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
				<a href="#" class="navbar-brand">Buy Me</a>
			</div>			
			<div class="collapse navbar-collapse" id="bs-nav-demo">
				<!-- <ul class="nav navbar-nav">
					<li class = "active" ><a href="#">Home</a></li>
					<li><a href="#">Create Auction</a></li>
					<li><a href="#">Place Bid</a></li>
				</ul> -->
				<ul class="nav navbar-nav navbar-right">
					<!-- <li><a href="#">Sign Up <i class = "fa fa-user-plus"></i></a></li> -->
					<li><a href="#">Log In <i class = "fa fa-user"></i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class = "container">
		<div class = "row">
			<div class = "col-lg-12">
				<div id = "context">
					<form action="loginCheck" method="post">
						<label class="login_fields">Email:</label>
						<input type="text" name="email" placeholder="johndoe@gmail.com" required><br>
						<label class="login_fields">Password:</label>
						<input type="password" name="password" placeholder="Password" required><br>
						<input type="submit" value="Login" class="login_fields">
					</form>
					<div class="login_msg">
					<%
					    if(null!=request.getAttribute("message"))
					    {
					        out.println(request.getAttribute("message"));
					    }
					%>
					</div>
					<a href="SignUpPage.jsp">Sign Up</a>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
