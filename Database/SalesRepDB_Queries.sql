-- 1. Create Database
CREATE DATABASE SalesRepDB;
GO

USE SalesRepDB;
GO

-- 2. Create Table: SalesRepresentatives
CREATE TABLE SalesRepresentatives (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Email NVARCHAR(150),
    PhoneNumber NVARCHAR(20),
    Region NVARCHAR(100),
    HireDate DATE,
    Status NVARCHAR(50)
);

-- 3. Create Table: Products
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Category NVARCHAR(100),
    Price DECIMAL(10,2),
    IsActive BIT
);

-- 4. Create Table: Sales
CREATE TABLE Sales (
    Id INT PRIMARY KEY IDENTITY(1,1),
    SalesRepId INT FOREIGN KEY REFERENCES SalesRepresentatives(Id),
    ProductId INT FOREIGN KEY REFERENCES Products(Id),
    Quantity INT,
    SaleDate DATE,
    Amount DECIMAL(10, 2) -- manually inserted or calculated in application logic
);

-- 5. Create Table: Targets
CREATE TABLE Targets (
    Id INT PRIMARY KEY IDENTITY(1,1),
    SalesRepId INT FOREIGN KEY REFERENCES SalesRepresentatives(Id),
    TargetMonth VARCHAR(7), -- e.g., '2025-06'
    TargetAmount DECIMAL(10,2)
);

-- 6. Seed Data: SalesRepresentatives
INSERT INTO SalesRepresentatives (FirstName, LastName, Email, PhoneNumber, Region, HireDate, Status) VALUES
('Rahul', 'Mehra', 'rahul.mehra@example.com', '9876543210', 'East', '2022-04-15', 'Active'),
('Sneha', 'Rao', 'sneha.rao@example.com', '9812345678', 'West', '2023-01-12', 'Active'),
('Amit', 'Singh', 'amit.singh@example.com', '9923456781', 'North', '2021-08-30', 'Inactive');

-- 7. Seed Data: Products
INSERT INTO Products (Name, Category, Price, IsActive) VALUES
('UltraCleaner X1', 'Cleaning Supplies', 499.99, 1),
('SparkVac Pro', 'Electronics', 1299.50, 1),
('EcoMop 3000', 'Cleaning Supplies', 299.00, 0);

-- 8. Seed Data: Sales (calculate Amount = Quantity * Price)
-- Rahul sold 10 UltraCleaner X1 = 10 * 499.99 = 4999.90
-- Sneha sold 5 SparkVac Pro = 5 * 1299.50 = 6497.50
-- Rahul sold 2 SparkVac Pro = 2 * 1299.50 = 2599.00

INSERT INTO Sales (SalesRepId, ProductId, Quantity, SaleDate, Amount) VALUES
(1, 1, 10, '2025-05-01', 4999.90),
(2, 2, 5, '2025-05-10', 6497.50),
(1, 2, 2, '2025-05-15', 2599.00);

-- 9. Seed Data: Targets
INSERT INTO Targets (SalesRepId, TargetMonth, TargetAmount) VALUES
(1, '2025-06', 5000.00),
(2, '2025-06', 8000.00),
(3, '2025-06', 4000.00);









