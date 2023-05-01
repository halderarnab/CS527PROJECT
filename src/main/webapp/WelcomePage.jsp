<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.sql.*,com.google.gson.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome Page</title>
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
					<li><a href="./CreateAuctionPage.jsp">Create Auction</a></li>
					<li><a href="#">Place Bid</a></li>
					<li><a href="QuestionsPage.jsp">Q&A</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<%if(session.getAttribute("email").equals("admin")){ %>
						<li><a href="AdminPage.jsp">Administrator</a></li>
					<%}%>
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
	
	<% 	String jsonCatList = "";
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT c.category_id c_id, c.category_name c_name, sc.sub_category_id sc_id, sc.sub_category_name sc_name FROM CATEGORY c INNER JOIN SUB_CATEGORY sc  ON c.CATEGORY_ID=sc.CATEGORY_ID;" ;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			/* List<Category> categories = new ArrayList(); */
			HashMap<Integer,Category> categories = new HashMap();
			
			while (result.next()) {
				int c_id = result.getInt("c_id");
				String c_name = result.getString("c_name");
				int sc_id = result.getInt("sc_id");
				String sc_name = result.getString("sc_name");
				
				if(!categories.containsKey(c_id))
				{
					Category cat = new Category(c_id, c_name);
					categories.put(c_id, cat);
				}
				
				Category cat = categories.get(c_id);
				SubCategory sCat = new SubCategory(sc_id, sc_name);
				
				cat.subCategories.add(sCat);
				// create a new Gson instance
				 Gson gson = new Gson();
				 // convert your list to json
				 jsonCatList = gson.toJson(categories);

			}
		}
		catch (Exception e) {
			out.print(e);
		}
			
	%>
		
	
	<div style="padding-left:5%">
		<form  action="welcomePageSearch" method="post" >
		
		<b><font size="+1"> Advanced Search Options</font> </b> <br> <br>
  		<input type="text" name="searchStr" placeholder="Search.."> <br> <br>
  		
  		<label for="category">Category:</label> 
		 <select name="category" id="category">
			<option value="" selected="selected">All</option>
		</select> <br><br> 
		
		<label for="subcategory">Sub-Category:</label> 
		 <select name="subcategory" id="subcategory">
			<option value="" selected="selected">Please select subject first</option>
		</select> <br><br> 
		
		<label for="condition">Condition:</label> 
		<select name="condition" id="condition">
			<option value="AA">All</option>
			<option value="A">New (Unused)</option>
			<option value="B">Used but like brand new with no scratches</option>
			<option value="C">Used with minor scratches</option>
			<option value="D">Used with visible scratches</option>
			<option value="E">Junk (only good for parts)</option>
		</select> <br> <br> 
		
		
		<label for="sortby">Sort By:</label> 
		<select name="sortby" id="sortby">
			<option value="A">Date Posted</option>
			<option value="B">Price (Ascending)</option>
			<option value="C">Price (Descending)</option>
			<option value="D">Name</option>
			<option value="E">End Time (Ascending) </option>
			<option value="F">End Time (Descending) </option>
		</select> <br> <br> 
		
		<button type ="submit">Search</button>
		</form>
		
		<form>
		
			<input type="text" name="Set Alert" placeholder="Search.."> <br> <br>
			<button type ="submit">Create Alert</button>
			
		</form>
	</div>
	
		<% try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement			

			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String query = "SELECT * FROM auction " ;

			//Run the query against the database.
			Object clauseObj = request.getAttribute("clauses");

			if(clauseObj != null && !clauseObj.toString().isEmpty())
			{
				out.println("clauseObj not null");
				query += clauseObj.toString();
				
			}
			query += ";";			
			out.println("query : " + query);

			ResultSet result = stmt.executeQuery(query);
			

		%>
		
		
<!-- 		<div   style="display:block;margin-left:auto; margin-right:auto;width:20%">
 -->		
	<div style="padding-left:5%">
			<b ><font size="+3">Available Auctions</font></b><br><br><br>
	
		<% while (result.next()) { %>
				<img style="float:left" src =  <%=  "./images/auction/" + result.getString("image_name") %> width ="150" height="185">
		
				<p><b><%= result.getString("name") %></b></p>
				<p> <%= result.getString("description") %> </p>
				<p> <b>Start Time:</b> <%= result.getString("start_timestamp") %></p>
				<p> <b>End Time: </b> <%= result.getString("end_timestamp") %></p>
				<form action="goToAuction" method="post">
					<button  type="submit"> Go To Auction</button>
					<input type="hidden" name="auctionid" value=<%= result.getInt("auction_id") %> />
				</form>
				<br>
				<hr style="clear: both;">
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
			
			<%} catch (Exception e) {
			out.print(e);
		}%>
			
		</div>

<script>

var catListJs = JSON.stringify(<%= jsonCatList %>); 
console.log( typeof catListJs );
var catList = JSON.parse(catListJs);
 
 for(var x in catList)
	 {
	 console.log(catList[x]);
	 }

window.onload = function() {
	  var subjectSel = document.getElementById("category");
	  var topicSel = document.getElementById("subcategory");
	  
	  for (var x in catList) {
		  
	    subjectSel.appendChild(new Option(catList[x].name, catList[x].id));
	  }
	  subjectSel.onchange = function() {    //empty Chapters- and Topics- dropdowns
	       
	    //subjectSel.length = 1;   
	    topicSel.length = 1;
	    //display correct values
	    console.log(" print "+this.value);
	    topicSel.appendChild(new Option("All", ""));
	    for (var y in catList[this.value].subCategories) {
	    	console.log(" pring " );
	    	console.log(catList[this.value].subCategories[y]);
	      topicSel.appendChild(new Option(catList[this.value].subCategories[y].name, catList[this.value].subCategories[y].id));
	    }
	  }

	}</script>
		<script src="https://code.jquery.com/jquery-2.1.4.	js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	</body>
</html>