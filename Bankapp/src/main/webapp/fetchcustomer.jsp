<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fetch Customer</title>
</head>
<body>
    <h2>Enter Account Number to Fetch Customer Details</h2>
    <form action="FetchCustomerServlet" method="post">
        <label for="acc_no">Account Number:</label>
        <input type="text" id="acc_no" name="acc_no" required>
        <input type="submit" value="Fetch">
    </form>
</body>
</html>
