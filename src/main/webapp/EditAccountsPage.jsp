<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<style>
	table, th, td {
		border: 1px solid black; 
		padding: 1% 1% 1% 1%;
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
				<a href="CustomerRepHomePage.jsp" class="navbar-brand">Buy Me</a>
			</div>			
			<div class="collapse navbar-collapse" id="bs-nav-demo">				
				<ul class="nav navbar-nav navbar-right">					
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
					<%try {
							//Get the database connection
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();
							
							int userid = Integer.parseInt(request.getParameter("userid"));
							
							Statement stmt = con.createStatement();
							String query = "SELECT * FROM USER U, END_USER E WHERE U.USER_ID = E.USER_ID and U.USER_ID = ? ORDER BY U.USER_ID";
							PreparedStatement ps = con.prepareStatement(query);			
							ps.setInt(1, userid);	
							
							ResultSet result = ps.executeQuery();
							result.next();
					%>
					<h2 align="center">Edit Account</h2><br>		
					<form action="EditAccount.jsp" method="POST" style="border: 1px solid black; padding: 1% 1% 1% 1%" align="center">
						<input type="hidden" name="userid" value=<%=userid %>>
						<label>Email</label>
						<input type="text" name="email" placeholder="johndoe@gmail.com" required value="<%=result.getString("email") %>"><br>
						<label>Name</label>
						<input type="text" name="name" placeholder="John Doe" required value="<%=result.getString("name") %>"><br>
						<label>Password</label>
						<input type="text" name="password" placeholder="Password" required value="<%=result.getString("password") %>"><br>
						<label>Phone Number</label>
						<input type="text" name="phone_no" placeholder="1234567890" required value="<%=result.getString("phone_no") %>"><br>
						<label>Address</label>
						<input type="text" name="address" placeholder="10 XYZ Street" value="<%=result.getString("address") %>"><br>
						<input type="submit" name="operation" value="Update">
						<input type="submit" name="operation" value="Delete">
					</form>
					<a href="ManageAccountsPage.jsp">Back</a>
					<%
						con.close();
						db.closeConnection(con);
					} catch (Exception e) {
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