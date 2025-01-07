-- Start by creating the database
CREATE DATABASE EcommerceDB2;
USE EcommerceDB2;
show databases;
-- 1. DATABASE DESIGN

-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) CHECK (Price > 0),
    Stock INT CHECK (Stock >= 0),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Order_Items Table
CREATE TABLE Order_Items (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Insert Categories
INSERT INTO Categories (Name) VALUES ('Laptops'), ('Smartphones'), ('Tablets'), ('Accessories'), ('Wearables');

-- Insert Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) 
VALUES
('John', 'Doe', 'johndoe@email.com', '555-1234', '123 Elm St'),
('Jane', 'Smith', 'janesmith@email.com', '555-5678', '456 Oak St'),
('Alice', 'Brown', 'alicebrown@email.com', '555-8765', '789 Pine St'),
('Bob', 'Johnson', 'bobjohnson@email.com', '555-4321', '101 Maple St'),
('Charlie', 'Davis', 'charliedavis@email.com', '555-3456', '202 Birch St'),
('David', 'Wilson', 'davidwilson@email.com', '555-6543', '303 Cedar St'),
('Eve', 'Miller', 'evemiller@email.com', '555-9876', '404 Willow St'),
('Frank', 'Moore', 'frankmoore@email.com', '555-2468', '505 Redwood St');

-- Insert Products
INSERT INTO Products (Name, Description, Price, Stock, CategoryID)
VALUES
('Laptop A', 'High performance laptop', 999.99, 50, 1),
('Laptop B', 'Mid-range laptop', 699.99, 30, 1),
('Smartphone X', 'Flagship smartphone', 799.99, 80, 2),
('Smartphone Y', 'Budget smartphone', 499.99, 20, 2),
('Tablet A', '10-inch tablet', 249.99, 100, 3),
('Tablet B', '8-inch tablet', 149.99, 60, 3),
('Headphones', 'Noise-cancelling headphones', 199.99, 200, 4),
('Smartwatch', 'Wearable smartwatch', 149.99, 150, 5),
('Charger', 'Fast charging adapter', 19.99, 500, 4),
('Keyboard', 'Mechanical keyboard', 79.99, 120, 4);

-- Insert Orders
INSERT INTO Orders (CustomerID, OrderDate)
VALUES
(1, '2025-01-01'),
(2, '2025-01-02'),
(3, '2025-01-03'),
(4, '2025-01-04'),
(5, '2025-01-05'),
(6, '2025-01-06'),
(7, '2025-01-07'),
(8, '2025-01-08'),
(1, '2025-01-09'),
(2, '2025-01-10'),
(3, '2025-01-11'),
(4, '2025-01-12');

-- Insert Order Items
INSERT INTO Order_Items (OrderID, ProductID, Quantity)
VALUES
(1, 1, 2), (1, 3, 1), (2, 2, 3), (3, 4, 1), (4, 5, 2),
(5, 6, 1), (6, 7, 1), (7, 8, 2), (8, 9, 3), (9, 10, 1),
(10, 1, 1), (11, 3, 2);


SELECT * FROM Customers;

SELECT * FROM Products;
select * from orders;
SELECT * FROM Order_Items;

-- View Orders with Customer Info
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- View Order Items with Product Info
SELECT oi.OrderItemID, oi.OrderID, p.Name AS ProductName, oi.Quantity
FROM Order_Items oi
JOIN Products p ON oi.ProductID = p.ProductID;

-- View Orders with Their Products and Quantities
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, p.Name AS ProductName, oi.Quantity
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Order_Items oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID;

-- 4.Queries
-- 1.Find Top 3 Customers by Order Value
SELECT c.FirstName, c.LastName, SUM(oi.Quantity * p.Price) AS TotalOrderValue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Order_Items oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID
ORDER BY TotalOrderValue DESC
LIMIT 3;

-- 2.List Products with Low Stock (Below 10)
SELECT Name, Stock
FROM Products
WHERE Stock < 10;

-- 3.Calculate Revenue by Category
SELECT cat.Name AS CategoryName, SUM(oi.Quantity * p.Price) AS Revenue
FROM Products p
JOIN Categories cat ON p.CategoryID = cat.CategoryID
JOIN Order_Items oi ON p.ProductID = oi.ProductID
GROUP BY cat.CategoryID;

-- 4.Show Orders with Their Items and Total Amount
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, p.Name AS ProductName, oi.Quantity, p.Price,
       (oi.Quantity * p.Price) AS ItemTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Order_Items oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID;

-- 5 advanced tasks
-- Create View: order_summary
CREATE VIEW order_summary AS
SELECT
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT oi.ProductID) AS UniqueProducts,
    SUM(oi.Quantity) AS TotalQuantity,
    SUM(oi.Quantity * p.Price) AS TotalAmount,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Order_Items oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY o.OrderID;

-- Stored Procedure: Update Stock Levels
DELIMITER //

CREATE PROCEDURE UpdateStockLevel(IN p_productID INT, IN p_quantity INT)
BEGIN
    -- Check if the product exists
    IF EXISTS (SELECT 1 FROM Products WHERE ProductID = p_productID) THEN
        UPDATE Products
        SET Stock = Stock - p_quantity
        WHERE ProductID = p_productID;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product not found';
    END IF;
END //

DELIMITER ;

-- Trigger on Inserting a New Order_Item

 DELIMITER //

CREATE TRIGGER AfterOrderItemInsert
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    CALL UpdateStockLevel(NEW.ProductID, NEW.Quantity);
END //

DELIMITER ;
DELIMITER //

-- Trigger on Deleting an Order_Item
CREATE TRIGGER AfterOrderItemDelete
AFTER DELETE ON Order_Items
FOR EACH ROW
BEGIN
    CALL UpdateStockLevel(OLD.ProductID, -OLD.Quantity);
END //

DELIMITER ;










