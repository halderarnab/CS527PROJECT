package com.cs527.pkg;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;


@WebServlet(name = "welcomePageSearch", urlPatterns = {"/welcomePageSearch"})
public class welcomePageSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public welcomePageSearch(){
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			ResultSet rs = null;

			//Get parameters from the HTML form at the index.jsp
			System.out.println("reached welcome page java");

			
			String searchStr = request.getParameter("searchStr");
			searchStr.trim();
			String condition = request.getParameter("condition");
			String category = request.getParameter("category");
			String subCategory = request.getParameter("subcategory");
			String sortBy = request.getParameter("sortby");
			
			
			boolean isSearchStr = !searchStr.isEmpty();
			boolean isCondition = !condition.equals("AA");
			boolean isCategory = !category.isEmpty();
			boolean isSubCategory = !subCategory.isEmpty();
			boolean isSortBy = !sortBy.equals("A");

			System.out.println("isSearchStr : "+isSearchStr);
			System.out.println("isCondition : "+isCondition);
			System.out.println("isCategory : "+isCategory);
			System.out.println("isSubCategory : "+isSubCategory);
			System.out.println("isSortBy : "+isSortBy);
			boolean isFirst = true;
			
			
			boolean isWhereNeeded = isSearchStr || isCondition || isCategory || isSubCategory ;
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WelcomePage.jsp");

			String clauses = "";
			if(isWhereNeeded)
			{
				clauses += "where ";
			}
			
			if(isSearchStr)
			{
				searchStr = "'%" + searchStr +"%'";
				String and = " AND ";
				clauses +=  "(name LIKE " + searchStr + " OR "+ "description LIKE " + searchStr +") ";
				
				isFirst = false;
			}
			
			if(isCondition)
			{
				if(!isFirst)
					clauses += " AND ";
				
				condition = "'"+condition+"'";
				clauses += "(CONDITIONN = " + condition + ")";
				
				isFirst = false;
			}
			
			if(isCategory)
			{
				if(!isFirst)
					clauses += " AND ";
				
				clauses += "(category_id = " + category + ")";
					
				isFirst = false;
			}

			if(isSubCategory)
			{
				if(!isFirst)
					clauses += " AND ";
				
				clauses += "(sub_category_id = " + subCategory + ")";
				
				isFirst = false;
			}
			
			if(isSortBy)
			{
				clauses += " ORDER BY ";

//				<option value="A">Date Posted</option>
//				<option value="B">Price (Ascending)</option>
//				<option value="C">Price (Descending)</option>
//				<option value="D">Name</option>
//				<option value="E">End Time</option>
				switch(sortBy)
				{
				case "B":
					clauses += "start_price ASC";
					break;

				case "C":
					clauses += "start_price DESC";
					break;

				case "D":
					clauses += "name";
					break;

				case "E":
					clauses += "end_timestamp ASC";
					break;

				case "F":
					clauses += "end_timestamp DESC";
					break;
				}

			}
			
				
				
				
				
			request.setAttribute("clauses", clauses);
			
			dispatcher.forward(request, response);

			
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
