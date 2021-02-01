-- Exercise 5
-- To check the validity of the data, write a query against the HR.Employees table that returns employees
-- with a last name that starts with a lowercase English letter in the range a through z. 
-- Remember that the collation of the sample database is case insensitive (Latin1_General_CI_AS):

SELECT empid, lastname FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS
LIKE N'[abcdefghijklmnopqrstuvwxyz]%';

-- Exercise 6
-- Explain the difference between the following two queries:
-- Query 1
SELECT empid, COUNT(*) AS numorders -- selects employeeid and the combined number of orders for each employee
FROM Sales.Orders
WHERE orderdate < '20160501' -- where the order was placed before 2016-05-01
GROUP BY empid;

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501'; -- Max(orderdate) would get the newest order placed before 2016-05-01
                                    -- This would not return any orders placed after 2016-05-01

-- Query 1 will return all the employees and where they had any sales before 2016-05-01
-- Query 2 returns only when the last sale was conducted before 2016-05-01
