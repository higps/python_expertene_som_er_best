-- Create the main database
-- CREATE DATABASE main_database;
-- \c main_database;

SELECT * FROM marius_users;
CREATE SCHEMA marius;

-- Create a table for users with a primary key
CREATE TABLE marius.marius_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- Create a table for products with a primary key
CREATE TABLE marius.marius_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

-- Create a composite table with foreign keys referencing the primary keys of the users and products tables
CREATE TABLE marius.marius_composite_table (
    user_id INT REFERENCES marius.marius_users(user_id),
    product_id INT REFERENCES marius.marius_products(product_id),
    PRIMARY KEY (user_id, product_id)
);

-- Insert sample data into the users table
INSERT INTO marius.marius_users (username) VALUES
    ('John Doe'),
    ('Jane Smith'),
    ('Bob Johnson');

-- Insert sample data into the products table
INSERT INTO marius.marius_products (product_name) VALUES
    ('Laptop'),
    ('Smartphone'),
    ('Headphones');

-- Insert sample data into the composite_table
INSERT INTO marius.marius_composite_table (user_id, product_id) VALUES
    (1, 1),  -- John Doe owns a Laptop
    (2, 2),  -- Jane Smith owns a Smartphone
    (3, 3),  -- Bob Johnson owns Headphones
    (1, 2),  -- John Doe owns a Smartphone as well
    (2, 2),  -- Jane Smith owns a Smartphone
    (2, 3);  -- Jane Smith owns Headphones as well

-- Create a new table referencing marius_users
CREATE TABLE marius.marius_orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES marius.marius_users(user_id),
    order_date DATE NOT NULL
);

-- Create a new table referencing marius_composite_table
CREATE TABLE marius.marius_order_details (
    order_id INT REFERENCES marius.marius_orders(order_id),
    user_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, user_id, product_id)
);

-- Insert sample data into the marius_orders table
INSERT INTO marius.marius_orders (user_id, order_date) VALUES
    (1, '2023-01-01'),
    (2, '2023-01-02'),
    (3, '2023-01-03');

-- Insert sample data into the marius_order_details table
INSERT INTO marius.marius_order_details (order_id, user_id, product_id, quantity) VALUES
    (1, 1, 1, 2),  -- John Doe orders 2 Laptops
    (2, 2, 2, 1),  -- Jane Smith orders 1 Smartphone
    (3, 3, 3, 3);  -- Bob Johnson orders 3 Headphones

truncate table marius_users, marius_products, marius_composite_table;
    
truncate table marius_users, marius_products, marius_composite_table;

TRUNCATE marius_users, marius_products, marius_composite_table RESTART IDENTITY;
    
TRUNCATE TABLE marius_composite_table, marius_products, marius_users RESTART IDENTITY;

-- Alter the data type of the username column in marius_users table
ALTER TABLE marius.marius_users
ALTER COLUMN username TYPE VARCHAR(30);

-- Check the modified table structure
\d marius.marius_users;

-- Add a unique constraint to the username column in marius_users table
ALTER TABLE marius.marius_users
ADD CONSTRAINT unique_username UNIQUE (username);