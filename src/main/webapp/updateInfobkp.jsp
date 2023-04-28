<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	<title>Update Info</title>
	<script>
		function addCard() {
			var cardDiv = document.createElement("div");
			cardDiv.innerHTML = '<form action="processCreditCard" method="post"><label>Credit Card Number:</label><input type="text" name="cardNumber"><br><br>' +
								'<label>Expiration Date:</label><input type="text" name="expDate"><br><br>' +
								'<label>CVV:</label><input type="text" name="cvv"><br><br><input type="submit" value="Edit">' +
								'<input type="button" value="Delete Card" onclick="deleteCard(this)"><br><br></form>';
			document.getElementById("cardSection").appendChild(cardDiv);
		}

		function deleteCard(button) {
			button.parentNode.parentNode.removeChild(button.parentNode); // Delete the card section
		}
	</script>
</head>
<body>
	<form action="logout" method="post">
		<input type="submit" value="Logout" class ="logout_btn">
	</form>
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
			<label>Phone Number:</label><input type="text" name="phone"><br><br>
			<label>Name:</label><input type="text" name="name"><br><br>
			<label>Address:</label><input type="text" name="address"><br><br>
			<input type="submit" value="update" style="position:relative;left:20%;">
		</form>
		<!-- 
		<div class="response_msg">
		<%
		    if(null!=request.getAttribute("message"))
		    {
		        out.println(request.getAttribute("message"));
		    }
		%>
		</div>
		 -->
	</div>
	<hr>
	<div>
		<h2>Bank Details</h2>
		<form action="UpdateBank" method="post">
			<label>Bank Account Number:</label><input type="text" name="bankacc" required><br><br>
			<input type="submit" value="update" style="position:relative;left:20%;">
		</form>		
	</div>
	<hr>
	<div>
		<h2>Card Details</h2>
		<div id="cardSection">
  			<form action="processCreditCard" method="post">
  		    	<label>Credit Card Number:</label><input type="text" name="cardNumber"><br><br>
  		    	<label>Expiration Date:</label><input type="text" name="expDate"><br><br>
  		    	<label>CVV:</label><input type="text" name="cvv"><br><br>
  		    	<input type="submit" value="Edit">
  		    	<input type="button" value="Delete Card" onclick="deleteCard(this)"><br><br>
  			</form>
  		</div>
  		<input type="button" value="Add Card" onclick="addCard()">
	</div>
</body>
</html>
