<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revShop.models.Order" %>
<%@ page import="com.revShop.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.revShop.models.User" %>
<%@ page import="com.revShop.dao.OrderDAO" %>
<%@ page import="com.revShop.dao.ProductDAO" %>

<%
    // Assuming 'user' is the buyer stored in the session
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch the orders placed by this user (buyer)
    OrderDAO orderDao = new OrderDAO();
    List<Order> orders = orderDao.getOrdersByBuyerId(user.getId());

    // Fetch products associated with each order
    ProductDAO productDao = new ProductDAO();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
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
        .status {
            font-weight: bold;
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
        .review-section {
            margin-top: 30px;
            border: 1px solid red; /* Added for debugging purposes */
        }
        .review-section textarea {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
        }
        .review-section select {
            padding: 5px;
            margin: 5px 0;
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
        <h1>My Orders</h1>

        <% if (orders == null || orders.isEmpty()) { %>
            <p>No orders have been placed yet.</p>
        <% } else { %>
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Shipping Address</th>
                    <th>Billing Info</th>
                    <th>Total Price</th>
                    <th>Status</th>
                </tr>
                <% for (Order order : orders) { %>
                    <tr>
                        <td><%= order.getId() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td><%= order.getShippingAddress() %></td>
                        <td><%= order.getBillingInfo() %></td>
                        <td>$<%= String.format("%.2f", order.getTotalPrice()) %></td>
                        <td class="status"><%= order.getStatus() %></td>
                    </tr>

                    <!-- Fetch products for this order -->
                    <%
                        List<Product> products = productDao.getProductsByOrderId(order.getId());
                        if (products == null || products.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="6"></td>
                        </tr>
                    <% } else { %>
                        <% for (Product product : products) { %>
                            <tr>
                                <td colspan="6">
                                    <div class="review-section">
                                        <h4>Leave a review for <%= product.getName() %>:</h4>
                                        <form action="submitReview" method="post">
                                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                            <textarea name="reviewText" placeholder="Write your review here"></textarea><br>
                                            <label>Rating:</label>
                                            <select name="rating">
                                                <option value="1">1 Star</option>
                                                <option value="2">2 Stars</option>
                                                <option value="3">3 Stars</option>
                                                <option value="4">4 Stars</option>
                                                <option value="5">5 Stars</option>
                                            </select>
                                            <button type="submit">Submit Review</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    <% } %>
                <% } %>
            </table>
        <% } %>

        <a href="home.jsp">Go Back to Home</a>
    </div>
</body>
</html>
