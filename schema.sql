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
    name VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE
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
    trans_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
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

-- ===========================================================
-- STORED PROCEDURES
-- ===========================================================

-- Procedure to add a new expense record
CREATE OR REPLACE PROCEDURE expense_addRecord(
    p_userName VARCHAR,
    p_categoryName VARCHAR,
    p_amount NUMERIC,
    p_description TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id INT;
    v_category_id INT;
BEGIN
    --Find user ID
    SELECT id INTO v_user_id FROM users WHERE name = INITCAP(TRIM(p_userName));
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'User % not found', p_userName;
    END IF;

    --Find category ID
    SELECT id INTO v_category_id FROM categories WHERE name = INITCAP(TRIM(p_categoryName));
    IF v_category_id IS NULL THEN
        RAISE EXCEPTION 'Category % not found', p_categoryName;
    END IF;

    INSERT INTO expenses (user_id,category_id,amount,description, trans_date)
    VALUES (v_user_id,v_category_id,p_amount,p_description,CURRENT_TIMESTAMP);
END;
$$;


-- ===========================================================
-- INDEXES FOR PERFORMANCE (OPTIONAL)
-- ===========================================================

CREATE INDEX idx_expenses_user_id ON expenses(user_id);
CREATE INDEX idx_expenses_category_id ON expenses(category_id);
