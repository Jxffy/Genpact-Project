package com.login;

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

@WebServlet("/elogin")
public class employee_login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            Connection con=DatabaseUtilTracker.getConnection();

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            String query = "SELECT ass_id, ass_name FROM associate WHERE ass_name = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("ass_id", rs.getInt("ass_id")); // Store ass_id
                session.setAttribute("ass_name", rs.getString("ass_name")); // Store ass_name

                RequestDispatcher rd = request.getRequestDispatcher("associate.jsp");
                rd.forward(request, response);
            } else {
                out.println("Login Failed!!!");
                out.println("<a href='Admin_login.jsp'>Try Again!!!</a>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
