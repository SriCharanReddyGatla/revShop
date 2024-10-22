package com.revShop.models;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int buyerId;
    private Timestamp orderDate;
    private String shippingAddress;
    private String billingInfo;
    private double totalPrice;
    private String status; // "pending", "shipped", "delivered"

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getBuyerId() {
        return buyerId;
    }
    public void setBuyerId(int buyerId) {
        this.buyerId = buyerId;
    }
    public Timestamp getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
    public String getShippingAddress() {
        return shippingAddress;
    }
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    public String getBillingInfo() {
        return billingInfo;
    }
    public void setBillingInfo(String billingInfo) {
        this.billingInfo = billingInfo;
    }
    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
