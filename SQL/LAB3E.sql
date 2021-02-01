-- 1. Create a line item report that contains a line for each product in the order with the following columns: the order id, the product id, the unit price, the quantity sold, the line item price, and the percent of that line item constitutes of the total amount of the order.
-- 
-- Here is a sample of the output, limited to 25 records:
-- 
-- OrderID|ProductID|UnitPrice|Quantity|LineTotal|PctOfTotalOrder
-- 10248|11|14.0|12|168.0|38.18
-- 10248|42|9.8|10|98.0|22.27
-- 10248|72|34.8|5|174.0|39.55
-- 10249|14|18.6|9|167.4|8.98
-- 10249|51|42.4|40|1696.0|91.02
-- 10250|41|7.7|10|77.0|4.25
-- 10250|51|42.4|35|1484.0|81.85
-- 10250|65|16.8|15|252.0|13.9
-- 10251|22|16.8|6|100.8|15.03
-- 10251|57|15.6|15|234.0|34.88
-- 10251|65|16.8|20|336.0|50.09
-- 10252|20|64.8|40|2592.0|69.49
-- 10252|33|2.0|25|50.0|1.34
-- 10252|60|27.2|40|1088.0|29.17
-- 10253|31|10.0|20|200.0|13.84
-- 10253|39|14.4|42|604.8|41.86
-- 10253|49|16.0|40|640.0|44.3
-- 10254|24|3.6|15|54.0|8.64
-- 10254|55|19.2|21|403.2|64.49
-- 10254|74|8.0|21|168.0|26.87
-- 10255|2|15.2|20|304.0|12.21
-- 10255|16|13.9|35|486.5|19.53
-- 10255|36|15.2|25|380.0|15.26
-- 10255|59|44.0|30|1320.0|53.0
-- 10256|53|26.2|15|393.0|75.9 

SELECT
OD.OrderID, 
OD.ProductID, 
OD.UnitPrice, 
OD.Quantity, 
(OD.UnitPrice * OD.Quantity) AS LineTotal,
(OD.UnitPrice * OD.Quantity) / i.LineTotal * 100 AS PctOfTotalOrder
FROM [Order Details] AS OD
JOIN (
SELECT OrderID, SUM(UnitPrice * Quantity) AS LineTotal
FROM [Order Details] GROUP BY OrderID
) AS i
ON OD.OrderID = i.OrderID

-- 2. Write three queries, using inner and outer joins. Report the results of the queries. There is no need for any further reporting.
-- 
-- I want to know the unique (distinct) cities, regions, and postal codes:
-- 
--     (a) where we have both customers and employees,
-- 
--     (b) where we have customers but no employees AND both customers and employees,
-- 
--     (c) where we have employees but no customers AND both customers and employees.

-- SELECT * FROM Customers;
-- SELECT * FROM Employees;

SELECT DISTINCT c.City, c.PostalCode, e.Region FROM Customers AS c
INNER JOIN Employees AS e
ON c.City = e.City OR c.PostalCode = e.PostalCode OR c.Region = e.Region;

SELECT DISTINCT c.City, c.PostalCode, e.Region FROM Customers AS c
LEFT OUTER JOIN Employees AS e
ON c.City = e.City OR c.PostalCode = e.PostalCode OR c.Region = e.Region;

SELECT DISTINCT c.City, c.PostalCode, e.Region FROM Customers AS c
RIGHT OUTER JOIN Employees AS e
ON c.City = e.City OR c.PostalCode = e.PostalCode OR c.Region = e.Region;

-- 3. Using subqueries, create a report that lists the ten most expensive products.
SELECT * FROM (SELECT TOP 10 * FROM Products ORDER BY UnitPrice DESC) AS Products;

-- 4. Using subqueries, create a report that shows the date of the last order by all employees.
SELECT o.EmployeeID,
(SELECT e.firstName from Employees AS e WHERE e.EmployeeID = o.EmployeeID) AS EmployeeName,
MAX(OrderDate) AS MaxDate
FROM Orders AS o
GROUP BY o.EmployeeID;

-- 5. Using subqueries, create a line item report that contains a line for each product in the order with the following columns: 
-- the order id, the product id, the unit price, the quantity sold, the line item price, and the percent of that line item constitutes of the total amount of the order.

SELECT
OD.OrderID, 
OD.ProductID, 
OD.UnitPrice, 
OD.Quantity, 
(OD.UnitPrice * OD.Quantity) AS LineTotal,
(OD.UnitPrice * OD.Quantity) / i.LineTotal * 100 AS PctOfTotalOrder
FROM [Order Details] AS OD
JOIN (
SELECT OrderID, SUM(UnitPrice * Quantity) AS LineTotal
FROM [Order Details] GROUP BY OrderID
) AS i
ON OD.OrderID = i.OrderID
