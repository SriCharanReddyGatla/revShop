<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revShop.models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"seller".equals(user.getRole())) {
        response.sendRedirect("login.jsp"); // Redirect to login if not a seller
        return; // Stop processing the JSP
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8; /* Light background color */
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333; /* Darker text color for better contrast */
            margin-bottom: 20px;
        }
        .form-container {
            max-width: 600px; /* Limit width of form */
            margin: auto; /* Center the form */
            background: #fff; /* White background for the form */
            padding: 30px; /* Increased padding for spaciousness */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Shadow effect */
        }
        label {
            display: block; /* Labels on new lines */
            margin-bottom: 8px; /* Space between label and input */
            font-weight: bold; /* Bold labels */
            color: #555; /* Slightly lighter text color */
        }
        input[type="text"],
        input[type="number"],
        textarea,
        input[type="file"] {
            width: 100%; /* Full width inputs */
            padding: 12px; /* Increased padding for comfort */
            margin-bottom: 15px; /* Space below inputs */
            border: 1px solid #ddd; /* Lighter border color */
            border-radius: 4px; /* Rounded corners */
            box-sizing: border-box; /* Include padding and border in width */
            transition: border-color 0.3s; /* Smooth transition for focus */
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        input[type="file"]:focus {
            border-color: #28a745; /* Focus border color */
            outline: none; /* Remove default outline */
        }
        input[type="submit"] {
            background-color: #28a745; /* Green background */
            color: white; /* White text */
            padding: 12px; /* Increased padding for comfort */
            border: none; /* No border */
            border-radius: 4px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            font-size: 16px; /* Slightly larger text */
            transition: background-color 0.3s; /* Smooth transition on hover */
            width: 100%; /* Full width button */
            margin-bottom: 10px; /* Space between buttons */
        }
        input[type="submit"]:hover {
            background-color: #218838; /* Darker green on hover */
        }
        .secondary-button {
            background-color: #007bff; /* Blue background for secondary button */
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%; /* Full width button */
            text-align: center;
            text-decoration: none; /* No underline for anchor tag */
            display: inline-block; /* Make anchor behave like a button */
            transition: background-color 0.3s; /* Smooth transition on hover */
        }
        .secondary-button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        /* Responsive design */
        @media (max-width: 600px) {
            .form-container {
                padding: 20px; /* Less padding on smaller screens */
            }
            h1 {
                font-size: 24px; /* Slightly smaller heading */
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Add New Product</h1>
        <form action="addProduct" method="post" enctype="multipart/form-data">
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>

            <label for="image">Product Image:</label>
            <input type="file" id="image" name="image" accept="image/*" required>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" required>

            <label for="discountPrice">Discount Price:</label>
            <input type="number" id="discountPrice" name="discountPrice" step="0.01">
            
            <label for="seller_id">Seller ID:</label>
            <input type="number" id="seller_id" name="seller_id" required>
            
            <label for="category">Category:</label>
            <input type="text" id="category" name="category" required>

            <label for="stockQuantity">Stock Quantity:</label>
            <input type="number" id="stockQuantity" name="stockQuantity" required>

            <input type="submit" value="Add Product">
        </form>
        <!-- New button to go to sellerProducts.jsp -->
        <a href="sellerProducts.jsp" class="secondary-button">Go to My Products</a>
    </div>
</body>
</html>
