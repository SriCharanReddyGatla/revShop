package com.revShop.servlets;

import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.revShop.dao.CartDAO;
import com.revShop.dao.OrderDAO;
import com.revShop.models.CartItem;
import com.revShop.models.Order;
import com.revShop.models.User;
import com.revShop.utils.MailUtility;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PlaceOrder")
public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        String shippingAddress = request.getParameter("shippingAddress");
        String billingInfo = request.getParameter("billingInfo");

        // Create the order object
        Order order = new Order();
        order.setBuyerId(userId);
        System.out.println(userId);

        // Set the current timestamp as order date
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(System.currentTimeMillis());
        System.out.println(currentTimestamp);
        order.setOrderDate(currentTimestamp); // Ensure this is being set

        // Set the status to pending
        order.setStatus("pending"); // Ensure this is being set

        order.setShippingAddress(shippingAddress);
        order.setBillingInfo(billingInfo);

        // Initialize DAO objects
        CartDAO cartDao = new CartDAO();
        OrderDAO orderDao = new OrderDAO();

        // Debugging output to verify the order details
        System.out.println("Order Timestamp: " + order.getOrderDate());
        System.out.println("Order Status: " + order.getStatus());

        try {
            // Retrieve cart items and calculate total price
            List<CartItem> cartItems = cartDao.getCartItemsByUserId(userId);
            double totalPrice = 0.0;

            for (CartItem item : cartItems) {
                // Assuming each CartItem has a method to get product price
                double price = item.getTotalPrice(); // Already calculated in CartItem
                totalPrice += price * item.getQuantity();
            }

            order.setTotalPrice(totalPrice); // Set total price for the order

            // Debugging output for the total price
            System.out.println("Total Price: " + order.getTotalPrice());

            // Place order
            orderDao.placeOrder(order);

            // Optionally clear the cart after placing the order
            // cartDao.clearCart(userId); // Uncomment if cart should be cleared

            // Pass billing info and total price to the payment page
            request.setAttribute("billingInfo", billingInfo);
            request.setAttribute("totalPrice", totalPrice);

            String userEmail = user.getEmail();
            String orderDetails = "Order Details:\nTotal Price: ₹" + totalPrice + "\nShipping Address: " + shippingAddress + "\nBilling Info: " + billingInfo;
            MailUtility.sendOrderConfirmation(userEmail, orderDetails);

            // Optionally clear the cart after placing the order
            // cartDao.clearCart(userId); // Uncomment if cart should be cleared

            // Redirect to payment page or order confirmation page
            response.sendRedirect("orderSuccess.jsp");

        } catch (SQLException | MessagingException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error placing order.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
