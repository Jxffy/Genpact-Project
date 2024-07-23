<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #6a11cb, #2575fc);
        color: #fff;
        height: 100vh;
        margin: 0;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    .heading {
        margin-bottom: 20px;
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
        text-align: center;
        width: 80%;
        max-width: 600px;
    }
    h2 {
        color: #fff;
        margin-bottom: 30px;
        text-transform: uppercase;
        font-weight: bold;
        letter-spacing: 2px;
        font-size: 2rem;
    }
    .nav {
        display: flex;
        justify-content: center;
        margin-bottom: 30px;
    }
    .nav-item {
        margin: 0 15px;
    }
    .nav-link {
        font-size: 18px;
        color: #fff;
        text-transform: uppercase;
        font-weight: 500;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    .nav-link:hover {
        color: #ffcc00;
    }
    .btn-logout {
        background-color: #dc3545;
        color: #fff;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        margin-top: 20px;
        border-radius: 5px;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }
    .btn-logout:hover {
        background-color: #c82333;
        box-shadow: 0 8px 16px rgba(220, 53, 69, 0.5);
    }
    .btn-logout:focus {
        outline: none;
    }
</style>
</head>
<body>

    <div class="heading">Admin Dashboard</div>
    <div class="container">
        <nav class="nav">
            <div class="nav-item">
                <a href="task.jsp" class="nav-link">Task Management</a>
            </div>
            <div class="nav-item">
                <a href="viewreportadmin.jsp" class="nav-link">Analysis</a>
            </div>
        </nav>

        <button class="btn-logout" onclick="logout()">Logout</button>
    </div>

    <script>
        function logout() {
            window.location.href = 'login.jsp';
        }
    </script>
</body>
</html>
