<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revShop.models.Order" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            animation: fadeIn 0.5s ease;
        }
        h1 {
            color: #333;
            text-align: center;
            font-size: 2.2em;
            margin-bottom: 20px;
        }
        h2 {
            color: #007BFF;
            margin-bottom: 10px;
            text-align: center;
            font-size: 1.4em;
        }
        p {
            font-size: 1.1em;
            color: #555;
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 15px;
            text-align: center;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .total {
            font-weight: bold;
            font-size: 1.2em;
            background-color: #f2f2f2;
        }
        form {
            text-align: center;
            margin: 20px 0;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #007BFF;
            font-size: 1.1em;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #0056b3;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Order Confirmation</h1>

        <h2>Order Details</h2>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
                <th>Shipping Address</th>
                <th>Billing Info</th>
                <th>Total Price</th>
                <th>Status</th>
            </tr>
            <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders == null || orders.isEmpty()) {
            %>
                <tr>
                    <td colspan="6">No orders found.</td>
                </tr>
            <%
            } else {
                for (Order order : orders) {
            %>
                    <tr>
                        <td><%= order.getId() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td><%= order.getShippingAddress() %></td>
                        <td><%= order.getBillingInfo() %></td>
                        <td>$<%= String.format("%.2f", order.getTotalPrice()) %></td>
                        <td><%= order.getStatus() %></td>
                    </tr>
            <%
                }
            }
            %>
        </table>
		<a href ="orderSuccess.jsp">Confirm</a>
        <a href="home.jsp">Cancel and Go Back</a>
    </div>
</body>
</html>
