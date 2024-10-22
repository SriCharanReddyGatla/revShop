package com.revShop.servlets;

import com.revShop.dao.CartDAO;
import com.revShop.models.User;
import com.revShop.utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/addToCart")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try (Connection connection = DBConnection.getConnection()) {
            CartDAO cartDao = new CartDAO();
            cartDao.addProductToCart(user.getId(), productId, quantity);

            // Send success response message
            response.setContentType("text/plain");
            response.getWriter().write("Product added to cart successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("Failed to add product to cart.");
        }
    }
}
