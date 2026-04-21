package com.pams.service;

import com.pams.dao.UserDAO;
import com.pams.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

/**
 * UserService - Business logic for user registration, login, and password reset.
 * Uses UserDAO which runs raw SQL PreparedStatements.
 */
@Service
public class UserService {

    @Autowired
    private UserDAO userDAO;

    /**
     * Validates all fields, checks for duplicates, then inserts into DB.
     * Returns an error message string if validation fails, null if success.
     */
    public String registerUser(String name, String email, String phone, String password, String role) {

        // --- VALIDATIONS ---
        // Name: only letters and spaces
        if (name == null || name.trim().isEmpty()) return "Name is required.";
        if (!name.matches("[A-Za-z ]+")) return "Name must contain only letters and spaces.";
        if (name.trim().length() < 2) return "Name must be at least 2 characters.";

        // Email: basic format check
        if (email == null || email.trim().isEmpty()) return "Email is required.";
        if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) return "Please enter a valid email address.";

        // Phone: exactly 10 digits
        if (phone == null || phone.trim().isEmpty()) return "Phone number is required.";
        if (!phone.matches("\\d{10}")) return "Phone number must be exactly 10 digits (numbers only).";

        // Password: 6 to 20 characters
        if (password == null || password.trim().isEmpty()) return "Password is required.";
        if (password.length() < 6) return "Password must be at least 6 characters.";
        if (password.length() > 20) return "Password must not exceed 20 characters.";
        if (password.contains(" ")) return "Password must not contain spaces.";

        // Role
        if (role == null || (!role.equals("USER") && !role.equals("ADMIN"))) {
            role = "USER";
        }

        // --- DUPLICATE CHECKS via SQL SELECT ---
        if (userDAO.findByEmail(email.trim()) != null) {
            return "An account with this email already exists. Please login.";
        }
        if (userDAO.findByPhoneNumber(phone.trim()) != null) {
            return "An account with this phone number already exists.";
        }

        // --- INSERT ---
        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim().toLowerCase());
        user.setPhoneNumber(phone.trim());
        user.setPassword(password);
        user.setRole(role);

        boolean success = userDAO.insertUser(user);
        if (!success) return "Registration failed due to a database error. Please try again.";
        return null; // null = success
    }

    /**
     * Validates login credentials. Returns the User object if valid, null otherwise.
     * Allows login with either email or phone number.
     */
    public User validateLogin(String identifier, String password) {
        if (identifier == null || identifier.trim().isEmpty()) return null;
        if (password == null || password.trim().isEmpty()) return null;

        // Try finding by email first, then by phone
        User user = userDAO.findByEmail(identifier.trim().toLowerCase());
        if (user == null) {
            user = userDAO.findByPhoneNumber(identifier.trim());
        }

        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    /**
     * Creates a password-reset token and stores it in DB.
     * Returns the token, or null if email not found.
     */
    public String createPasswordResetToken(String email) {
        User user = userDAO.findByEmail(email.trim().toLowerCase());
        if (user == null) return null;

        String token = UUID.randomUUID().toString();
        userDAO.updateResetToken(user.getId(), token);
        return token;
    }

    /**
     * Resets password using the token. Returns true if successful.
     */
    public boolean resetPassword(String token, String newPassword) {
        if (newPassword == null || newPassword.length() < 6) return false;

        User user = userDAO.findByResetToken(token);
        if (user == null) return false;

        userDAO.updatePassword(user.getId(), newPassword);
        return true;
    }

    public User findById(Long id) {
        return userDAO.findById(id);
    }
}
