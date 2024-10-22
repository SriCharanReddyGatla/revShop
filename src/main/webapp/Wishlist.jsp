<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revShop.models.Product" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Wishlist</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* Navbar or Home Button */
        .home-button {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: #4CAF50;
            color: white;
            font-size: 18px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .home-button:hover {
            background-color: #45a049;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        h1 {
            text-align: center;
            margin-top: 50px;
            font-size: 28px;
            color: #4CAF50;
        }

        table {
            width: 80%;
            margin: 40px auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            animation: slideIn 0.5s ease-out;
        }

        table th, table td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #4CAF50;
            color: white;
            font-size: 18px;
        }

        table td {
            background-color: #fff;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        table tr:hover td {
            background-color: #f1f1f1;
        }

        button {
            padding: 8px 16px;
            font-size: 16px;
            border: none;
            color: white;
            background-color: #4CAF50;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }

        button:active {
            transform: scale(1);
        }

        button:focus {
            outline: none;
        }

        @keyframes slideIn {
            0% {
                opacity: 0;
                transform: translateX(-100%);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }
    </style>
    <script>
        // Function to handle adding to cart via AJAX
        function addToCart(productId, rowId) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "addToCart", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var response = xhr.responseText;

                    if (response === "Product added to cart successfully!") {
                        // Show success feedback (you can customize this as needed)
                        alert("Product added to cart!");
                    } else {
                        alert("Error adding product to cart.");
                    }
                }
            };

            xhr.send("productId=" + productId + "&quantity=1"); // Sending productId and quantity=1
        }

        // Function to handle removing an item via AJAX
        function removeFromWishlist(productId, rowId) {
            if (confirm("Are you sure you want to remove this item from your wishlist?")) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "RemoveFromWishlist", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            // Remove the corresponding row from the table
                            document.getElementById(rowId).remove();
                        } else {
                            alert("Error: " + response.error);
                        }
                    }
                };
                xhr.send("productId=" + productId);
            }
        }
    </script>
</head>
<body>

    <!-- Home Button -->
    <a href="home.jsp" class="home-button">Back to Products</a>

    <h1>Your Wishlist</h1>

    <table>
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Product> wishlist = (List<Product>) request.getAttribute("wishlistItems");
                if (wishlist == null || wishlist.isEmpty()) {
            %>
                <tr>
                    <td colspan="3">No items in your wishlist.</td>
                </tr>
            <% 
                } else {
                    int rowId = 1; // Row ID to uniquely identify each row in the table
                    for (Product product : wishlist) {
            %>
                <tr id="row<%= rowId %>">
                    <td><%= product.getName() %></td>
                    <td>$<%= product.getPrice() %></td>
                    <td>
                        <!-- AJAX Add to Cart Button -->
                        <button class="btn btn-add-to-cart" onclick="addToCart(<%= product.getId() %>, 'row<%= rowId %>')">Add to Cart</button>
                        
                        <!-- AJAX Remove Button -->
                        <button class="btn btn-remove" onclick="removeFromWishlist(<%= product.getId() %>, 'row<%= rowId %>')">Remove</button>
                    </td>
                </tr>
            <% 
                    rowId++;
                }
            }
            %>
        </tbody>
    </table>

</body>
</html>
