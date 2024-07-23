<%@ page import="javax.servlet.http.*, java.sql.*, java.util.*" %>
<%
    if (session == null || session.getAttribute("ass_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reports</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            drawPieChart();
            drawWeeklyChart();
            drawMonthlyChart();
        }

        function drawPieChart() {
            fetch('chartData?type=pie', { credentials: 'include' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    var dataTable = google.visualization.arrayToDataTable([
                        ['Task', 'Total Time'],
                        ...data
                    ]);

                    var options = { title: 'Tasks Breakdown' };
                    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        }

        function drawWeeklyChart() {
            fetch('chartData?type=weekly', { credentials: 'include' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    var dataTable = google.visualization.arrayToDataTable([
                        ['Week', 'Total Time'],
                        ...data
                    ]);

                    var options = { title: 'Weekly Work Analysis' };
                    var chart = new google.visualization.ColumnChart(document.getElementById('weeklychart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        }

        function drawMonthlyChart() {
            fetch('chartData?type=monthly', { credentials: 'include' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    var dataTable = google.visualization.arrayToDataTable([
                        ['Month', 'Total Time'],
                        ...data
                    ]);

                    var options = { title: 'Monthly Work Analysis' };
                    var chart = new google.visualization.ColumnChart(document.getElementById('monthlychart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        }
    </script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: #fff;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1 {
            color: #fff;
            text-transform: uppercase;
            font-weight: bold;
            letter-spacing: 2px;
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
        }
        .chart-container {
            width: 100%;
            max-width: 1200px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .chart-container > div {
            margin: 20px 0;
            width: 100%;
            max-width: 1000px;
            height: 500px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }
    </style>
</head>
<body>
    <h1>Work Analysis Reports</h1>
    <div class="chart-container">
        <div id="piechart"></div>
        <div id="weeklychart"></div>
        <div id="monthlychart"></div>
    </div>
</body>
</html>
