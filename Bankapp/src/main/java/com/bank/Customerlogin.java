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

@WebServlet("/clogin")
public class Customerlogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            
            Connection con = DatabaseUtil.getConnection();
            
            String accNo = request.getParameter("account-number");
            String password = request.getParameter("candidate-password");

            String query = "SELECT user_name, email, acc_no, initial_balance FROM cdetails WHERE acc_no = ? AND u_password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, accNo);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user_name", rs.getString("user_name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("acc_no", rs.getString("acc_no"));
                session.setAttribute("initial_balance", rs.getDouble("initial_balance"));

                RequestDispatcher rd = request.getRequestDispatcher("customer.jsp");
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
