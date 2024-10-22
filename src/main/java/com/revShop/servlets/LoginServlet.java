package com.revShop.servlets;

import com.revShop.dao.UserDAO;
import com.revShop.models.User;
import com.revShop.utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection connection = DBConnection.getConnection()) {
            UserDAO userDao = new UserDAO();
            User user = userDao.authenticate(email, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Check user role
                if ("seller".equals(user.getRole())) {
                    response.sendRedirect("sellerProducts.jsp"); // Redirect to product addition page
                } else {
                    response.sendRedirect("home.jsp"); // Redirect to home page for buyers
                }
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=failed");
        }
    }
}
