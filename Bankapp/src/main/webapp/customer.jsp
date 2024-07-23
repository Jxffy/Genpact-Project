<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banking Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Wittgenstein:ital,wght@0,400..900;1,400..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Wittgenstein', sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }
        
        .modal-warning {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content-warning {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close-warning {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close-warning:hover,
        .close-warning:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="logo">
                <img src="images/phx.png.png" alt="Logo">
            </div>
            <nav>
                <ul>
                    <li><a href="#" data-name="Dashboard"><i class="fa-solid fa-table-columns"></i></a></li>
                    <li><a href="viewtranscation.jsp" data-name="Transactions"><i class="fa-solid fa-money-bill-transfer"></i></a></li>
                    <li><a href="#" data-name="Money Transfer"><i class="fa-solid fa-piggy-bank"></i></a></li>
                    <li><a href="#" data-name="changePassword"><i class="fa-solid fa-key"></i></a></li>
                    <li><a href="index.jsp" data-name="Logout"><i class="fa-solid fa-right-from-bracket"></i></a></li>
                </ul>
            </nav>
        </div>
        <div class="main-content">
            <header>
                <div class="welcome">
                    <h1 style="font-size: 40px;">Banking Dashboard</h1>
                    <p style="font-size: 30px;">Welcome Back, ${user_name}</p>
                </div>
                <div class="notifications">
                    <span class="notification-count"><i class="fa-regular fa-bell"></i></span>
                </div>
            </header>
            <section class="current-balances">
                <div class="balance-card">
                    <a id="deposit" href="#"> 
                        <div class="card-header">Deposit <i style="color: rgb(255, 255, 255);" class="fa-solid fa-circle-dollar-to-slot"></i></div>
                    </a>
                </div>
                <div class="balance-card">
                    <a href="#" id="withdraw">  
                        <div class="card-header">Withdraw <i style="color: rgb(255, 255, 255);" class="fa-solid fa-hand-holding-dollar"></i></div>
                    </a>
                </div>
                <div class="balance-card">
                    <form action="view">   
                        <div class="card-header">Billing History <i class="fa-solid fa-file-invoice"></i></div>
                    </form>
                </div>
                <div class="balance-card">
                    <a href="#" id="add-card">
                        <div class="card-header">Delete Account <i class="fa-solid fa-trash"></i></div>
                    </a>
                </div>
            </section>
            <div class="current-balance">
                Current Balance: ${initial_balance}
            </div>
            <section class="transactions">
                <div class="trans-money">
                    <h2 style="padding-left: 10px;">My Transactions</h2>
                    <div class="transaction">
                        <div class="transaction-details">
                            <p class="transaction-name">Patreon Membership</p>
                            <p class="transaction-date">20 May 2020</p>
                        </div>
                        <div class="transaction-amount">
                            <p>Subscribe</p>
                            <p>$250.00</p>
                        </div>
                    </div>
                    <div class="transaction">
                        <div class="transaction-details">
                            <p class="transaction-name">UI GEEK INC</p>
                            <p class="transaction-date">10 March 2020</p>
                        </div>
                        <div class="transaction-amount">
                            <p>Received</p>
                            <p>+ $4350.00</p>
                        </div>
                    </div>
                    <div class="transaction">
                        <div class="transaction-details">
                            <p class="transaction-name">Hitam Labou</p>
                            <p class="transaction-date">20 May 2020</p>
                        </div>
                        <div class="transaction-amount">
                            <p>Sent</p>
                            <p>$250.00</p>
                        </div>
                    </div>
                    <form action="view">
                        <button id="view-trans" style="cursor: pointer;">View</button>
                    </form>
                </div>
            </section>
            <section class="send-money">
                <div class="send">
                    <h2>Fund Transfer</h2><br>
                    <img src="images/money.jpg" alt="" width="400px"> <br>
                    <button id="sendmoneybtn">Send Money</button>
                </div>
            </section>
            <section class="carloan">
                <div class="car-loan">
                    <h2 id="carloan-title">Car Loan</h2>
                    <img src="images/carloan.jpeg" alt="" width="280px" id="carimg"><br>
                    <button id="getloan">Get-></button>
                </div>
            </section>

            <!-- Deposit Modal -->
            <div id="myModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>Deposit Money</h2>
                    <form id="deposit-form" action="TransactionServlet" method="post">
                        <input type="text" id="deposit-amount" name="deposit" placeholder="Enter amount">
                        <input type="password" id="deposit-password" name="deposit-password" placeholder="Enter password">
                        <button type="submit" id="submit-deposit">Deposit</button>
                    </form>
                </div>
            </div>

            <!-- Withdraw Modal -->
            <div id="myModal2" class="modal2">
                <div class="modal-content2">
                    <span class="close2">&times;</span>
                    <h2>Withdraw Money</h2>
                    <form id="withdraw-form" action="WithdrawServlet" method="post">
                        <input type="text" id="withdraw-amount" name="withdraw-amount" placeholder="Enter amount">
                        <input type="password" id="withdraw-password" name="withdraw-password" placeholder="Enter password">
                        <button type="submit" id="submit-withdraw">Withdraw</button>
                    </form>
                </div>
            </div>

            <!-- Password Change Modal -->
            <div id="changePasswordModal" class="modal">
                <div class="modal-content">
                    <span id="closeChangePasswordModal" class="close">&times;</span>
                    <h2>Change Password</h2>
                    <form id="change-password-form" action="ChangePasswordServlet" method="post">
                        <label for="old-password">Old Password:</label>
                        <input type="password" id="old-password" name="old-password" required><br>
                        
                        <label for="new-password">New Password:</label>
                        <input type="password" id="new-password" name="new-password" required><br>
                        
                        <label for="confirm-password">Confirm New Password:</label>
                        <input type="password" id="confirm-password" name="confirm-password" required><br>
                        
                        <button type="submit">Change Password</button>
                    </form>
                </div>
            </div>

            <!-- Warning Modal -->
            <div id="warningModal" class="modal-warning">
                <div class="modal-content-warning">
                    <span class="close-warning">&times;</span>
                    <h2>Warning</h2>
                    <p>Your account will be deleted and cannot be retrieved. Are you sure you want to proceed?</p>
                    <form id="delete-form" action="DeleteAccountServlet" method="post">
                        <button type="submit">Confirm</button>
                    </form>
                </div>
            </div>

            <script src="https://kit.fontawesome.com/b5ac938454.js" crossorigin="anonymous"></script>
            <script src="scripts.js"></script>
            <script>
                // Get the modal for deposit
                var modal = document.getElementById("myModal");
                var btn = document.getElementById("deposit");
                var span = document.getElementsByClassName("close")[0];
                
                btn.onclick = function(event) {
                    event.preventDefault(); // Prevent default anchor behavior
                    modal.style.display = "block";
                }
                
                span.onclick = function() {
                    modal.style.display = "none";
                }
                
                window.onclick = function(event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            </script>

            <script>
                // Get the modal for withdraw
                var modal2 = document.getElementById("myModal2");
                var btn2 = document.getElementById("withdraw");
                var span2 = document.getElementsByClassName("close2")[0];
                
                btn2.onclick = function(event) {
                    event.preventDefault(); // Prevent default anchor behavior
                    modal2.style.display = "block";
                }
                
                span2.onclick = function() {
                    modal2.style.display = "none";
                }
                
                window.onclick = function(event) {
                    if (event.target == modal2) {
                        modal2.style.display = "none";
                    }
                }
            </script>

            <script>
                // Get the modal for changing password
                var changePasswordModal = document.getElementById("changePasswordModal");
                var changePasswordLink = document.querySelector('a[data-name="changePassword"]');
                var closeChangePasswordModal = document.getElementById("closeChangePasswordModal");
                
                changePasswordLink.onclick = function(event) {
                    event.preventDefault(); // Prevent default anchor behavior
                    changePasswordModal.style.display = "block";
                }
                
                closeChangePasswordModal.onclick = function() {
                    changePasswordModal.style.display = "none";
                }
                
                window.onclick = function(event) {
                    if (event.target == changePasswordModal) {
                        changePasswordModal.style.display = "none";
                    }
                }
            </script>

            <script>
                // Modal handling for add card
                var modalWarning = document.getElementById("warningModal");
                var btnAddCard = document.getElementById("add-card");
                var spanWarning = document.getElementsByClassName("close-warning")[0];

                btnAddCard.onclick = function(event) {
                    event.preventDefault(); // Prevent default anchor behavior
                    modalWarning.style.display = "block";
                }

                spanWarning.onclick = function() {
                    modalWarning.style.display = "none";
                }

                window.onclick = function(event) {
                    if (event.target == modalWarning) {
                        modalWarning.style.display = "none";
                    }
                }
            </script>

            
        </div>
    </div>
</body>
</html>
