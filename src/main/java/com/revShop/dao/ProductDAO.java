package com.revShop.dao;

import com.revShop.models.Product;
import com.revShop.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
//    private Connection connection;
//
//    public ProductDAO(Connection connection) {
//        this.connection = connection;
//    }

 /*   public Product getProductById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, id);
            System.out.println("ID : "+id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscountPrice(rs.getDouble("discount_price"));
                product.setCategory(rs.getString("category"));
                product.setImage(rs.getBytes("image"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                return product;
            }
        }
        return null;
    }*/

    public List<Product> searchProducts(String keyword) throws SQLException {
        String sql = "SELECT * FROM products WHERE name LIKE ?";
        List<Product> productList = new ArrayList<>();
        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscountPrice(rs.getDouble("discount_price"));
                product.setCategory(rs.getString("category"));
                product.setImage(rs.getBytes("image"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setSellerId(rs.getInt("seller_id"));
                productList.add(product);
            }
        }
        return productList;
    }
    public List<Product> getProductsByCategory(String category) throws SQLException {
        String query = "SELECT * FROM products WHERE category = ?";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(query)) {
            statement.setString(1, category);
            try (ResultSet rs = statement.executeQuery()) {
                List<Product> products = new ArrayList<>();
                while (rs.next()) {
                    Product product = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getBytes("image"), rs.getDouble("price"), rs.getDouble("discount_price"), rs.getString("category"),0,rs.getInt("seller_id"));
                    products.add(product);
                }
                return products;
            }
}
    }
    public void addProduct(Product product) throws SQLException {
        String query = "INSERT INTO products (name, description, image, price, discount_price, category,stock_quantity,seller_id) VALUES (?, ?, ?, ?, ?, ?,?,?)";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(query)) {
            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setBytes(3, product.getImage());
            statement.setDouble(4, product.getPrice());
            statement.setDouble(5, product.getDiscountPrice());
            statement.setString(6, product.getCategory());
            statement.setInt(7, product.getStockQuantity());
            statement.setInt(8, product.getSellerId());
            statement.executeUpdate();
        }
    }
 // Method to get products by seller ID
    public List<Product> getProductsBySeller(int sellerId) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM products WHERE seller_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, sellerId);
            
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("description"),
                    resultSet.getBytes("image"),
                    resultSet.getDouble("price"),
                    resultSet.getDouble("discount_price"),
                    resultSet.getString("category"),
                    resultSet.getInt("stock_quantity"),
                    resultSet.getInt("seller_id")
                );
                productList.add(product);
            }
            System.out.println("printing...");
            System.out.println("Product List Size: " + productList.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    // Method to delete a product by ID
    public void deleteProduct(int productId) {
        String query = "DELETE FROM products WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, productId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateProductStock(int productId, int quantityPurchased) throws SQLException {
        String query = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, quantityPurchased);
            statement.setInt(2, productId);
            
            int rowsUpdated = statement.executeUpdate();
            
            if (rowsUpdated == 0) {
                throw new SQLException("No product found with ID: " + productId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    public List<Product> getProductsByOrderId(int orderId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.* FROM products p " +
                       "JOIN orders_items oi ON p.id = oi.product_id " +
                       "WHERE oi.order_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscountPrice(rs.getDouble("discountPrice"));
                product.setImage(rs.getBytes("image")); // Assuming image is stored as BLOB

                // Add product to the list
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

	public Product getProductById(int productId) throws SQLException {
		String sql = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, productId);
            System.out.println("ID : "+productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscountPrice(rs.getDouble("discount_price"));
                product.setCategory(rs.getString("category"));
                product.setImage(rs.getBytes("image"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                return product;
            }
        }
        return null;
	}

}
