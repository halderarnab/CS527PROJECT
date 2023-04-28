package com.cs527.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UpdateCard", urlPatterns = {"/UpdateCard"})
public class UpdateCard extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response){
		//java.util.logging.Logger logger =  java.util.logging.Logger.getLogger(this.getClass().getName());
		//FileHandler fileHandler = new FileHandler("status.log");
		//logger.addHandler(fileHandler);
		
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
		
		String cardNo = null;
		java.util.Date cardExpiryTemp1 = null;
		String cardExpiryTemp = null;
		String cvv = null;
		
		try {

			//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			cardNo = request.getParameter("cardNo");
			cardExpiryTemp = request.getParameter("cardExpiry");
			cvv = request.getParameter("cvv");
			//cardExpiry = (Date) sdf.parse(cardExpiryTemp);
	        LocalDate localDate = LocalDate.parse(cardExpiryTemp, formatter);
	        cardExpiryTemp1 = Date.from(localDate.atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant());
	        java.sql.Date cardExpiry = new java.sql.Date(cardExpiryTemp1.getTime());
	        //System.out.println("cardNo '" + cardNo+ "'");
			//System.out.println("cardNo Length" + cardNo.length());
			//System.out.println("cardExpiry '" + cardExpiry + "'");
			//System.out.println("cardExpiry Length" + (((CharSequence) cardExpiry).length());
			//System.out.println("cvv '" + cvv+ "'");
			//System.out.println("cvv Length" + cvv.length());
		
				
			String updatePersonalInfo= "UPDATE end_user SET card_no=?, card_expiry=?, cvv=? WHERE user_id=?;";
			//String updatePersonalInfo= "UPDATE end_user SET card_no=?, cvv=? WHERE user_id=?;";

			//Create a Prepared SQL statement allowing you to introduce the parameters of the query

			PreparedStatement ps;
			ps = con.prepareStatement(updatePersonalInfo);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, cardNo);
			ps.setDate(2, cardExpiry);
			ps.setString(3, cvv);
			ps.setString(4, userId);
			ps.executeUpdate();
			//ps.setString(2, cvv);
			//ps.setString(3, userId);
			//ps.executeUpdate();
			//con.commit();
			
			System.out.println("updated card number to " + cardNo + ", card expiry to " + cardExpiry + ", cvv to " + cvv);
			//System.out.println("updated card number to " + cardNo + ", cvv to " + cvv);
			request.getSession().setAttribute("cardNo", cardNo);
			request.getSession().setAttribute("cardExpiry", cardExpiry);
			request.getSession().setAttribute("cvv", cvv);
			con.close();
			request.setAttribute("message", "Card Information Updated");
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
