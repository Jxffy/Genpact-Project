package com.tracker.task;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login.DatabaseUtilTracker;

/**
 * Servlet implementation class Taskservlet
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/TaskServlet")
public class Taskservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskName = request.getParameter("task_name");
        String action = request.getParameter("action");
        int taskId = request.getParameter("task_id") != null ? Integer.parseInt(request.getParameter("task_id")) : -1;

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
        	 conn=DatabaseUtilTracker.getConnection();

            if (action != null && action.equals("delete")) {
                pstmt = conn.prepareStatement("DELETE FROM task WHERE task_id = ?");
                pstmt.setInt(1, taskId);
            } else {
                pstmt = conn.prepareStatement("INSERT INTO task (task_name) VALUES (?)");
                pstmt.setString(1, taskName);
            }
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        response.sendRedirect("task.jsp");
    }
}
