-- ===========================================================
-- PostgreSQL Schema for Python Expense Tracker
-- Author: Adrian Ablaza
-- Description: Defines database tables and relationships
-- ===========================================================

-- Drop tables if they already exist (for resetting)
DROP TABLE IF EXISTS expenses CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ===========================================================
-- USERS TABLE
-- ===========================================================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ===========================================================
-- CATEGORIES TABLE
-- ===========================================================
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ===========================================================
-- EXPENSES TABLE
-- ===========================================================
CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    category_id INTEGER NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    description TEXT,
    trans_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- ===========================================================
-- SAMPLE DATA (optional)
-- ===========================================================

-- Insert sample users
INSERT INTO users (name) VALUES
('Adrian'),
('Alex');

-- Insert sample categories
INSERT INTO categories (name) VALUES
('Food'),
('Transport'),
('Utilities'),
('Entertainment');

-- Insert sample expenses
INSERT INTO expenses (user_id, category_id, amount, description)
VALUES
(1, 1, 250.00, 'Lunch at local cafe'),
(1, 2, 120.00, 'Jeep fare'),
(2, 3, 980.00, 'Electric bill');
