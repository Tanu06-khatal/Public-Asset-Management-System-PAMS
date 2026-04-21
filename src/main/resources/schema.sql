-- ============================================================
-- PAMS - Public Asset Management System
-- Database Schema - All Tables
-- ============================================================

-- 1. USERS Table (Citizens and Admins)
CREATE TABLE IF NOT EXISTS users (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100)  NOT NULL,
    email         VARCHAR(150)  NOT NULL UNIQUE,
    phone_number  VARCHAR(10)   NOT NULL UNIQUE,
    password      VARCHAR(255)  NOT NULL,
    role          VARCHAR(20)   NOT NULL DEFAULT 'USER',
    reset_token   VARCHAR(255)  DEFAULT NULL,
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- 2. ASSETS Table (Public Assets like Roads, Streetlights, Pumps etc.)
CREATE TABLE IF NOT EXISTS assets (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    asset_name    VARCHAR(150)  NOT NULL,
    asset_type    VARCHAR(100)  NOT NULL,
    location      VARCHAR(255)  NOT NULL,
    installed_on  DATE          DEFAULT NULL,
    status        VARCHAR(50)   NOT NULL DEFAULT 'ACTIVE',
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- 3. TECHNICIANS Table (Field workers who handle complaints)
CREATE TABLE IF NOT EXISTS technicians (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100)  NOT NULL,
    phone_number  VARCHAR(10)   NOT NULL UNIQUE,
    specialization VARCHAR(150) NOT NULL,
    available     BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- 4. COMPLAINTS Table (Complaints raised by Citizens)
CREATE TABLE IF NOT EXISTS complaints (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    asset_name      VARCHAR(150)  NOT NULL,
    location        VARCHAR(255)  NOT NULL,
    description     VARCHAR(1000) NOT NULL,
    fault_date      DATE          NOT NULL,
    image_url       VARCHAR(500)  DEFAULT NULL,
    status          VARCHAR(30)   NOT NULL DEFAULT 'PENDING',
    admin_message   VARCHAR(500)  DEFAULT NULL,
    user_id         BIGINT        NOT NULL,
    technician_id   BIGINT        DEFAULT NULL,
    created_at      TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_complaint_user       FOREIGN KEY (user_id)       REFERENCES users(id),
    CONSTRAINT fk_complaint_technician FOREIGN KEY (technician_id) REFERENCES technicians(id)
);

-- 5. MAINTENANCE_LOGS Table (Log of every action taken on a complaint)
CREATE TABLE IF NOT EXISTS maintenance_logs (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    complaint_id    BIGINT        NOT NULL,
    technician_id   BIGINT        DEFAULT NULL,
    action_taken    VARCHAR(500)  NOT NULL,
    log_date        TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_log_complaint   FOREIGN KEY (complaint_id)  REFERENCES complaints(id),
    CONSTRAINT fk_log_technician  FOREIGN KEY (technician_id) REFERENCES technicians(id)
);
