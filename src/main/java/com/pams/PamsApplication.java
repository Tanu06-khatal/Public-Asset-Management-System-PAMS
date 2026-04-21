package com.pams;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/**
 * PAMS - Public Asset Management System
 * Main Spring Boot entry point.
 *
 * Note: We use Spring Data JPA only for the DataSource (JDBC connection pool).
 * All database queries are performed via raw JDBC PreparedStatements in DAO classes.
 * JPA entity scanning is disabled since our models are plain Java classes (no @Entity).
 */
@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.pams.DISABLED_NO_JPA_REPOS")
@EntityScan(basePackages = "com.pams.DISABLED_NO_JPA_ENTITIES")
public class PamsApplication {

    public static void main(String[] args) {
        SpringApplication.run(PamsApplication.class, args);
    }
}
