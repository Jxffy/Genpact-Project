<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Management</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #6a11cb, #2575fc);
        color: #fff;
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    h1 {
        color: #fff;
        margin-top: 50px;
        margin-bottom: 30px;
        text-transform: uppercase;
        font-weight: bold;
        letter-spacing: 2px;
        font-size: 2.5rem;
        text-align: center;
    }
    .container {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 10px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        padding: 30px;
        width: 90%;
        max-width: 800px;
    }
    .form-inline {
        margin-bottom: 30px;
    }
    .table {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 10px;
    }
    .btn-primary {
        background-color: #007bff;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
    .btn-delete {
        background-color: #dc3545;
        color: #fff;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }
    .btn-delete:hover {
        background-color: #c82333;
    }
    th, td {
        text-align: center;
        vertical-align: middle;
        font-weight: bold;
        color: #fff;
    }
    thead {
        background-color: #007bff;
        color: #fff;
    }
    tbody tr:nth-child(odd) {
        background-color: rgba(255, 255, 255, 0.1);
    }
    tbody tr:nth-child(even) {
        background-color: rgba(255, 255, 255, 0.2);
    }
</style>
</head>
<body>

    <h1>Task Management</h1>
    <div class="container">
        <form action="TaskServlet" method="post" class="form-inline justify-content-center">
            <input type="text" name="task_name" class="form-control mr-2" placeholder="Enter task name" required>
            <button type="submit" class="btn btn-primary">Add Task</button>
        </form>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Task ID</th>
                    <th>Task Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tracker", "root", "root");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM task");

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("task_id") %></td>
                    <td><%= rs.getString("task_name") %></td>
                    <td>
                        <form action="TaskServlet" method="post" style="display:inline;">
                            <input type="hidden" name="task_id" value="<%= rs.getInt("task_id") %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="btn-delete">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
