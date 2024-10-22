<%@ page import="java.util.List" %>
<%@ page import="com.revShop.models.Product" %>
<%@ page import="com.revShop.dao.ProductDAO" %>
<%@ page import="com.revShop.models.User" %>

<%
    // Retrieve the logged-in user from the session
    User user = (User) request.getSession().getAttribute("user");
    
    if (user == null || !"seller".equals(user.getRole())) {
        // Redirect to login if the user is not a seller or not logged in
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch the seller's ID from the User object
    int userId = user.getId();

    // Get the list of products added by the seller
    ProductDAO productDao = new ProductDAO();
    List<Product> productList = productDao.getProductsBySeller(userId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #28a745;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        input[type="submit"] {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #c82333;
        }
        .button-container {
            text-align: right;
            margin-bottom: 20px;
        }
        .add-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .add-button:hover {
            background-color: #0056b3;
        }
        /* Responsive design */
        @media (max-width: 768px) {
            table, th, td {
                font-size: 14px;
            }
            .add-button {
                padding: 8px 16px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<h1>Products Added by You</h1>

<!-- Add a button to redirect to addProducts.jsp -->
<div class="button-container">
    <a href="addProduct.jsp" class="add-button">Add New Product</a>
</div>

<% if (productList == null || productList.isEmpty()) { %>
    <p>No products found.</p>
<% } else { %>
    <table>
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Discount Price</th>
                <th>Category</th>
                <th>Stock Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Product product : productList) { %>
            <tr>
                <td><%= product.getName() %></td>
                <td><%= product.getDescription() %></td>
                <td><%= product.getPrice() %></td>
                <td><%= product.getDiscountPrice() %></td>
                <td><%= product.getCategory() %></td>
                <td><%= product.getStockQuantity() %></td>
                <td>
                    <!-- Delete button for each product -->
                    <form action="deleteProduct" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
<% } %>

</body>
</html>
