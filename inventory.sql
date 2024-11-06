/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
- referential integrity is enforced
Details:
- Check if the database 'Inventory' exists, if it does exist, drop it and create a new one.
- Set the default database to 'Inventory'.
- Create a 'suppliers' table. Use the following columns:
-- id: integer, primary key
-- name: 50 characters, not null
-- address: 255 characters, nullable
-- city: 50 characters, not null
-- state: 2 characters, not null
- Create the 'categories' table with a one-to-many relation to the 'suppliers'. Use the following columns:
-- id:  integer, primary key
-- name: 50 characters, not null
-- description:  255 characters, nullable
-- supplier_id: int, foreign key references suppliers(id)
- Create the 'products' table with a one-to-many relation to the 'categories' table. Use the following columns:
-- id: integer, primary key
-- name: 50 characters, not null
-- price: decimal (10, 2), not null
-- category_id: int, foreign key references categories(id)
- Populate the 'suppliers' table with sample data.
- Populate the 'categories' table with sample data.
- Populate the 'products' table with sample data.
- Create a view named 'product_list' that displays the following columns:
-- product_id
-- product_name
-- category_name
-- supplier_name
- Create a stored procedure named 'get_product_list' that returns the product list view.
- Create a trigger that updates the 'products' table when a 'categories' record is deleted.
- Create a function that returns the total number of products in a category.
- Create a function that returns the total number of products supplied by a supplier.
*/

-- Check if the database 'Inventory' exists, if it does exist, drop it and create a new one.
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Inventory')
BEGIN
    ALTER DATABASE Inventory SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Inventory;
END
GO

-- Create a new database named 'Inventory'
CREATE DATABASE Inventory;
GO

-- Set the default database to 'Inventory'
USE Inventory;
GO

-- Create a 'suppliers' table
CREATE TABLE suppliers (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL,
    -- Add a Description of the supplier maximum 255 characters
    description VARCHAR(255)
);
GO

-- Create the 'categories' table with a one-to-many relation to the 'suppliers'
CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);
GO

-- Create the 'products' table with a one-to-many relation to the 'categories' table
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
GO

-- Populate the 'suppliers' table with sample data
INSERT INTO suppliers (id, name, address, city, state, description) VALUES
(1, 'Supplier 1', '123 Main St', 'City 1', 'CA', 'Supplier 1 Description'),
(2, 'Supplier 2', '456 Elm St', 'City 2', 'NY', 'Supplier 2 Description'),
(3, 'Supplier 3', '789 Oak St', 'City 3', 'TX', 'Supplier 3 Description');
GO

-- Populate the 'categories' table with sample data
INSERT INTO categories (id, name, description, supplier_id) VALUES
(1, 'Category 1', 'Category 1 Description', 1),
(2, 'Category 2', 'Category 2 Description', 2),
(3, 'Category 3', 'Category 3 Description', 3);
GO

-- Populate the 'products' table with sample data
INSERT INTO products (id, name, price, category_id) VALUES
(1, 'Product 1', 10.00, 1),
(2, 'Product 2', 20.00, 2),
(3, 'Product 3', 30.00, 3);
(4, 'Product 4', 30.00, 3);
GO

-- Create a view named 'product_list' that displays the following columns
CREATE VIEW product_list AS
SELECT p.id AS product_id, p.name AS product_name, c.name AS category_name, s.name AS supplier_name
FROM products p
JOIN categories c ON p.category_id = c.id
JOIN suppliers s ON c.supplier_id = s.id;
GO







