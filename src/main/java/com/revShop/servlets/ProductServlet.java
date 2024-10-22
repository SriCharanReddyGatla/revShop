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
import java.sql.DriverManager;
import java.sql.SQLException;
@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("error.jsp"); // Redirect to an error page if "id" is missing
            return;
        }
        try {
            int productId = Integer.parseInt(idParam); // Safely parse the productId after checking
            System.out.println(productId);

            try (Connection connection = DBConnection.getConnection()) {
                ProductDAO productDao = new ProductDAO();
                Product product = productDao.getProductById(productId); 
                System.out.println(product.getCategory());
                System.out.println(product.getId());
                if (product == null) {
                    response.sendRedirect("error.jsp"); // Handle product not found
                } 
                else {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("productDetails.jsp").forward(request, response); // Forward to JSP
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp"); // Handle SQL exceptions
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Handle invalid "id" format
        }
    }
}
