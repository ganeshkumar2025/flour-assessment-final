select * from products 
select * from SalesRepresentatives
select * from sales

INSERT INTO SalesRepresentatives (FirstName, LastName, Email, PhoneNumber, Region, HireDate, Status)
VALUES 
('Alice', 'Walker', 'alice.walker@example.com', '1234567890', 'East', '2022-01-10', 'Active'),
('Bob', 'Johnson', 'bob.johnson@example.com', '9876543210', 'West', '2021-05-15', 'Inactive');

-- This user will cause deletion failure
INSERT INTO SalesRepresentatives (FirstName, LastName, Email, PhoneNumber, Region, HireDate, Status)
VALUES ('Carol', 'Bennett', 'carol.bennett@example.com', '5551112222', 'South', '2020-09-01', 'Active');

-- Use Carol's ID (grab last identity)
DECLARE @CarolId INT = SCOPE_IDENTITY();

INSERT INTO Sales (SalesRepId, Amount, SaleDate)
VALUES 
(@CarolId, 1500.00, '2023-12-01'),
(@CarolId, 1750.00, '2024-03-10');