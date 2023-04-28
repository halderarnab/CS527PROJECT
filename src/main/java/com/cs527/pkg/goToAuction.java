package com.cs527.pkg;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;


@WebServlet(name = "goToAuction", urlPatterns = {"/goToAuction"})
public class goToAuction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public goToAuction(){
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response){
	

			//Get the database connection
			String auctionId = request.getParameter("auctionid");
			
		
			HttpSession session = request.getSession();
			session.setAttribute("auctionId", auctionId);
			System.out.println(auctionId);
//			response.sendRedirect("AuctionIndividual.jsp");

		
	}
	
}
