CREATE DATABASE IF NOT EXISTS db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE db;

-- Tabela de exemplo
CREATE TABLE IF NOT EXISTS example (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `value` DECIMAL(10, 2),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO example (`name`, `value`, `created_at`) VALUES
    ('Test 1', 100.50, CURRENT_TIMESTAMP),
    ('Test 2', 200.75, CURRENT_TIMESTAMP),
    ('Test 3', 300.00, CURRENT_TIMESTAMP);
