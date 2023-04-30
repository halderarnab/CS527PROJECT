package com.cs527.pkg;

import java.awt.image.BufferedImage;
import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.*;
import java.time.LocalDateTime;

import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "createAuction", urlPatterns = {"/createAuction"})
@MultipartConfig
public class createAuction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public createAuction(){
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response){
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			ResultSet rs = null;

			//Get parameters from the HTML form at the index.jsp
			String name = request.getParameter("name");
			System.out.println("name:" + name); 

			String details = request.getParameter("details");
			String condition = request.getParameter("condition");
			String category = request.getParameter("category");
			System.out.println("category:" + category); 
			String endTimeStr = request.getParameter("endtime");
			System.out.println("endTimeStr:" + endTimeStr); 

			
			endTimeStr = endTimeStr.replace("T", " ");
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm");
			java.util.Date date = (java.util.Date)formatter.parse(endTimeStr); 
			java.sql.Timestamp sqlDate = new java.sql.Timestamp(date.getTime());
			
			/* out.println("closing dateeeee: " + date.getTime());
			out.println("sql date: " + sqlDate); */

			//Date date = (Date)formatter.parse(closingDateTime);
			
			System.out.println("asddsa:" ); 

			
			String subCategory = request.getParameter("subcategory");
			String increment = request.getParameter("increment");
			String startPrice = request.getParameter("subcategory");
			String minPrice = request.getParameter("minprice");
			System.out.println("minprice: "+minPrice);
			System.out.println("startPrice: "+startPrice);
			System.out.println("increment: "+increment);
		    Part filePart = request.getPart("imageName"); // Retrieves <input type="file" name="file">
		    InputStream fileContent = filePart.getInputStream();
			String imgName = filePart.getSubmittedFileName();

			String imageNameSplit [] = imgName.split("\\.");
			String extension = imageNameSplit[1];
			HttpSession session = request.getSession();
			
			String uniqueName = session.getAttribute("user_id") + "_" +System.currentTimeMillis() + "." + extension;
			System.out.println(uniqueName);

//			String uinqueName = 
			System.out.println("system path:ds " + System.getenv("images_path")); 
			String path =System.getenv("images_path")  +  File.separator + "auction"   +  File.separator + uniqueName;
			System.out.println("path:" + path);  
			
		    BufferedImage bf = ImageIO.read(fileContent);
		    
		    File f = new File( uniqueName);
		    System.out.println(" path:" + path);
	        ImageIO.write(bf, extension, new File( path ));

	        
	        
	        String createAuction = "INSERT INTO AUCTION(name, description, conditionn, category_id, sub_category_id, start_price, secret_min_price, increment,"
	        		+ "image_name, start_timestamp, end_timestamp, seller_id)"
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?);";
			
			PreparedStatement pstmt = con.prepareStatement(createAuction);
			pstmt.setString(1, name);
			pstmt.setString(2, details);
			pstmt.setString(3, condition);
			System.out.println("pstmt : 3 "+ category);
			pstmt.setInt(4, Integer.parseInt(category));
			System.out.println("pstmt : 4 "+ subCategory);
			pstmt.setInt(5, Integer.parseInt(subCategory));
			System.out.println("pstmt : 5 "+ startPrice);
			pstmt.setInt(6, Integer.parseInt(startPrice));
			System.out.println("pstmt : 6 " + minPrice);
			pstmt.setInt(7, Integer.parseInt(minPrice));
			System.out.println("pstmt : 7 "+increment );
			pstmt.setInt(8, Integer.parseInt(increment));
			System.out.println("pstmt : 8");
			pstmt.setString(9, uniqueName);
			pstmt.setTimestamp(10, Timestamp.valueOf(LocalDateTime.now()));
			pstmt.setTimestamp(11, sqlDate);
			pstmt.setInt(12, Integer.parseInt(session.getAttribute("user_id").toString()));
			
//			System.out.println("user id: " + );

//			pstmt.setInt(12, Integer.parseInt(session.getAttribute("user_id")));
			
			System.out.println("Query: " + pstmt.toString());
			//DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm");
			

			//Date date = (Date)formatter.parse(closingDateTime);
			
			pstmt.execute();
			
//			
			
			con.close();

			response.sendRedirect("WelcomePage.jsp");
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
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
