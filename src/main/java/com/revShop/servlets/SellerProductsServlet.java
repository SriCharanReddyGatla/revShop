package com.revShop.servlets;

import java.io.IOException;
import java.util.List;

import com.revShop.dao.ProductDAO;
import com.revShop.models.Product;
import com.revShop.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sellerProducts")
public class SellerProductsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"seller".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        ProductDAO productDao = new ProductDAO();
        List<Product> productList = productDao.getProductsBySeller(user.getId());  // Fetch products for the logged-in seller

        // Set product list as a request attribute
        request.setAttribute("productList", productList);

        // Forward to JSP page
        request.getRequestDispatcher("sellerProducts.jsp").forward(request, response);
    }
}
