<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,com.google.gson.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Auction Page</title>

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

	<% String jsonCatList = "";%>



	<% try {
	
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
			
		%>

	<% while (result.next()) { %>

	<p>
		<%= result.getString("sc_name") %></p>
	<%} %>

	<%} catch (Exception e) {
			out.print(e);
		}%>
	<div style="padding-left:5%" >

	<b ><font size="+2"> Create Auction </font></b><br><br>
		
	<form name="form1" id="form1" action="createAuction" method="post"  enctype="multipart/form-data" >

		<label for="name">Product Name:</label><br> 
		<input type="text" name="name" required><br> <br> 
		
		<label for="details">Product Details:</label><br>
		<textarea name="details" rows="4" cols="50"></textarea><br><br> 
		
		<label for="condition">Condition:</label> 
		<select name="condition" id="condition">
			<option value="A">New (Unused)</option>
			<option value="B">Used but like brand new with no scratches</option>
			<option value="C">Used with minor scratches</option>
			<option value="D">Used with visible scratches</option>
			<option value="E">Junk (only good for parts)</option>
		</select> <br> <br> 
		
		<label for="category">Category:</label> 
		 <select name="category" id="category">
			<option value="" selected="selected">Select subject</option>
		</select> <br><br> 
		
		<label for="subcategory">Sub-Category:</label> 
		 <select name="subcategory" id="subcategory">
			<option value="" selected="selected">Please select subject first</option>
		</select> <br><br> 
		
		<label for="endtime">End Time:</label> 
		<input type="datetime-local" id="endtime" name="endtime"><br> <br>


		<label for="increment">Increment:</label> 
		<input type="number" id="increment" name="increment"> <br> <br>
		 
		 <label for="startprice">Start Price:</label> 
		 <input type="number" id="startprice" name="startprice"> <br> <br> 
		 
		 <label for="minprice">Minimum Price (hidden):</label>
		 <input type="number" id="minprice" name="minprice"> <br> <br>
	
		<input type="file" id="imageName" name="imageName">
	
		 <button type="submit"> Create </button>
	</form>
	</div>
</body>
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

	    for (var y in catList[this.value].subCategories) {
	    	console.log(" pring " );
	    	console.log(catList[this.value].subCategories[y]);
	      topicSel.appendChild(new Option(catList[this.value].subCategories[y].name, catList[this.value].subCategories[y].id));
	    }
	  }

	}</script>
</html>