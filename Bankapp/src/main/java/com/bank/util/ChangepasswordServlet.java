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

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangepasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accNo = (String) session.getAttribute("acc_no");

        if (accNo != null && !accNo.trim().isEmpty()) {
            String oldPassword = request.getParameter("old-password");
            String newPassword = request.getParameter("new-password");
            String confirmNewPassword = request.getParameter("confirm-password");

            if (newPassword.equals(confirmNewPassword)) {
                Connection conn = null;
                PreparedStatement checkPasswordStmt = null;
                PreparedStatement updatePasswordStmt = null;
                ResultSet rs = null;

                try {
                	conn = DatabaseUtil.getConnection();

                    // Check old password
                    String checkPasswordSQL = "SELECT u_password FROM cdetails WHERE acc_no = ?";
                    checkPasswordStmt = conn.prepareStatement(checkPasswordSQL);
                    checkPasswordStmt.setString(1, accNo);
                    rs = checkPasswordStmt.executeQuery();

                    if (rs.next()) {
                        String storedPassword = rs.getString("u_password");

                        if (storedPassword.equals(oldPassword)) {
                            // Update password
                            String updatePasswordSQL = "UPDATE cdetails SET u_password = ? WHERE acc_no = ?";
                            updatePasswordStmt = conn.prepareStatement(updatePasswordSQL);
                            updatePasswordStmt.setString(1, newPassword);
                            updatePasswordStmt.setString(2, accNo);

                            int rowsUpdated = updatePasswordStmt.executeUpdate();
                            if (rowsUpdated > 0) {
                                session.setAttribute("passwordChanged", true);// Set session attribute
                                
                                response.setContentType("text/html");
                                response.getWriter().println("<script type=\"text/javascript\">");
                                response.getWriter().println("alert('Password Updated successfully.');");
                                response.getWriter().println("window.location.href='customer.jsp';"); // Redirect to index.jsp after displaying alert
                                response.getWriter().println("</script>");
                                
                            } else {
                                response.getWriter().println("Failed to update password.");
                            }
                        } else {
                            response.getWriter().println("Old password does not match.");
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
                        if (checkPasswordStmt != null) checkPasswordStmt.close();
                        if (updatePasswordStmt != null) updatePasswordStmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } else {
                response.getWriter().println("New password and confirm password do not match.");
            }
        } else {
            response.getWriter().println("Invalid session or no account number.");
        }
    }
}
