USE Northwind;

SELECT '1. What are the regions?'
SELECT RegionDescription FROM Region;

SELECT '2. What are the cities?'
SELECT DISTINCT TerritoryDescription FROM Territories;

SELECT '3. What are the cities in the Southern region?'
SELECT TerritoryDescription FROM Territories
WHERE RegionID = (SELECT RegionID FROM Region WHERE RegionDescription LIKE 'South%');

SELECT '4. How do you run this query with the fully qualified column name?'
SELECT Territories.TerritoryDescription FROM Territories 
WHERE RegionID = (SELECT Region.RegionID FROM Region WHERE RegionDescription LIKE 'South%');

SELECT '5. How do you run this query with a table alias?'
SELECT t.TerritoryDescription FROM Territories as t
WHERE RegionID = (SELECT r.RegionID FROM Region as r WHERE RegionDescription LIKE 'South%');

SELECT '6. What is the contact name, telephone number, and city for each customer?'
SELECT Customers.ContactName, Customers.Phone, Customers.City FROM Customers;

SELECT '7. What are the products currently out of stock?'
SELECT Products.ProductName FROM Products
WHERE UnitsInStock = 0;

SELECT '8. What are the ten products currently in stock with the least amount on hand?'
SELECT TOP 10 Products.ProductName FROM Products 
WHERE UnitsInStock > 0 
ORDER BY UnitsInStock;

SELECT '9. What are the five most expensive products in stock?'
SELECT TOP 5 Products.ProductName FROM Products
WHERE UnitsInStock > 0
ORDER BY UnitPrice DESC;

SELECT '10. How many products does Northwind have? How many customers? How many suppliers?'
SELECT COUNT(*) FROM Products;
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Suppliers;
