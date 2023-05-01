<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
					<form action="WelcomePage.jsp" type="POST">		
						<button class = "btn btn-default btn-lg size">Edit Info</button>
						<hr>
						<button class = "btn btn-default btn-lg size">Order History</button>
						<hr>
						<button class = "btn btn-default btn-lg size">Create New Auction</button>
						<hr>
						<button class = "btn btn-default btn-lg size" type="button" value="load" onclick="window.location='InterestPage.jsp'" >My Interests</button>
					</form>
				</div>
			</div>
		</div>		
	</div>
	<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>