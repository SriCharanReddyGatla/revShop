<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.revShop.models.CartItem" %>
<%@ page import="com.revShop.dao.CartDAO" %>
<%@ page import="com.revShop.models.User" %>
<%@ page import="com.revShop.servlets.DeleteFromCartServlet" %>
<%@ page import="java.util.List" %>
<%@ page import="com.revShop.dao.ProductDAO" %>

<%
User user = (User) request.getSession().getAttribute("user");

if (user == null || !"buyer".equals(user.getRole())) {
    // Redirect to login if the user is not a buyer or not logged in
    response.sendRedirect("login.jsp");
    return;
}

// Fetch the buyer's ID from the User object
int userId = user.getId();
System.out.println("User ID: " + userId);
    // Get the list of products in the cart
    ProductDAO productDao=new ProductDAO();
    CartDAO cartDao = new CartDAO();
    List<CartItem> productList = cartDao.getCartItemsByUserId(userId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
        .delete-btn {
            padding: 5px 10px;
            background-color: #FF6347;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn:hover {
            background-color: #FF4500;
        }
        a {
            display: inline-block;
            margin: 20px auto;
            text-align: center;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background-color: #0056b3;
        }
        p {
            text-align: center;
            font-size: 18px;
            color: #555;
        }
        .container {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Cart</h1>

        <% if (productList == null || productList.isEmpty()) { %>
            <p>No products found in your cart.</p>
        <% } else { %>
            <table>
                <tr>
                    <th>Delete</th>
                    <th>Product ID</th>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
                <% for (CartItem item : productList) { %>
                    <tr>
                        <td>
                            <form action="DeleteFromCart" method="get">
                                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                <button class="delete-btn" type="submit">Delete</button>
                            </form>
                        </td>
                        <td><%= item.getProductId() %></td>
                        <td><%= item.getProductName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>$<%= String.format("%.2f", item.getTotalPrice()) %></td>
                    </tr>
                <% } %>
            </table>
        <% } %>

        <a href="home.jsp">Continue Shopping</a>
        <a href="order.jsp" style="margin-top: 20px; display: inline-block; padding: 10px 20px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px;">Place Order</a>
        
    </div>
</body>
</html>
