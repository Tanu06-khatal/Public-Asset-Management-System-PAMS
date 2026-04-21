package com.pams.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Central JDBC Connection class.
 * Used across DAOs to get a raw SQL connection to MySQL.
 * Similar to the DBConnection.java pattern used in basic Tomcat / Servlet projects.
 */
@Component
public class DBConnection {

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    /**
     * Returns a new JDBC Connection to the MySQL database.
     * Always close the connection after use (use try-with-resources).
     */
    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
        return DriverManager.getConnection(url, username, password);
    }
}
