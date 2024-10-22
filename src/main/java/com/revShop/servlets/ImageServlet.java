package com.revShop.servlets;

import java.io.IOException;
import java.sql.SQLException;

import com.revShop.dao.ProductDAO;
import com.revShop.models.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/imageServlet")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Create an instance of ProductDAO
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        // Initialize ProductDAO
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id"); // Get the product id from the request
        if (productId != null) {
            try {
                // Use the instance of ProductDAO to get the product
                Product product = productDAO.getProductById(Integer.parseInt(productId)); // Fetch product from the database

                if (product != null && product.getImage() != null) {
                    byte[] imageBytes = product.getImage(); // Get image as byte array

                    // Set the response content type based on the image format
                    response.setContentType("image/*");  // Change MIME type if the image format is different

                    // Write the image bytes to the output stream
                    response.getOutputStream().write(imageBytes);
                    response.getOutputStream().flush();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch image");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing");
        }
    }
}
