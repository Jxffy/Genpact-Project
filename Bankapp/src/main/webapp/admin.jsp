<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin page</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Wittgenstein:ital,wght@0,400..900;1,400..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="admin.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="logo">
                <img src="images/phx.png.png" alt="Logo">
            </div>
            <nav>
                <ul>
                    <li><a href="#"><i class="fa-solid fa-house"></i></a></li>
                    <li><a href="#"><i class="fa-solid fa-users-viewfinder"></i></a></li>
                    <li><a href="deletecustomer.jsp"><i class="fa-solid fa-user-xmark"></i></a></li>
                    <li><a href="#"><i class="fa-solid fa-gear"></i></a></li>
                    <li><a href="index.jsp"><i class="fa-solid fa-right-from-bracket"></i></a></li>
                </ul>
            </nav>
        </div>
        <div class="main-content">
            <header>
                <div class="welcome">
                    <h1 style="font-size: 40px;">Admin Access Panel</h1>
                    <p style="font-size: 30px;">Welcome Back, ${username}</p>
                </div>
                <div class="notifications">
                    <span class="notification-count"><i class="fa-regular fa-bell"></i></span>
                </div>
            </header>
            <div class="img">
                <img id="adimg" src="images/image.png" alt="" >
            </div>
            <div class="function">
                <div class="function-details">
                    <p class="function-name"><a href="form.jsp" style="color: #fff;">New Account</a> &nbsp;&nbsp;<i class="fa-solid fa-user-plus"></i></p>
                </div>
            </div>
            <div class="function">
                <div class="function-details">
                    <p class="function-name"><a href="viewcustomer.jsp" style="color: #fff;">View Customer</a> &nbsp;&nbsp;<i class="fa-solid fa-address-card"></i></p>
                </div>
            </div>
            <div class="function">
                <div class="function-details">
                    <p class="function-name" onclick="openModifyAccountPopup()">Modify Account &nbsp;&nbsp; <i class="fa-solid fa-users-gear"></i></p>
                </div>
            </div>
            <div class="popup" id="modifyAccountPopup">
                <div class="popup-content">
                    <span class="close" onclick="closePopup()">&times;</span>
                    <h2>Modify Account</h2>
                    <!-- Example form for modifying accounts -->
                    <form action="FetchCustomerServlet" method="post">
                        <label for="acc-no">Enter The Account No:</label>
                        <input type="text" id="acc-no" name="acc-no" required>
                        <br><br>
                        <!-- Add more fields as needed -->
                        <input type="submit" value="Fetch">
                    </form>
                </div>
            </div>
            <script>
                // JavaScript for popup functionality
                function openModifyAccountPopup() {
                    var popup = document.getElementById('modifyAccountPopup');
                    popup.style.display = 'block';
                }

                function closePopup() {
                    var popup = document.getElementById('modifyAccountPopup');
                    popup.style.display = 'none';
                }

                // Close the popup when clicking outside of it (optional)
                window.onclick = function(event) {
                    var popup = document.getElementById('modifyAccountPopup');
                    if (event.target === popup) {
                        popup.style.display = 'none';
                    }
                }
            </script>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/b5ac938454.js" crossorigin="anonymous"></script>
    <script src="scripts.js"></script>
</body>
</html>
