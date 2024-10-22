package com.revShop.dao;

import com.revShop.models.User;
import com.revShop.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
//    private Connection connection=DBConnection.getConnection();
//
//    public UserDAO(Connection connection) {
//        this.connection = connection;
//    }

    public void registerUser(String email, String password, String role, String businessDetails) throws SQLException {
        String sql = "INSERT INTO users (email, password, role, bussiness_details) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, role);
            stmt.setString(4, businessDetails);
            stmt.executeUpdate();
        }
    }

    public User authenticate(String email, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setBusinessDetails(rs.getString("bussiness_details"));
                return user;
            }
        }
        return null;
    }
}
