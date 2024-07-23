package com.bank.dao;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.util.DatabaseUtil;

@WebServlet("/update")
public class Editdetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("user_name");
        String dob = request.getParameter("dob");
        String phoneNo = request.getParameter("phone_no");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String initialBalance = request.getParameter("initial_balance");
        String IDproof = request.getParameter("IDproof");
        String accType = request.getParameter("acc_type");
        String accNo = request.getParameter("acc_no");

        Connection con = null;
        PreparedStatement ps = null;

        try {
        	con = DatabaseUtil.getConnection();


            String query = "UPDATE cdetails SET user_name = ?, dob = ?, phone_no = ?, email = ?, address = ?, initial_balance = ?, IDproof = ?, acc_type = ? WHERE acc_no = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, userName);
            ps.setDate(2, java.sql.Date.valueOf(dob));
            ps.setString(3, phoneNo);
            ps.setString(4, email);
            ps.setString(5, address);
            ps.setBigDecimal(6, new BigDecimal(initialBalance));
            ps.setString(7, IDproof);
            ps.setString(8, accType);

            ps.setString(9, accNo);

            // Debug prints to verify values
            System.out.println("Executing query with parameters:");
            System.out.println("userName: " + userName);
            System.out.println("dob: " + dob);
            System.out.println("phoneNo: " + phoneNo);
            System.out.println("email: " + email);
            System.out.println("address: " + address);
            System.out.println("initialBalance: " + initialBalance);
            System.out.println("IDproof: " + IDproof);
            System.out.println("accType: " + accType);
            System.out.println("accNo: " + accNo);
     

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.getWriter().println("No customer found with the provided account number.");
            }
        } catch (ClassNotFoundException e) {
            response.getWriter().println("JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            response.getWriter().println("SQL error occurred: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            response.getWriter().println("An unexpected error occurred: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                response.getWriter().println("Error closing resources: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
