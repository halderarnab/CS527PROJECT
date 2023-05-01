package com.cs527.pkg;

import java.awt.image.BufferedImage;
import java.io.*;
import java.text.*;
import java.time.LocalDateTime;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

import javax.servlet.annotation.WebServlet;

@WebServlet(name = "addInterest", urlPatterns = {"/addInterest"})
public class addInterest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public addInterest(){
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response){
		try {
			System.out.println("reached addInterst");

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			ResultSet rs = null;

			//Get parameters from the HTML form at the index.jsp
			String name = request.getParameter("interestname");

	        String createInterest = "INSERT INTO interest (user_id, interest_name) values (?,?);";
	        
			PreparedStatement pstmt = con.prepareStatement(createInterest);
			HttpSession session = request.getSession();

			pstmt.setInt(1, Integer.parseInt(session.getAttribute("user_id").toString()));
			pstmt.setString(2, name );
			
//			System.out.println("user id: " + );
			
			pstmt.execute();
			
			con.close();

			response.sendRedirect("InterestPage.jsp");
		} 
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		catch (ServletException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} 
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
