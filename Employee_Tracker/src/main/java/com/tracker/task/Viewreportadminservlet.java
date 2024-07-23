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

import org.json.JSONArray;

import com.login.DatabaseUtilTracker;

@WebServlet("/chartData2")
public class Viewreportadminservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String assIdParam = request.getParameter("ass_id");

        if (assIdParam == null || assIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ass_id parameter");
            return;
        }

        int assId;
        try {
            assId = Integer.parseInt(assIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ass_id parameter");
            return;
        }

        try {
            String data = "";
            if ("pie".equals(type)) {
                data = getPieChartData(assId);
            } else if ("weekly".equals(type)) {
                data = getWeeklyChartData(assId);
            } else if ("monthly".equals(type)) {
                data = getMonthlyChartData(assId);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid type parameter");
                return;
            }

            response.setContentType("application/json");
            response.getWriter().write(data);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");
        }
    }

    private String getPieChartData(int assId) throws Exception {
        try (Connection conn = DatabaseUtilTracker.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT task_name, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60 AS total_time " +
                 "FROM taskrecords WHERE ass_id = ? GROUP BY task_name")) {
            ps.setInt(1, assId);
            ResultSet rs = ps.executeQuery();

            JSONArray jsonArray = new JSONArray();
            while (rs.next()) {
                JSONArray row = new JSONArray();
                row.put(rs.getString("task_name"));
                row.put(rs.getDouble("total_time"));
                jsonArray.put(row);
            }

            return jsonArray.toString();
        }
    }

    private String getWeeklyChartData(int assId) throws Exception {
        try (Connection conn = DatabaseUtilTracker.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT WEEK(start_time) AS week, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60 AS total_time " +
                 "FROM taskrecords WHERE ass_id = ? GROUP BY week")) {
            ps.setInt(1, assId);
            ResultSet rs = ps.executeQuery();

            JSONArray jsonArray = new JSONArray();
            while (rs.next()) {
                JSONArray row = new JSONArray();
                row.put("Week " + rs.getInt("week"));
                row.put(rs.getDouble("total_time"));
                jsonArray.put(row);
            }

            return jsonArray.toString();
        }
    }

    private String getMonthlyChartData(int assId) throws Exception {
        try (Connection conn = DatabaseUtilTracker.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT MONTHNAME(start_time) AS month, SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60 AS total_time " +
                 "FROM taskrecords WHERE ass_id = ? GROUP BY month")) {
            ps.setInt(1, assId);
            ResultSet rs = ps.executeQuery();

            JSONArray jsonArray = new JSONArray();
            while (rs.next()) {
                JSONArray row = new JSONArray();
                row.put(rs.getString("month"));
                row.put(rs.getDouble("total_time"));
                jsonArray.put(row);
            }

            return jsonArray.toString();
        }
    }
}
