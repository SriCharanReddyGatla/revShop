package com.revShop.servlets;

import com.revShop.dao.ReviewDAO;
import com.revShop.models.Review;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/submitReview")
public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the review details from the form
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        String reviewText = request.getParameter("reviewText");
        int rating = Integer.parseInt(request.getParameter("rating"));

        // Create a new review object
        Review review = new Review();
        review.setOrderId(orderId);
        review.setProductId(productId);
        review.setReviewText(reviewText);
        review.setRating(rating);

        // Insert the review into the database using DAO
        ReviewDAO reviewDao = new ReviewDAO();
        reviewDao.insertReview(review);

        // Redirect to the My Orders page after submission
        response.sendRedirect("MyOrders.jsp");
    }
}
