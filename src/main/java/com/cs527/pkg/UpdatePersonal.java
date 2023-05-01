package com.cs527.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.Connection;
//import javax.servlet.http.*;
//import javax.servlet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import javax.servlet.annotation.WebServlet;

@WebServlet(name = "UpdatePersonal", urlPatterns = {"/UpdatePersonal"})
public class UpdatePersonal extends HttpServlet {

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
		
		String phoneNo = null;
		String name = null;
		String address = null;
		phoneNo = request.getParameter("phone");
		name = request.getParameter("name");
		address = request.getParameter("address");
		System.out.println("phoneNo '" + phoneNo+ "'");
		System.out.println("phoneNo Length" + phoneNo.length());
		System.out.println("name '" + name + "'");
		System.out.println("name Length" + name.length());
		System.out.println("address '" + address+ "'");
		System.out.println("address Length" + address.length());
		
		if ((phoneNo!=null && phoneNo.length()==0) || (name!=null && name.length()==0) || (address!=null && address.length()==0)) {
			System.out.println("Some fields blank, fetching DB column values");
			ResultSet rsPersonal = null;
			String phoneNoStored = null;
			String nameStored = null;
			String addressStored = null;
			
			String fetchPersonalInfo = "SELECT phone_no, name, address FROM end_user WHERE user_id=?";
			
			PreparedStatement ps;
			try {
				ps = con.prepareStatement(fetchPersonalInfo);

				ps.setString(1, userId);

				rsPersonal = ps.executeQuery();

				if (rsPersonal.next()) {
					System.out.println("Inside if check to getch DB columns");
					//HttpSession session = request.getSession();
					//session.setAttribute("email", email);
					phoneNoStored = rsPersonal.getString("phone_no");
					nameStored = rsPersonal.getString("name");
					addressStored = rsPersonal.getString("address");
					//System.out.println("phoneNoStored " + phoneNoStored);
					//System.out.println("nameStored " + nameStored);
					//System.out.println("addressStored " + addressStored);
					//response.sendRedirect("welcome.jsp");
				} else {
					request.setAttribute("message", "User Name, Phone Number, or Address does not exist!");
					RequestDispatcher rd = request.getRequestDispatcher("updateinfo.jsp");
					rd.forward(request, response);
					}
			} catch (SQLException | ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if (phoneNo.length()==0) {
				phoneNo = phoneNoStored;
				System.out.println("phone number was blank, updated it to " + phoneNo);
			}
			if (name.length()==0) {
				name = nameStored;
				System.out.println("name was blank, updated it to " + name);
			}
			if (address.length()==0) {
				address = addressStored;
				System.out.println("address was blank, updated it to " + address);
			}
			
		}
		
		String updatePersonalInfo= "UPDATE end_user SET phone_no=?, name=?, address=? WHERE user_id=?;";

		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		try {
			PreparedStatement ps;
			ps = con.prepareStatement(updatePersonalInfo);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, phoneNo);
			ps.setString(2, name);
			ps.setString(3, address);
			ps.setString(4, userId);
			ps.executeUpdate();
			//con.commit();
			System.out.println("updated phone number to " + phoneNo + ", name to " + name + ", address to " + address);
			request.getSession().setAttribute("phoneNo", phoneNo);
			request.getSession().setAttribute("name", name);
			request.getSession().setAttribute("address", address);
			con.close();
			request.setAttribute("message", "Personal Information Updated");
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
