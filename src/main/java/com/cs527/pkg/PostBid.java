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
		
		int userId = 0;
		int auctionId = 0;
		int autoBid = 0;
		HttpSession session = request.getSession();
		userId = (int) session.getAttribute("userId");
		auctionId = (int) session.getAttribute("auctionId");
		int bidPrice = Integer.parseInt(request.getParameter("bidPrice")); 
		String autoBidParam = request.getParameter("autoBid");
		int MaxBid = 0;
		
		try {
			if (autoBidParam != null || autoBidParam != "") {
				autoBid = Integer.parseInt(autoBidParam);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
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
			String fetchMaxBidId = "SELECT MAX(bid_id) FROM bid;";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(fetchMaxBidId);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			rs = ps.executeQuery();
			
			if (rs.next()) {
				MaxBid = rs.getInt(1);
			} else {
				request.setAttribute("message", "Error in getting max bid_id!");
				RequestDispatcher rd = request.getRequestDispatcher("AuctionIndividual.jsp");
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
		
		MaxBid += 1; 
		
		//System.out.println("bankAccount '" + bankAccountNo+ "'");
		//System.out.println("bankAccount Length" + bankAccountNo.length());
		
		String updateBankAccount = "INSERT INTO bid(bid_id, price, timestamp, upper_limit, auction_id, user_id) values(?,?,NOW(),?,?,?)";

		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		try {
			PreparedStatement ps;
			ps = con.prepareStatement(updateBankAccount);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, MaxBid);
			ps.setInt(2, bidPrice);
			ps.setInt(3, autoBid);
			ps.setInt(4, auctionId);
			ps.setInt(5, userId);
			ps.executeUpdate();
			//con.commit();
			//System.out.println("updated Bank Account to " + bankAccountNo);
			con.close();
			request.setAttribute("message", "Bid Posted");
			//response.sendRedirect("updateInfo.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("AuctionIndividual.jsp");
			rd.forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
