package com.tracker.task;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.DatabaseUtilTracker;

import javax.servlet.annotation.WebServlet;

@WebServlet("/AssociateWorkServlet")
public class SelectTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("ass_name") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String ass_name = (String) session.getAttribute("ass_name");
        String task_id = request.getParameter("task_id");
        long start_time = Long.parseLong(request.getParameter("start_time"));
        long end_time = Long.parseLong(request.getParameter("end_time"));

        // Calculate total time in hours
        long timeDifference = end_time - start_time; // in milliseconds
        double totalTime = timeDifference / (1000.0 * 60 * 60); // convert to hours

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
        	 con=DatabaseUtilTracker.getConnection();

            // Fetch ass_id from ass_name
            ps = con.prepareStatement("SELECT ass_id FROM associate WHERE ass_name = ?");
            ps.setString(1, ass_name);
            rs = ps.executeQuery();
            int ass_id = 0;
            if (rs.next()) {
                ass_id = rs.getInt("ass_id");
            }

            ps.close();
            rs.close();

            // Insert task record
            ps = con.prepareStatement("INSERT INTO taskrecords (task_id, ass_id, ass_name, start_time, end_time, total) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setInt(1, Integer.parseInt(task_id));
            ps.setInt(2, ass_id);
            ps.setString(3, ass_name);
            ps.setTimestamp(4, new java.sql.Timestamp(start_time));
            ps.setTimestamp(5, new java.sql.Timestamp(end_time));
            ps.setDouble(6, totalTime);
            ps.executeUpdate();

            // Clear the startTime from the session
            session.removeAttribute("start_time");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (rs != null) rs.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("work.jsp");
    }
}
