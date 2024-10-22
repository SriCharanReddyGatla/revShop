<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revShop.models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.revShop.models.CartItem" %>
<%@ page import="com.revShop.dao.CartDAO" %>
<%@ page import="java.sql.SQLException" %>

<%
User user = (User) request.getSession().getAttribute("user");

if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Fetch the cart items for the user
CartDAO cartDao = new CartDAO();
List<CartItem> cartItems = null;
double totalSum = 0.0; // To store the total price

try {
    cartItems = cartDao.getCartItemsByUserId(user.getId());
    // Calculate the total price
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            totalSum += item.getTotalPrice(); // Add the total price of each item
        }
    }
} catch (SQLException e) {
    e.printStackTrace();
    request.setAttribute("error", "Error retrieving cart items.");
    request.getRequestDispatcher("error.jsp").forward(request, response);
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: fadeIn 0.5s;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .container {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            animation: slideIn 0.5s;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        h1 {
            color: #007BFF;
            margin-bottom: 20px;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            transition: transform 0.3s;
        }

        table:hover {
            transform: scale(1.01);
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
            color: #28a745;
        }

        form {
            margin-top: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus {
            border-color: #007BFF;
            outline: none;
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 1.2em;
            color: white;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Place Your Order</h1>

        <% if (cartItems == null || cartItems.isEmpty()) { %>
            <p>Your cart is empty. Please add items to your cart before placing an order.</p>
        <% } else { %>
            <h2>Your Cart Items</h2>
            <table>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
                <% for (CartItem item : cartItems) { %>
                    <tr>
                        <td><%= item.getProductId() %></td>
                        <td><%= item.getProductName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>$<%= String.format("%.2f", item.getTotalPrice()) %></td>
                    </tr>
                <% } %>
                <tr>
                    <td colspan="3" class="total">Total Sum:</td>
                    <td class="total">$<%= String.format("%.2f", totalSum) %></td>
                </tr>
            </table>
        <% } %>

        <form action="paymentPage.jsp" method="post">
            <label for="shippingAddress">Shipping Address:</label><br>
            <input type="text" id="shippingAddress" name="shippingAddress" required><br>

            <label for="billingInfo">Billing Information:</label><br>
            <input type="text" id="billingInfo" name="billingInfo" required><br>
            <input type="hidden" name="totalPrice" value="<%= totalSum %>">

            <input type="submit" value="Proceed for Payment">
        </form>
    </div>
</body>
</html>
