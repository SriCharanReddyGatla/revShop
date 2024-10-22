package com.revShop.servlets;

import com.revShop.dao.ProductDAO;
import com.revShop.models.Product;
import com.revShop.utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");

        try (Connection connection = DBConnection.getConnection()) {
            ProductDAO productDao = new ProductDAO();
            List<Product> products = productDao.getProductsByCategory(category);
            request.setAttribute("products", products);
            request.getRequestDispatcher("category.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
