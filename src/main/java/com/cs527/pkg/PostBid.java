package com.cs527.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PostBid", urlPatterns = {"/PostBid"})
public class PostBid extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response){
		//java.util.logging.Logger logger =  java.util.logging.Logger.getLogger(this.getClass().getName());
		//FileHandler fileHandler = new FileHandler("status.log");
		//logger.addHandler(fileHandler);
		
		String userId = null;
		String auctionId = null;
		HttpSession session = request.getSession();
		userId = (String) session.getAttribute("userId");
		auctionId = (String) session.getAttribute("auctionId");

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
			String bidPrice = request.getParameter("bidPrice");
			String autoBid = request.getParameter("autoBid");
			
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
		
		String bankAccountNo = null;
		
		bankAccountNo = request.getParameter("bankacc");
		
		//System.out.println("bankAccount '" + bankAccountNo+ "'");
		//System.out.println("bankAccount Length" + bankAccountNo.length());
		
		try {
			if (bankAccountNo.length()!=12) {
				request.setAttribute("message", "Bank Account needs to be 12 characters long!");
				RequestDispatcher rd = request.getRequestDispatcher("updateinfo.jsp");
				rd.forward(request, response);
			}
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String updateBankAccount = "UPDATE end_user SET bank_account_no=? WHERE user_id=?;";

		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		try {
			PreparedStatement ps;
			ps = con.prepareStatement(updateBankAccount);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, bankAccountNo);
			ps.setString(2, userId);
			ps.executeUpdate();
			//con.commit();
			//System.out.println("updated Bank Account to " + bankAccountNo);
			request.getSession().setAttribute("bankAccountNo", bankAccountNo);
			con.close();
			request.setAttribute("message", "Bank Account Updated");
			//response.sendRedirect("updateInfo.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("updateInfo.jsp");
			rd.forward(request, response);
			//rs = ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
