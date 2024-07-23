package com.bank.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/WithdrawServlet")
public class Withdrawservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String amountStr = request.getParameter("withdraw-amount");
        String password = request.getParameter("withdraw-password");
        String userName = (String) session.getAttribute("user_name");

        if (amountStr == null || amountStr.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.getWriter().println("Amount and password cannot be empty.");
            return;
        }

        double amount;
        try {
            amount = Double.parseDouble(amountStr.trim());
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid amount format.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement transactionStmt = null;
        ResultSet rs = null;

        try {
        	conn = DatabaseUtil.getConnection();

            // Validate password and fetch current balance and email
            String validateUserQuery = "SELECT initial_balance, email, acc_no FROM cdetails WHERE user_name = ? AND u_password = ?";
            stmt = conn.prepareStatement(validateUserQuery);
            stmt.setString(1, userName);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("initial_balance");
                String accNo = rs.getString("acc_no");

                // Update the customer's balance
                double newBalance = currentBalance - amount;
                String updateBalanceQuery = "UPDATE cdetails SET initial_balance = ? WHERE user_name = ?";
                stmt = conn.prepareStatement(updateBalanceQuery);
                stmt.setDouble(1, newBalance);
                stmt.setString(2, userName);
                stmt.executeUpdate();

                // Insert the transaction record
                String insertTransactionQuery = "INSERT INTO transactions (transaction_date, sent_or_received, amount, balance, acc_no) VALUES (CURDATE(), ?, ?, ?, ?)";
                transactionStmt = conn.prepareStatement(insertTransactionQuery);
             
                transactionStmt.setString(1, "Sent");
                transactionStmt.setDouble(2, amount);
                transactionStmt.setDouble(3, newBalance);
                transactionStmt.setString(4, accNo);
                transactionStmt.executeUpdate();

                response.sendRedirect("successtransaction.jsp"); // Redirect to dashboard after successful deposit
            } else {
                response.getWriter().println("Invalid password.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Exception occurred: " + e.getMessage());

        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}