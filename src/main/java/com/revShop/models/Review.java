package com.revShop.models;

import java.sql.Date;
import java.sql.Timestamp;

public class Review {
    private int id;               // Unique identifier for each review
    private int orderId;          // Foreign key to identify the order associated with the review
    private int productId;        // Foreign key to identify the product being reviewed
    private String reviewText;    // The actual review text written by the user
    private int rating;           // Rating (1-5 stars)
    private Date reviewDate; // Date and time the review was made

    // Default constructor
    public Review() {
    }

    // Parameterized constructor
    public Review(int orderId, int productId, String reviewText, int rating, Date reviewDate) {
        this.orderId = orderId;
        this.productId = productId;
        this.reviewText = reviewText;
        this.rating = rating;
        this.reviewDate = reviewDate;
    }

    // Getters and setters for each field
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        if (rating >= 1 && rating <= 5) {
            this.rating = rating;
        } else {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    // Override toString() for easy debugging or logging
    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", productId=" + productId +
                ", reviewText='" + reviewText + '\'' +
                ", rating=" + rating +
                ", reviewDate=" + reviewDate +
                '}';
    }
}
