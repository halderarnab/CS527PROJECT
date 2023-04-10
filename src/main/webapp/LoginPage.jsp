<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	<title>Login Page</title>
</head>
<body>
	<form action="loginCheck" method="post" class="login_box">
		<label>Email:</label>
		<input type="text" name="email" required><br>
		<label>Password:</label>
		<input type="password" name="password" required><br>
		<input type="submit" value="Login">
	</form>
	<div class="login_msg">
	<%
	    if(null!=request.getAttribute("message"))
	    {
	        out.println(request.getAttribute("message"));
	    }
	%>
	</div>
</body>
</html>
