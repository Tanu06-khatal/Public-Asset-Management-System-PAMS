package com.pams.model;

/**
 * User - represents a Citizen or Admin in the system.
 * Maps to the 'users' table in MySQL.
 * No JPA annotations - uses plain JDBC via DAOs.
 */
public class User {

    private Long id;
    private String name;
    private String email;
    private String phoneNumber;
    private String password;
    private String role;       // "USER" or "ADMIN"
    private String resetToken;

    public User() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getResetToken() { return resetToken; }
    public void setResetToken(String resetToken) { this.resetToken = resetToken; }
}
