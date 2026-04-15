GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Fares' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS vuln_db;
USE vuln_db;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    is_admin BOOLEAN DEFAULT FALSE
);

INSERT INTO users (username, password, email, is_admin) VALUES
('admin', 'SuperSecretPassword123!', 'admin@internal.corp', TRUE),
('john_doe', 'p@ssword1', 'john@gmail.com', FALSE),
('jane_smith', 'sunnyday88', 'jane@company.com', FALSE),
('guest', 'guest', 'guest@local.host', FALSE);

DROP TABLE IF EXISTS system_config;
CREATE TABLE system_config (
    config_id INT PRIMARY KEY,
    service_name VARCHAR(50),
    api_key VARCHAR(100)
);

INSERT INTO system_config VALUES (1, 'PaymentGateway', 'sk_live_51Mz2nd82nd92');