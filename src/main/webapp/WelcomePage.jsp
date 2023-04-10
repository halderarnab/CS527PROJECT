<html>
<head>
	<link href="./css/cs527project1.css" rel="stylesheet" type = "text/css">
	<title>Home Page</title>
</head>
<body>
	<form action="logout" method="post">
		<input type="submit" value="Logout" class ="logout_btn">
	</form>
	<h1>Welcome, <%=session.getAttribute("email")%>!</h1>
</body>
</html>
