package com.revShop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.revShop.models.CartItem;
import com.revShop.utils.DBConnection;

public class CartDAO {

    public void addProductToCart(int buyerId, int productId, int quantity) throws SQLException {
        String sql = "INSERT INTO cart (buyer_id, product_id, quantity) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, buyerId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();
        }
    }
    public List<CartItem> getCartItemsByUserId(int id) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT p.id, p.name AS product_name, c.quantity, p.price FROM cart c " +
                       "INNER JOIN products p ON c.product_id = p.id WHERE c.buyer_id = ?";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    CartItem cartItem = new CartItem();
                    cartItem.setProductId(rs.getInt("id"));
                    cartItem.setProductName(rs.getString("product_name"));
                    cartItem.setQuantity(rs.getInt("quantity"));
                    double pricePerUnit = rs.getDouble("price");
                    cartItem.setTotalPrice(pricePerUnit * cartItem.getQuantity());
                    cartItems.add(cartItem);
                }
            }
        }
        return cartItems;
    }
    
    public boolean deleteProductFromCart(int userId, int productId) {
        String query = "DELETE FROM cart WHERE buyer_id = ? AND product_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Returns true if the product is successfully deleted

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public double calculateTotalBill(int userId) throws SQLException {
        double total = 0.0;
        String query = "SELECT SUM(p.price * c.quantity) AS total FROM cart c " +
                       "INNER JOIN products p ON c.product_id = p.id WHERE c.buyer_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble("total");
                }
            }
        }
        return total;
    }
}
