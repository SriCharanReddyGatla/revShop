package com.revShop.servlets;

import com.revShop.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        ProductDAO productDao = new ProductDAO();
        productDao.deleteProduct(productId); // Delete the product

        response.sendRedirect("sellerProducts.jsp"); // Redirect back to the product list page
    }
}
