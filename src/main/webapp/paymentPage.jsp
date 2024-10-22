<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page</title>
    <style>
        /* Global styling */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }

        .payment-container {
            width: 100%;
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            animation: fadeIn 0.5s ease-in-out;
        }

        /* Buttons at the top */
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .action-buttons a, .action-buttons button {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            text-align: center;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }

        .action-buttons a:hover, .action-buttons button:hover {
            background-color: #0056b3;
        }

        /* Payment form styling */
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }

        label {
            margin: 10px 0;
            font-size: 16px;
            width: 100%;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 12px 25px;
            font-size: 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        /* Payment method sections */
        .payment-method-section {
            margin-bottom: 20px;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsiveness */
        @media (max-width: 768px) {
            .payment-container {
                width: 90%;
            }
        }

        /* Block elements for payment method details */
        #creditCardDetails, #debitCardDetails, #upiDetails {
            width: 100%;
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            border-radius: 8px;
            display: none;
            animation: fadeIn 0.5s ease-in-out;
        }

        h4 {
            margin-top: 0;
            font-size: 20px;
            text-align: center;
        }

    </style>
    <script>
        function showPaymentDetails() {
            var selectedMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            document.getElementById('creditCardDetails').style.display = selectedMethod === 'credit_card' ? 'block' : 'none';
            document.getElementById('debitCardDetails').style.display = selectedMethod === 'debit_card' ? 'block' : 'none';
            document.getElementById('upiDetails').style.display = selectedMethod === 'upi' ? 'block' : 'none';
        }
        
        window.onload = function() {
            showPaymentDetails(); // To ensure the correct details are displayed when the page loads
        };
    </script>
    
   
</head>
<body>

    <div class="payment-container">
        <h1>Payment Details</h1>

        <% 
            // Retrieve the billing info and total price from the previous page
            String billingInfo = request.getParameter("billingInfo");
            String totalPrice = request.getParameter("totalPrice");

            // Handle cases where the values are not passed correctly
            if (billingInfo == null || billingInfo.isEmpty()) {
                billingInfo = "No billing information provided.";
            }

            if (totalPrice == null || totalPrice.isEmpty()) {
                totalPrice = "0.0";
            }
        %>

        <!-- Display billing information and total price -->
        <p><strong>Billing Information:</strong> <%= billingInfo %></p>
        <p><strong>Total Price:</strong> ₹<%= totalPrice %></p>

        <!-- Payment method form (same as before) -->
       <!-- Payment method form -->
       <form action="PlaceOrder" method="POST">
    <!-- Hidden fields to pass forward billing and shipping information -->
    <input type="hidden" name="shippingAddress" value="<%= totalPrice%>">
    <input type="hidden" name="billingInfo" value="<%= billingInfo %>">

    <h3>Choose Payment Method</h3>

    <!-- Payment method options -->
    <div class="payment-method-section">
        <label>
            <input type="radio" name="paymentMethod" value="credit_card" onclick="showPaymentDetails()" required> Credit Card
        </label>
        <br>
        <label>
            <input type="radio" name="paymentMethod" value="debit_card" onclick="showPaymentDetails()" required> Debit Card
        </label>
        <br>
        <label>
            <input type="radio" name="paymentMethod" value="upi" onclick="showPaymentDetails()" required> UPI (Unified Payments Interface)
        </label>
    </div>

    <!-- Credit Card Details -->
    <div id="creditCardDetails">
        <h4>Credit Card Details</h4>
        <label>Card Number:
            <input type="text" name="cardNumber" placeholder="Enter your card number">
        </label>
        <br>
        <label>Expiry Date:
            <input type="text" name="expiryDate" placeholder="MM/YY">
        </label>
        <br>
        <label>CVV:
            <input type="text" name="cvv" placeholder="Enter CVV">
        </label>
    </div>

    <!-- Debit Card Details -->
    <div id="debitCardDetails">
        <h4>Debit Card Details</h4>
        <label>Card Number:
            <input type="text" name="debitCardNumber" placeholder="Enter your card number">
        </label>
        <br>
        <label>Expiry Date:
            <input type="text" name="debitExpiryDate" placeholder="MM/YY">
        </label>
        <br>
        <label>CVV:
            <input type="text" name="debitCvv" placeholder="Enter CVV" >
        </label>
    </div>

    <!-- UPI Details -->
    <div id="upiDetails">
        <h4>UPI Details</h4>
        <label>UPI ID:
            <input type="text" name="upiId" placeholder="Enter your UPI ID" >
        </label>
    </div>

    <input type="submit" value="Confirm" class="submit-btn">
</form>

    </div>

</body>
</html>
