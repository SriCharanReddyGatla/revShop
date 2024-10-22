package com.revShop.servlets;

import com.revShop.dao.WishlistDAO;
import com.revShop.models.Product;
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

import javax.servlet.RequestDispatcher;

@WebServlet("/WishlistServlet")
public class AddToWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int userId = user.getId();

        WishlistDAO wishlistDAO = new WishlistDAO();
        try {
            wishlistDAO.addToWishlist(userId, productId);
            request.setAttribute("successMessage", "Product successfully added to your wishlist!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding product to wishlist.");
        }

        // Redirect back to products page (or forward to the same page)
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId(); // Get the logged-in user's ID

        WishlistDAO wishlistDAO = new WishlistDAO();
        try {
            // Fetch the wishlist items for this user
            List<Product> wishlistItems = wishlistDAO.getWishlistItems(userId);

            // Set the wishlist items in the request scope to forward to JSP
            request.setAttribute("wishlistItems", wishlistItems);

            // Forward to MyWishlist.jsp for displaying the wishlist
            jakarta.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("Wishlist.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving wishlist items.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

}
