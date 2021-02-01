USE TSQLV4;

-- Exercise 1
-- Write a query against the Sales.Orders table that returns orders placed in June 2015:
SELECT o.orderid, o.orderdate, o.custid, o.empid 
FROM Sales.Orders AS o
WHERE YEAR(orderdate) = 2015 AND MONTH(orderdate) = 06;

-- Exercise 2
-- Write a query against the Sales.Orders table that returns orders placed on the last day of the month:
SELECT o.orderid, o.orderdate, o.custid, o.empid
FROM Sales.Orders AS o
WHERE o.orderdate = EOMONTH(orderdate);