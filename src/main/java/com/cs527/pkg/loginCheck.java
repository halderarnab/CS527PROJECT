package com.cs527.pkg;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;


@WebServlet(name = "loginCheck", urlPatterns = {"/loginCheck"})
public class loginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		
		try {	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			ResultSet rs = null;

			//Get parameters from the HTML form at the index.jsp
			String email = request.getParameter("email");
			String password = request.getParameter("password");

			//Make an insert statement for the Sells table:
			String insert = "SELECT * FROM user WHERE email=? AND password=?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, email);
			ps.setString(2, password);
			rs = ps.executeQuery();
			
			int userId = 0;
			
			if (rs.next()) {
				//HttpSession session = request.getSession();
				session.setAttribute("email", email);
				userId = rs.getInt("user_id");
				session.setAttribute("userId", userId);
				//response.sendRedirect("welcome.jsp");
			} else {
				session.invalidate();
				request.setAttribute("message", "Invalid username or password");
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
				}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Adding new from here
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			ResultSet rs = null;

			//Make an insert statement for the Sells table:
			String getSessionDetails= "SELECT * FROM end_user WHERE user_id=?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(getSessionDetails);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			int userId = (int) session.getAttribute("userId");
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				String phoneNo = rs.getString("phone_no");
				session.setAttribute("phoneNo", phoneNo);

				String address = rs.getString("address");
				session.setAttribute("address", address);

				String cardNo = rs.getString("card_no");
				session.setAttribute("cardNo", cardNo);

				Date cardExpiry = rs.getDate("card_expiry");
				session.setAttribute("cardExpiry", cardExpiry);

				String cvv = rs.getString("cvv");
				session.setAttribute("cvv", cvv);

				String name = rs.getString("name");
				session.setAttribute("name", name);

				String bankAccountNo = rs.getString("bank_account_no");
				session.setAttribute("bankAccountNo", bankAccountNo);
				
				response.sendRedirect("WelcomePage.jsp");
			} else {
				request.setAttribute("message", "Invalid username or password");
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
				}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
