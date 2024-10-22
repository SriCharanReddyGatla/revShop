package com.revShop.servlets;

import com.revShop.dao.OrderDAO;
import com.revShop.models.Order;
import com.revShop.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int buyerId = user.getId();
        OrderDAO orderDao = new OrderDAO();
        List<Order> orders = null;

        try {
            // Retrieve orders for the current buyer
            orders = orderDao.getOrdersByBuyerId(buyerId);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving order details.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Set the retrieved order(s) as attributes for the JSP
        request.setAttribute("orders", orders);

        // Forward to the confirmation JSP page
        request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
    }
}
