package com.pams.dao;

import com.pams.config.DBConnection;
import com.pams.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO - All database operations for the 'users' table using raw JDBC SQL queries.
 */
@Repository
public class UserDAO {

    @Autowired
    private DBConnection dbConnection;

    // Helper: maps a ResultSet row to a User object
    private User mapRow(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPhoneNumber(rs.getString("phone_number"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setResetToken(rs.getString("reset_token"));
        return user;
    }

    // INSERT a new user into the users table
    public boolean insertUser(User user) {
        String sql = "INSERT INTO users (name, email, phone_number, password, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhoneNumber());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("UserDAO insertUser error: " + e.getMessage());
            return false;
        }
    }

    // SELECT user by Email
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.out.println("UserDAO findByEmail error: " + e.getMessage());
        }
        return null;
    }

    // SELECT user by Phone Number
    public User findByPhoneNumber(String phone) {
        String sql = "SELECT * FROM users WHERE phone_number = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.out.println("UserDAO findByPhoneNumber error: " + e.getMessage());
        }
        return null;
    }

    // SELECT user by ID
    public User findById(Long id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.out.println("UserDAO findById error: " + e.getMessage());
        }
        return null;
    }

    // SELECT user by reset token
    public User findByResetToken(String token) {
        String sql = "SELECT * FROM users WHERE reset_token = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.out.println("UserDAO findByResetToken error: " + e.getMessage());
        }
        return null;
    }

    // UPDATE reset token for a user
    public void updateResetToken(Long userId, String token) {
        String sql = "UPDATE users SET reset_token = ? WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.setLong(2, userId);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("UserDAO updateResetToken error: " + e.getMessage());
        }
    }

    // UPDATE password and clear reset token
    public void updatePassword(Long userId, String newPassword) {
        String sql = "UPDATE users SET password = ?, reset_token = NULL WHERE id = ?";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setLong(2, userId);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("UserDAO updatePassword error: " + e.getMessage());
        }
    }

    // SELECT all users
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection con = dbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.out.println("UserDAO findAll error: " + e.getMessage());
        }
        return list;
    }
}
