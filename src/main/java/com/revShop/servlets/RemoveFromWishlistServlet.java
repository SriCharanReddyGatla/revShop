package com.revShop.servlets;

import java.io.IOException;
import java.sql.SQLException;

import com.revShop.dao.WishlistDAO;
import com.revShop.models.User;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RemoveFromWishlist")
public class RemoveFromWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        int productId = Integer.parseInt(request.getParameter("productId"));
        WishlistDAO wishlistDao = new WishlistDAO();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            wishlistDao.removeFromWishlist(userId, productId);
            // Return success response in JSON format
            response.getWriter().write("{\"success\": true}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"error\": \"Unable to remove product from wishlist.\"}");
        }
    }
}
