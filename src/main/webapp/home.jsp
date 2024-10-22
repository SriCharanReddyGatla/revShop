<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>RevShop - Home</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #333;
            margin-top: 20px;
            text-align: center;
        }

        form {
            margin-top: 20px;
            text-align: center;
        }

        input[type="text"] {
            width: 300px;
            padding: 10px;
            margin-right: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            padding: 10px 20px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Styling for categories */
        ul {
            list-style: none;
            padding: 0;
            margin: 20px 0;
            display: flex;
            justify-content: center;
            gap: 30px;
            background-color: #333;
            padding: 15px 0;
            border-radius: 10px;
        }

        ul li {
            display: inline;
        }

        ul li a {
            text-decoration: none;
            font-size: 18px;
            color: white;
            padding: 10px 20px;
            transition: background-color 0.3s ease, color 0.3s ease;
            border-radius: 5px;
        }

        ul li a:hover {
            background-color: #4CAF50;
            color: white;
        }

        /* Slideshow styling */
        .slideshow-container {
            position: relative;
            max-width: 100%;
            margin: 0 auto;
            overflow: hidden;
            height: 500px; /* Adjust to fit your preferred height */
        }

        .mySlides {
            display: none;
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ensures the image covers the entire container without distortion */
        }
        .logout-button {
    background-color: #f44336;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}
.logout-button:hover {
    background-color: #d32f2f;
}

        /* Mobile responsiveness */
        @media (max-width: 600px) {
            ul {
                flex-direction: column;
                gap: 10px;
            }

            input[type="text"] {
                width: 80%;
            }

            .slideshow-container {
                height: 180px; /* Adjust for mobile screens */
            }
        }
    </style>
</head>
<body>
    <h1>Welcome to RevShop</h1>
    <form action="category" method="get">
        <input type="text" name="keyword" placeholder="Search products...">
        <input type="submit" value="Search">
    </form>

    
    <ul>
        <li><a href="category?category=electronics">Electronics</a></li>
        <li><a href="category?category=clothing">Clothing</a></li>
        <li><a href="category?category=books">Books</a></li>
        <li><a href="cart.jsp">Your Cart</a></li>
        <li><a href="MyOrders.jsp">My Orders</a></li>
        <li><a href="WishlistServlet">Wishlist</a></li>
     	 
    </ul>

    <!-- Slideshow section -->
    <div class="slideshow-container">
        <img class="mySlides" src="images/Boss-offers-new-tile_01.jpg">
        <img class="mySlides" src="images/BIG.jpg">
        <img class="mySlides" src="images/Banner-2-Washing-Mashine.jpg">
    </div>

    <script>
    var myIndex = 0;
    carousel();

    function carousel() {
        var i;
        var x = document.getElementsByClassName("mySlides");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        myIndex++;
        if (myIndex > x.length) {myIndex = 1}
        x[myIndex - 1].style.display = "block";
        setTimeout(carousel, 2000); // Change image every 2 seconds
    }
    </script>
    
</body>
</html>
