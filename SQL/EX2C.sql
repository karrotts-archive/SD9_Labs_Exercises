USE TSQLV4;

-- Exercise 3
-- Write a query against the HR.Employees table that returns employees with a last name containing the
-- letter e twice or more:

SELECT e.empid, e.firstname, e.lastname
FROM HR.Employees AS e
WHERE LEN(e.lastname) - LEN(REPLACE(e.lastname, 'e', '')) >= 2;

-- LEN(e.lastname) - LEN(REPLACE(e.lastname, 'e', ''))
-- LEN(e.lastname) gets the length of the full last name 'Miller' -> 6
-- REPLACE(e.lastname, 'e', '') replaces all the 'e's in the last name with ''
-- LEN(REPLACE(e.lastname, 'e', '')) -> checks the new length without any e's 'Millr' -> 5
-- 6 - 5 = 1 -> Only one 'e' in the query

-- Exercise 4
-- Write a query against the Sales.OrderDetails table that returns orders with a total value (quantity *
-- unitprice) greater than 10,000, sorted by total value:
SELECT orderid, SUM(qty*unitprice) AS totalValue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty*unitprice) > 10000;


