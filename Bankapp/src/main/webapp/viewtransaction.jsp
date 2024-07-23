<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Transaction Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4b0082;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .button {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #4b0082;
            border: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #333;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.16/jspdf.plugin.autotable.min.js"></script>
    <script>
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const table = document.querySelector("table");

            doc.text("Customer Transaction Details", 20, 20);

            const rows = [];
            table.querySelectorAll("tr").forEach((tr, index) => {
                const cols = [];
                tr.querySelectorAll("th, td").forEach(td => cols.push(td.innerText));
                rows.push(cols);
            });

            doc.autoTable({
                head: [rows[0]],
                body: rows.slice(1),
                startY: 30,
            });

            doc.save("transaction_details.pdf");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Customer Transaction Details</h1>
        <table>
            <thead>
                <tr>
                    <th>TRANSACTION ID</th>
                    <th>TRANSACTION DATE</th>
                    <th>TRANSACTION TYPE</th>
                    <th>AMOUNT</th>
                    <th>BALANCE</th>
                    <th>ACCOUNT NO</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    String accNo = (String) session.getAttribute("acc_no");

                    if (accNo == null || accNo.trim().isEmpty()) {
                        out.println("<tr><td colspan='6'>No account number found in session.</td></tr>");
                    } else {
                        try {
                            String DB_URL = "jdbc:mysql://localhost:3306/bank";
                            String DB_USERNAME = "root";
                            String DB_PASSWORD = "root";

                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                            
                            String sql = "SELECT * FROM transactions WHERE acc_no = ? ORDER BY transaction_date DESC, transaction_id DESC LIMIT 10";
                            stmt = conn.prepareStatement(sql);
                            stmt.setString(1, accNo);
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                                String transactionId = rs.getString("transaction_id");
                                String transactionDate = rs.getString("transaction_date");
                                String type = rs.getString("sent_or_received");
                                String amount = rs.getString("amount");
                                String balance = rs.getString("balance");
                                String accountNo = rs.getString("acc_no");

                                out.println("<tr>");
                                out.println("<td>" + transactionId + "</td>");
                                out.println("<td>" + transactionDate + "</td>");
                                out.println("<td>" + type + "</td>");
                                out.println("<td>" + amount + "</td>");
                                out.println("<td>" + balance + "</td>");
                                out.println("<td>" + accountNo + "</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException ex) {
                                ex.printStackTrace();
                            }
                        }
                    }
                %>
            </tbody>
        </table>
        <div class="button-container">
            <button class="button" onclick="downloadPDF()">Download PDF</button>
        </div>
    </div>
</body>
</html>
