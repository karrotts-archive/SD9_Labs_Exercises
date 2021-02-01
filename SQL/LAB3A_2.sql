--2. Explain what’s wrong in the following query, and provide a correct alternative:

-- SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
-- FROM Sales.Customers AS C
-- INNER JOIN Sales.Orders AS O
-- ON Customers.custid = Orders.custid;

-- This does not work because the FQN is incorrect in so it cant determine what to select and from where

-- Working solution
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON C.custid = O.custid;

-- 3. Return US customers, and for each customer return the total number of orders and total quantities
SELECT * FROM Sales.Orders WHERE custid = 32;
SELECT o.custid, COUNT(DISTINCT o.orderid) AS numorders, SUM(od.qty) AS quantity FROM Sales.Orders AS O
JOIN Sales.Customers AS C
ON O.custid = C.custid
JOIN Sales.OrderDetails AS OD
ON OD.orderid = O.orderid
WHERE c.country LIKE 'usa'
GROUP BY o.custid;

-- 4. Return customers and their orders, including customers who placed no orders:
SELECT c.custid, c.companyname, o.orderid, o.orderdate FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O 
ON C.custid = o.custid;

-- 5. Return customers who placed no orders
SELECT c.custid, c.companyname FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O 
ON C.custid = o.custid
WHERE o.orderid IS NULL;

-- 6. Return customers with orders placed on February 12, 2016, along with their orders
SELECT c.custid, c.companyname, o.orderid, o.orderdate FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O 
ON C.custid = o.custid
WHERE o.orderdate = '2016-2-12';

-- 7. Write a query that returns all customers in the output, but matches them with their respective orders only if they were placed on February 12, 2016
SELECT c.custid, c.companyname, o.orderid, o.orderdate FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O 
ON C.custid = O.custid AND O.orderdate = '2016-2-12';

-- 8. Explain why the following query isn’t a correct solution query for Exercise 7:
-- SELECT C.custid, C.companyname, O.orderid, O.orderdate
-- FROM Sales.Customers AS C
-- LEFT OUTER JOIN Sales.Orders AS O
-- ON O.custid = C.custid
-- WHERE O.orderdate = '20160

-- The WHERE is only pulling rows that have the date as FEB 12, 2016 or if there is a null value to beigin with. It is not showing customer ID and company names

-- 9. Return all customers, and for each return a Yes/No value depending on whether the customer places orders on February 12, 2016
SELECT DISTINCT C.custid, C.companyname,
CASE WHEN O.orderid IS NOT NULL THEN 'Yes' ELSE 'No' END AS HasOrderOn20160212
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
ON O.custid = C.custid
AND O.orderdate = '20160212';
