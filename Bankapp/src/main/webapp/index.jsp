<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="login.css">
</head>
<body>
    <div class="container">
        <div class="login-wrapper">
            <div class="login-header">
                <h1>Welcome back!</h1>
                <p>Manage Your Finances with Ease</p>
            </div>
            <% 
                String message = request.getParameter("message");
                if ("deletionSuccessful".equals(message)) {
            %>
                <div class="alert alert-success">
                    Account deleted successfully. Please log in again.
                </div>
            <% 
                }
            %>
            <div class="login-buttons">
                <button id="admin" class="login-button">Admin</button>
                <button id="candidate" class="login-button">Customer</button>
            </div>
            <div class="login-form" id="admin-form">
                <form action="login">
                    <label for="admin-id">Admin ID:</label>
                    <input type="text" name="admin-id" id="admin-id" required>
                    <label for="admin-password">Password:</label>
                    <input type="password" name="admin-password" id="admin-password" required>
                    <a href="#" class="forgot-password">Forgot Password?</a>
                    <input type="submit" value="Login" class="submit-button">
                </form>
            </div>
            <div class="login-form" id="candidate-form">
                <form action="clogin">
                    <label for="account-number">Account Number:</label>
                    <input type="text" name="account-number" id="account-number" required>
                    <label for="candidate-password">Password:</label>
                    <input type="password" name="candidate-password" id="candidate-password" required>
                    <a href="#" class="forgot-password">Forgot Password?</a>
                    <input type="submit" value="Login" class="submit-button">
                </form>
            </div>
        </div>
        <div class="illustration">
            <img src="images/loginbg.jpg" alt="Illustration" style="width: 100vw">
        </div>
    </div>

    <script src="https://kit.fontawesome.com/b5ac938454.js" crossorigin="anonymous"></script>
    <script src="index.js"></script>
    <script>
        document.getElementById("admin").onclick = function() {
            document.getElementById("admin-form").style.display = "block";
            document.getElementById("candidate-form").style.display = "none";
        }

        document.getElementById("candidate").onclick = function() {
            document.getElementById("admin-form").style.display = "none";
            document.getElementById("candidate-form").style.display = "block";
        }
    </script>
</body>
</html>
