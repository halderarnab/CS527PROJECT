package com.cs527.pkg;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;


@WebServlet(name = "logout", urlPatterns = {"/logout"})
public class logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public logout(){
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response){
		try {

			
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.invalidate(); // Invalidate the session to logout the user
			}
			response.sendRedirect("LoginPage.jsp");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}	
	
}
