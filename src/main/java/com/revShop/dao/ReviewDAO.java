package com.revShop.dao;

import com.revShop.models.Review;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.revShop.utils.DBConnection;

public class ReviewDAO {
    // Method to insert a review into the database
    public void insertReview(Review review) {
        String sql = "INSERT INTO reviews (order_id, product_id, review_text, rating) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, review.getOrderId());
            stmt.setInt(2, review.getProductId());
            stmt.setString(3, review.getReviewText());
            stmt.setInt(4, review.getRating());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setProductId(rs.getInt("product_id"));
                review.setId(rs.getInt("user_id"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("review_text"));
                review.setReviewDate((Date) new java.util.Date(rs.getTimestamp("review_date").getTime()));

                reviews.add(review);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }
}
