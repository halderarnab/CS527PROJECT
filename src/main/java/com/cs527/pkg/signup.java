package com.cs527.pkg;

import java.sql.Connection;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "signup", urlPatterns = { "/signup" })
public class signup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public signup() {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response){
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			//Get parameters from the HTML form at the index.jsp
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String password = request.getParameter("password");
			
			String insert = "INSERT INTO USER (EMAIL, PASSWORD) VALUES (?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			
			ps.setString(1, email);
			ps.setString(2, password);
			ps.executeUpdate();
			
			String query = "SELECT * FROM USER WHERE EMAIL = ?";
			ps = con.prepareStatement(query);
			
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				String id = rs.getString("user_id");
				insert = "INSERT INTO END_USER (USER_ID, PHONE_NO, ADDRESS, NAME) VALUES (?, ?, ?, ?)";
				ps = con.prepareStatement(insert);
				ps.setString(1, id);
				ps.setString(2, phone);
				ps.setString(3, address);
				ps.setString(4, name);
				ps.executeUpdate();				
			}
			response.sendRedirect("LoginPage.jsp");
			
			con.close();
			db.closeConnection(con);
			
			log("Insert successful.");
		} catch (Exception e) {
			e.printStackTrace();
			log("Insert failed.");
		}
	}
}