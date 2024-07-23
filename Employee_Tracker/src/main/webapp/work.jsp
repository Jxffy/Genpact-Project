<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page session="true" %>
<%
    if (session == null || session.getAttribute("ass_name") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Long start_time = (Long) session.getAttribute("start_time");
    Long currentTime = System.currentTimeMillis();
    Long elapsedTime = start_time != null ? currentTime - start_time : 0L;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Work Tracker</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: #fff;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            margin-top: 30px;
            backdrop-filter: blur(10px);
        }
        h2 {
            margin-top: 0;
            color: #000;
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            text-shadow: none;
        }
        label, #timer {
            display: block;
            margin: 0 auto;
            text-align: center;
            font-size: 16px; /* Adjust font size */
            color: #000;
        }
        select {
            padding: 5px; /* Reduce padding */
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px; /* Reduce font size */
            outline: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        select {
            width: calc(100% - 12px); /* Adjust width */
            max-width: 150px;
        }
        .button-container {
            display: flex;
            justify-content:center;
            
            /* Space between buttons */
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
             /* Buttons will take equal width */
            padding: 8px 12px; /* Adjust padding */

            margin: 10px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px; /* Reduce font size */
            outline: none;
            display: block;
        }
        button:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }
        #timer {
            font-size: 20px; /* Adjust font size */
            margin: 20px 0;
            font-weight: bold;
            color: #000;
            text-shadow: none;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
        }
        tbody tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.2);
        }
        tbody tr:nth-child(odd) {
            background-color: rgba(255, 255, 255, 0.1);
        }
        tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }
    </style>
    <script>
        var timer;
        var start_time = <%= start_time != null ? start_time : "null" %>;
        var elapsedTime = <%= elapsedTime %>;

        function startTimer() {
            if (start_time === null) {
                start_time = new Date().getTime();
                document.getElementById("start_time").value = start_time;
                elapsedTime = 0;
                <% session.setAttribute("start_time", start_time); %>
            }
            timer = setInterval(updateTimer, 1000);
            document.getElementById("startButton").disabled = true;
            document.getElementById("stopButton").disabled = false;
        }

        function updateTimer() {
            var currentTime = new Date().getTime();
            var totalElapsedTime = (currentTime - start_time) + (elapsedTime || 0);
            var seconds = Math.floor((totalElapsedTime / 1000) % 60);
            var minutes = Math.floor((totalElapsedTime / (1000 * 60)) % 60);
            var hours = Math.floor((totalElapsedTime / (1000 * 60 * 60)) % 24);

            document.getElementById("timer").innerHTML = 
                (hours < 10 ? "0" + hours : hours) + ":" +
                (minutes < 10 ? "0" + minutes : minutes) + ":" +
                (seconds < 10 ? "0" + seconds : seconds);
        }

        function stopTimer() {
            clearInterval(timer);
            var end_time = new Date().getTime();
            document.getElementById("end_time").value = end_time;
            document.getElementById("workForm").submit();
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Work Tracker</h2>
        <form id="workForm" action="AssociateWorkServlet" method="post">
            <input type="hidden" id="start_time" name="start_time" value="<%= start_time != null ? start_time : "" %>">
            <input type="hidden" id="end_time" name="end_time" value="">
            <label for="task_id">Select a Task:</label>
            <select name="task_id" id="task_id" required>
                <option value="" disabled selected>Select a Task</option>
                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tracker", "root", "root");
                        ps = con.prepareStatement("SELECT task_id, task_name FROM task");
                        rs = ps.executeQuery();
                        while(rs.next()) {
                %>
                    <option value="<%= rs.getInt("task_id") %>"><%= rs.getString("task_name") %></option>
                <%
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if(rs != null) rs.close();
                            if(ps != null) ps.close();
                            if(con != null) con.close();
                        } catch(Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </select>
            <div class="button-container">
                <button type="button" id="startButton" onclick="startTimer()" <%= start_time != null ? "disabled" : "" %>>Start</button>
                <button type="button" id="stopButton" onclick="stopTimer()" <%= start_time == null ? "disabled" : "" %>>Stop</button>
            </div>
        </form>
        <div id="timer">00:00:00</div>
    </div>
    
    <div class="container">
        <h2>Task Records</h2>
        <table>
            <thead>
                <tr>
                    <th>Task ID</th>
                    <th>Associate Name</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Total Hours</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection con2 = null;
                    PreparedStatement ps2 = null;
                    ResultSet rs2 = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/tracker", "root", "root");
                        ps2 = con2.prepareStatement("SELECT task_id, ass_name, start_time, end_time, total FROM taskrecords WHERE ass_name = ?");
                        ps2.setString(1, (String) session.getAttribute("ass_name"));
                        rs2 = ps2.executeQuery();
                        while(rs2.next()) {
                %>
                <tr>
                    <td><%= rs2.getInt("task_id") %></td>
                    <td><%= rs2.getString("ass_name") %></td>
                    <td><%= rs2.getTimestamp("start_time") %></td>
                    <td><%= rs2.getTimestamp("end_time") %></td>
                    <td><%= rs2.getDouble("total") %></td>
                </tr>
                <%
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if(rs2 != null) rs2.close();
                            if(ps2 != null) ps2.close();
                            if(con2 != null) con2.close();
                        } catch(Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
