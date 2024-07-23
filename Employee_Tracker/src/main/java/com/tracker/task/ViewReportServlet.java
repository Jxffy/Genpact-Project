package com.tracker.task;

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
import org.json.JSONArray;
import com.login.DatabaseUtilTracker;

@WebServlet("/chartData")
public class ViewReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("ass_id") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String type = request.getParameter("type");
        int ass_id = (int) session.getAttribute("ass_id");

        try {
            String data = "";
            if ("pie".equals(type)) {
                data = getPieChartData(ass_id);
            } else if ("weekly".equals(type)) {
                data = getWeeklyChartData(ass_id);
            } else if ("monthly".equals(type)) {
                data = getMonthlyChartData(ass_id);
            }

            response.setContentType("application/json");
            response.getWriter().write(data);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String getPieChartData(int ass_id) throws Exception {
        String query = "SELECT task_name, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60 AS total " +
                       "FROM taskrecords WHERE ass_id = ? GROUP BY task_name";
        try (Connection conn = DatabaseUtilTracker.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, ass_id);
            try (ResultSet rs = ps.executeQuery()) {
                JSONArray jsonArray = new JSONArray();
                while (rs.next()) {
                    JSONArray row = new JSONArray();
                    row.put(rs.getString("task_name"));
                    row.put(rs.getDouble("total"));
                    jsonArray.put(row);
                }
                return jsonArray.toString();
            }
        }
    }

    private String getWeeklyChartData(int ass_id) throws Exception {
        String query = "SELECT WEEK(start_time) AS week, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60 AS total " +
                       "FROM taskrecords WHERE ass_id = ? GROUP BY week";
        try (Connection conn = DatabaseUtilTracker.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, ass_id);
            try (ResultSet rs = ps.executeQuery()) {
                JSONArray jsonArray = new JSONArray();
                while (rs.next()) {
                    JSONArray row = new JSONArray();
                    row.put("Week " + rs.getInt("week"));
                    row.put(rs.getDouble("total"));
                    jsonArray.put(row);
                }
                return jsonArray.toString();
            }
        }
    }

    private String getMonthlyChartData(int ass_id) throws Exception {
        String query = "SELECT MONTHNAME(start_time) AS month, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60 AS total " +
                       "FROM taskrecords WHERE ass_id = ? GROUP BY month";
        try (Connection conn = DatabaseUtilTracker.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, ass_id);
            try (ResultSet rs = ps.executeQuery()) {
                JSONArray jsonArray = new JSONArray();
                while (rs.next()) {
                    JSONArray row = new JSONArray();
                    row.put(rs.getString("month"));
                    row.put(rs.getDouble("total"));
                    jsonArray.put(row);
                }
                return jsonArray.toString();
            }
        }
    }
}
