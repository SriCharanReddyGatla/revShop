package com.revShop.servlets;

import com.revShop.dao.CartDAO;
import com.revShop.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteFromCart")
public class DeleteFromCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !"buyer".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        System.out.println(userId);
        int productId = Integer.parseInt(request.getParameter("productId"));
        System.out.println(productId);
        CartDAO cartDao = new CartDAO();
        boolean isDeleted = cartDao.deleteProductFromCart(userId, productId);

        if (isDeleted) {
            response.sendRedirect("cart.jsp");
        } else {
            // Handle deletion failure (optional)
            response.getWriter().write("Failed to delete product from cart.");
        }
    }
}
