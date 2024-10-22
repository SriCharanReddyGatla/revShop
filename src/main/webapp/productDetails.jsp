<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.revShop.models.Review" %>
<%@ page import="com.revShop.dao.ReviewDAO" %>
<%@ page import="com.revShop.models.Product" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Your existing styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .product-container {
            display: flex;
            justify-content: space-between;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 1200px;
            margin: 20px auto;
        }

        .product-image {
            width: 40%;
        }

        .product-image img {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-details {
            width: 55%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        h1 {
            color: #333;
            font-size: 24px;
        }

        .product-details p {
            color: #555;
            font-size: 16px;
            margin: 10px 0;
        }

        .price {
            color: #d9534f;
            font-size: 20px;
            font-weight: bold;
        }

        .discount-price {
            color: #5cb85c;
            font-size: 18px;
            margin-top: 5px;
        }

        form {
            margin-top: 20px;
        }

        input[type="number"] {
            padding: 10px;
            width: 60px;
            margin-right: 10px;
            font-size: 16px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Reviews Section */
        h3 {
            margin-top: 30px;
            color: #333;
        }

        .reviews-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 1200px;
            margin: 20px auto;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        li {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
            color: #333;
        }

        li:last-child {
            border-bottom: none;
        }

        li span {
            color: #f39c12;
        }
    </style>
</head>
<body>

    <div class="product-container">
        <!-- Product Image -->
        <div class="product-image">
            <!-- Display image using Base64 encoded string -->
            <img src="imageServlet?id=${product.id}" alt="${product.name}">
        </div>

        <!-- Product Details -->
        <div class="product-details">
            <h1>${product.name}</h1>
            <p>${product.description}</p>
            <p class="price">Price: $${product.price}</p>
            <p class="discount-price">Discounted Price: $${product.discountPrice}</p>

            <!-- Add to Cart Form -->
            <form onsubmit="addToCart(event)" action="product">
                <input type="hidden" name="productId" value="${product.id}">
                <input type="number" name="quantity" value="1" min="1">
                <input type="submit" value="Add to Cart">
            </form>
        </div>
    </div>

    <!-- Reviews Section -->
    <div class="reviews-container">
        <h3>Product Reviews</h3>

        <!-- Fetch and Display Reviews -->
        <%
        Product product = (Product) request.getAttribute("product");

        if (product == null) {
            out.println("Product not found!");
            return;
        }

        int productId = product.getId();  // Use product ID from the fetched product
            ReviewDAO reviewDao = new ReviewDAO();
            List<Review> reviews = reviewDao.getReviewsByProductId(productId);
        %>

        <% if (reviews == null || reviews.isEmpty()) { %>
            <p>No reviews yet.</p>
        <% } else { %>
            <ul>
                <% int count = 0; %>
                <% for (Review review : reviews) { %>
                    <% if (count >= 3) break; %> <!-- Show only 3 reviews -->
                    <li>
                        <strong>Rating:</strong> <%= review.getRating() %> Stars<br>
                        <%= review.getReviewText() %>
                    </li>
                    <% count++; %>
                <% } %>
            </ul>
        <% } %>
    </div>

</body>
</html>
