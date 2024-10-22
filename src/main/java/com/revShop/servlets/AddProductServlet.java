package com.revShop.servlets;

import com.revShop.dao.ProductDAO;
import com.revShop.models.Product;
import com.revShop.utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/addProduct")
@MultipartConfig 
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        // Handle image upload
        Part imagePart = request.getPart("image");
        InputStream inputStream = imagePart.getInputStream();
        byte[] imageBytes = inputStream.readAllBytes();
        
//        String fileName = imagePart.getSubmittedFileName();
//        String uploadDir = getServletContext().getRealPath("/") + "images";
//
//        // Ensure the directory exists, and create it if not
//        File uploadDirectory = new File(uploadDir);
//        if (!uploadDirectory.exists()) {
//            uploadDirectory.mkdirs(); // Creates the directory and any necessary but nonexistent parent directories
//        }
//
//        // Set the full path where the image will be saved
//        String imagePath = uploadDir + File.separator + fileName;
//
//        // Save the image file to the defined path
//        imagePart.write(imagePath);
//        String priceParam = request.getPart("price").getSubmittedFileName(); // This is key for multipart forms
//        double price = (priceParam == null || priceParam.isEmpty()) ? 0.0 : Double.parseDouble(priceParam);
        
        
        double price=Double.parseDouble(request.getParameter("price"));
        double discountPrice = Double.parseDouble(request.getParameter("discountPrice"));
        int seller_id = Integer.parseInt(request.getParameter("seller_id"));
        String category = request.getParameter("category");
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

        // Save the image file
//        String imagePath = "path/to/images/" + imagePart.getSubmittedFileName();
//        imagePart.write(imagePath);

        try (Connection connection = DBConnection.getConnection()) {
            ProductDAO productDao = new ProductDAO();
            Product product = new Product(2,name, description, imageBytes, price, discountPrice, category,stockQuantity,seller_id);
            productDao.addProduct(product);
            response.sendRedirect("sellerProducts.jsp"); // Redirect to a success page or product list
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
