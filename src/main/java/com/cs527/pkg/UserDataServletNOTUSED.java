package com.cs527.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserDataServletNOTUSED extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = null;
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = null;
		try {
			con = db.getConnection();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Fetching user_id from user table
		try {
			ResultSet rs = null;

			//Make an insert statement for the Sells table:
			String fetchUserId = "SELECT user_id FROM user WHERE email=?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(fetchUserId);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, email);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				//HttpSession session = request.getSession();
				//session.setAttribute("email", email);
				userId = rs.getString("user_id");
				//response.sendRedirect("welcome.jsp");
			} else {
				request.setAttribute("message", "User does not exist!");
				RequestDispatcher rd = request.getRequestDispatcher("updateinfo.jsp");
				rd.forward(request, response);
				}
			//con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ResultSet rsCard = null;
		String bankAccountNum = null;
		Date expiryDate = null;
		String cvv = null;
			
		String fetchCardInfo = "SELECT * FROM end_user WHERE user_id=?";
			
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(fetchCardInfo);

			ps.setString(1, userId);

			rsCard = ps.executeQuery();
			
			UserDataNOTUSED userData = new UserDataNOTUSED();

			if (rsCard.next()) {
				System.out.println("Inside if check to getch DB columns");
				//HttpSession session = request.getSession();
				//session.setAttribute("email", email);
				userData.setPassword(rsCard.getString("password"));
				userData.setUserId(rsCard.getInt("user_id"));
				userData.setPhoneNo(rsCard.getString("phone_no"));
				userData.setAddress(rsCard.getString("address"));
				userData.setCardNo(rsCard.getString("card_no"));
				userData.setCardExpiry(rsCard.getDate("card_expiry"));
				userData.setCvv(rsCard.getString("cvv"));
				userData.setName(rsCard.getString("name"));
				userData.setBankAccountNo(rsCard.getString("bank_account_no"));
				
				//bankAccountNum = rsCard.getString("bank_account_no");
				//expiryDate = rsCard.getDate("card_expiry");
				//cvv = rsCard.getString("cvv");
				//System.out.println("bankAccountNum " + bankAccountNum);
				//System.out.println("expiryDate " + expiryDate);
				//System.out.println("cvv " + cvv);
	            request.setAttribute("userData", userData);
	            request.getRequestDispatcher("updateinfo.jsp").forward(request, response);
				//response.sendRedirect("welcome.jsp");
			} else {
				request.setAttribute("message", "User data does not exist!");
				RequestDispatcher rd = request.getRequestDispatcher("updateinfo.jsp");
				rd.forward(request, response);
				}
			} catch (SQLException | ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		
		
    }

}
