package com.revShop.dao;

import com.revShop.models.Order;
import com.revShop.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

	public void placeOrder(Order order) throws SQLException {
	    String query = "INSERT INTO orders (buyer_id, order_date, shipping_address, billing_info, total_price, status) VALUES (?, ?, ?, ?, ?, ?)";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(query)) {
	        stmt.setInt(1, order.getBuyerId());
	        stmt.setTimestamp(2, order.getOrderDate()); // Ensure the timestamp is correctly set
	        stmt.setString(3, order.getShippingAddress());
	        stmt.setString(4, order.getBillingInfo());
	        stmt.setDouble(5, order.getTotalPrice()); // Ensure total price is set as double
	        stmt.setString(6, order.getStatus()); // Ensure status is correctly set
	        stmt.executeUpdate();
	    }
	}

    public List<Order> getOrdersByBuyerId(int buyerId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE buyer_id = ?";
        
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setBillingInfo(rs.getString("billing_info"));
                    order.setTotalPrice(rs.getDouble("total_price")); // Using double instead of BigDecimal
                    order.setStatus(rs.getString("status"));
                    orders.add(order);
                }
            }
        }
        
        return orders;
    }


}
