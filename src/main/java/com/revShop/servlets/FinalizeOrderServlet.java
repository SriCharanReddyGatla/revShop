package com.revShop.servlets;

import com.revShop.dao.OrderDAO; // Create this class
import com.revShop.models.Order; // Create this class
import com.revShop.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/FinalizeOrderServlet")
public class FinalizeOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");
        String billingInfo = request.getParameter("billingInfo");
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

        // Create an Order object and save it
        OrderDAO orderDao = new OrderDAO();
        Order order = new Order();
        order.setBuyerId(user.getId());
        order.setShippingAddress(shippingAddress);
        order.setBillingInfo(billingInfo);
        order.setTotalPrice(totalPrice);
        
        // Add the order to the database
        try {
			orderDao.placeOrder(order);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // Implement this method in OrderDAO

        // Optionally, clear the cart after placing the order
        // cartDao.clearCart(user.getId());

        request.setAttribute("message", "Order placed successfully!");
        request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);
    }
}
