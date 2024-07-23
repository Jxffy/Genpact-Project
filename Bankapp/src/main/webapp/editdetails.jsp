<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-top: 50px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="date"],
        input[type="email"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Customer Details</h2>
        <form action="update" method="post">
            <input type="hidden" name="acc_no" value="${acc_no}">
            
            <label for="user_name">Name:</label>
            <input type="text" id="user_name" name="user_name" value="${user_name}" required>
            
            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" value="${dob}" required>
            
            <label for="phone_no">Phone Number:</label>
            <input type="text" id="phone_no" name="phone_no" value="${phone_no}" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="${email}" required>
            
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="${address}" required>
            
            <label for="initial_balance">Initial Balance:</label>
            <input type="number" id="initial_balance" name="initial_balance" value="${initial_balance}" min="1000" required>
            
            <label for="IDproof">ID Proof:</label>
            <input type="text" id="IDproof" name="IDproof" value="${IDproof}" required>
            
            <label for="acc_type">Account Type:</label>
            <select id="acc_type" name="acc_type">
                <option value="Saving" ${acc_type == 'Saving' ? 'selected' : ''}>Saving</option>
                <option value="Current" ${acc_type == 'Current' ? 'selected' : ''}>Current</option>
            </select>
            
            <input type="submit" value="Update">
        </form>
    </div>
</body>
</html>
