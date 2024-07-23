package com.bank.dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

import com.bank.util.DatabaseUtil;

@WebServlet("/storecustomer")
public class Registercustomer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String fullName = firstName + " " + lastName;
        String address = request.getParameter("address");
        String mobileNo = request.getParameter("phone");
        String email = request.getParameter("email");
        String accountType = request.getParameter("type");
        String initialBalanceStr = request.getParameter("initial");
        String dob = request.getParameter("dob");
        String idProof = request.getParameter("proof");

        double initialBalance = 0.0;
        if (initialBalanceStr != null && !initialBalanceStr.isEmpty()) {
            try {
                initialBalance = Double.parseDouble(initialBalanceStr);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid initial balance value.");
                return;
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Initial balance is required.");
            return;
        }

        String accountNo = "ACC" + UUID.randomUUID().toString().replaceAll("[^A-Z0-9]", "").substring(0, 6).toUpperCase();
        String tempPassword = UUID.randomUUID().toString().substring(0, 6);

        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = DatabaseUtil.getConnection();

            String sql = "INSERT INTO cdetails (user_name, dob, phone_no, email, address, initial_balance, IDproof, acc_type, acc_no, u_password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, fullName);
            statement.setString(2, dob);
            statement.setString(3, mobileNo);
            statement.setString(4, email);
            statement.setString(5, address);
            statement.setDouble(6, initialBalance);
            statement.setString(7, "ID" + idProof);
            statement.setString(8, accountType);
            statement.setString(9, accountNo);
            statement.setString(10, tempPassword);
            statement.executeUpdate();

            sql = "INSERT INTO balance (user_name, balance) VALUES (?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, fullName);
            statement.setDouble(2, initialBalance);
            statement.executeUpdate();

            response.sendRedirect("sumited.jsp?accountNo=" + accountNo + "&tempPassword=" + tempPassword);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database access error", e);
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
