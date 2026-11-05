CREATE DATABASE IF NOT EXISTS smart_task_agent
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_task_agent;

CREATE TABLE users (
  id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(100)  NOT NULL,
  email         VARCHAR(255)  NOT NULL UNIQUE,
  password_hash VARCHAR(255)  NOT NULL,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE categories (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id    INT UNSIGNED NOT NULL,
  name       VARCHAR(100) NOT NULL,
  color      CHAR(7) NOT NULL DEFAULT '#6366f1',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_user_category (user_id, name),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tasks (
  id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id      INT UNSIGNED NOT NULL,
  category_id  INT UNSIGNED NULL,
  parent_id    INT UNSIGNED NULL,
  title        VARCHAR(255) NOT NULL,
  description  TEXT NULL,
  status       ENUM('pending','in_progress','done') NOT NULL DEFAULT 'pending',
  priority     ENUM('low','medium','high') NOT NULL DEFAULT 'medium',
  due_date     DATETIME NULL,
  completed_at DATETIME NULL,
  created_by   ENUM('user','agent') NOT NULL DEFAULT 'user',
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_user_status (user_id, status),
  INDEX idx_due (due_date),
  FOREIGN KEY (user_id)     REFERENCES users(id)      ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
  FOREIGN KEY (parent_id)   REFERENCES tasks(id)      ON DELETE CASCADE
) ENGINE=InnoDB;