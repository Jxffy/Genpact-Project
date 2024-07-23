package com.bank.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteAccountServlet")
public class Deleteaccount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accNo = (String) session.getAttribute("acc_no");

        if (accNo != null && !accNo.trim().isEmpty()) {
            Connection conn = null;
            PreparedStatement checkBalanceStmt = null;
            PreparedStatement deleteTransactionsStmt = null;
            PreparedStatement deleteAccountStmt = null;
            ResultSet rs = null;

            try {
            	conn = DatabaseUtil.getConnection();

                // Check account balance
                String checkBalanceSQL = "SELECT initial_balance FROM cdetails WHERE acc_no = ?";
                checkBalanceStmt = conn.prepareStatement(checkBalanceSQL);
                checkBalanceStmt.setString(1, accNo);
                rs = checkBalanceStmt.executeQuery();

                if (rs.next()) {
                    double balance = rs.getDouble("initial_balance");

                    if (balance == 0.0) {
                        // Delete related transactions first
                        String deleteTransactionsSQL = "DELETE FROM transactions WHERE acc_no = ?";
                        deleteTransactionsStmt = conn.prepareStatement(deleteTransactionsSQL);
                        deleteTransactionsStmt.setString(1, accNo);
                        deleteTransactionsStmt.executeUpdate();

                        // Then delete the account
                        String deleteAccountSQL = "DELETE FROM cdetails WHERE acc_no = ?";
                        deleteAccountStmt = conn.prepareStatement(deleteAccountSQL);
                        deleteAccountStmt.setString(1, accNo);

                        int rowsDeleted = deleteAccountStmt.executeUpdate();
                        if (rowsDeleted > 0) {
                            // Account deleted successfully
                            session.invalidate(); // Invalidate the session

                            // Send JavaScript alert and redirect
                            String alertScript = "<script>alert('Account deleted successfully. Please log in again.');"
                                    + "window.location.href='index.jsp';</script>";
                            response.getWriter().println(alertScript);
                        } else {
                            // Account deletion failed
                            response.getWriter().println("Account deletion failed.");
                        }
                    } else {
                        response.getWriter().println("Please withdraw all funds before deleting the account.");
                    }
                } else {
                    response.getWriter().println("Account not found.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (checkBalanceStmt != null) checkBalanceStmt.close();
                    if (deleteTransactionsStmt != null) deleteTransactionsStmt.close();
                    if (deleteAccountStmt != null) deleteAccountStmt.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.getWriter().println("Invalid session or no account number.");
        }
    }
}
