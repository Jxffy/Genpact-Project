package com.bank;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.bank.util.DatabaseUtil;



@WebServlet("/login")
public class Loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			PrintWriter out = response.getWriter();
			response.setContentType("text/html");
			Connection con = DatabaseUtil.getConnection();
            String name = request.getParameter("admin-id");
            String pwd = request.getParameter("admin-password");
            PreparedStatement ps = con.prepareStatement("select username from people where username=? and password=?");
            ps.setString(1, name);
            ps.setString(2, pwd);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
            	HttpSession session = request.getSession();
            	session.setAttribute("username", rs.getString("username"));
            	RequestDispatcher rd=request.getRequestDispatcher("admin.jsp");
            	rd.forward(request, response);
            }
            else {
            	out.println("Login Failed!!!");
            	out.println("<a href=Admin_login.jsp>Try Again!!!</a>");
            }
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}

}