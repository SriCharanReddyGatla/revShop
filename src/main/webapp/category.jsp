<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Base64"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="com.revShop.models.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Category Products</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
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

        .products-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .product {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 250px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .product:hover {
            transform: scale(1.05);
        }

        .product img {
            width: 100%;
            height: auto;
            max-height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product h3 {
            color: #333;
            font-size: 18px;
            margin: 15px 0 10px;
        }

        .product p {
            color: #555;
            font-size: 14px;
            margin: 5px 0;
        }

        .product a {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .product a:hover {
            background-color: #45a049;
        }

        .wishlist-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #FFA500;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .wishlist-btn:hover {
            background-color: #FF8C00;
        }
    </style>
    <script>
        function showSuccessAlert() {
            alert("Successfully added to wishlist!");
        }
    </script>
</head>
<body>
    <h1>Products</h1>

    <div class="products-container">
        <c:forEach var="product" items="${products}">
            <div class="product">
                <!-- Display image using Base64 encoded string -->
        <img src="imageServlet?id=${product.id}" alt="${product.name}">
                <h3>${product.name}</h3>
                <p>${product.description}</p>
                <p>Price: ${product.price}</p>
                <p>Discount: ${product.discountPrice}</p>
                
                <a href="product?id=${product.id}">View Product</a>

                <!-- Add to Wishlist Button -->
                <form action="WishlistServlet" method="post" onsubmit="showSuccessAlert()">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="submit" value="Add to Wishlist" class="wishlist-btn">
                </form>
            </div>
        </c:forEach>
    </div>
</body>
</html>
