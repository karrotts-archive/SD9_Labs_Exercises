USE Northwind;
-- 1. List the number of orders by each customer who lives in the United States using a CTE. Sort from highest to lowest.
	WITH NumberOfOrdersCTE AS
	(
		SELECT O.CustomerID, SUM(orderid) AS TotalOrders FROM Orders AS O
		JOIN Customers AS C
		ON C.CustomerID = O.CustomerID
		WHERE C.Country LIKE 'USA'
		GROUP BY O.CustomerID
	)
	SELECT * FROM NumberOfOrdersCTE ORDER BY TotalOrders DESC;

-- 2. List the product name and the number of each product from a German supplier sold to a customer in Germany using a CTE. Sort from highest to lowest.
	WITH ProductsFromGermany AS
	(
		SELECT ProductsFromGermany.ProductName, SUM(OD.Quantity) AS TotalSold FROM [Order Details] AS OD
		JOIN Orders AS O
		ON OD.OrderID = O.OrderID
		JOIN (
			SELECT P.ProductID, P.ProductName FROM Products AS P
			JOIN Suppliers AS S
			ON P.SupplierID = S.SupplierID
			WHERE S.Country LIKE 'Germany'
		) AS ProductsFromGermany
		ON OD.ProductID = ProductsFromGermany.ProductID
		GROUP BY ProductsFromGermany.ProductName
	)
	SELECT * FROM ProductsFromGermany ORDER BY TotalSold DESC;

-- 3. Prepare an employee report showing the name of each employee, the number of employees they supervise, and the name of their supervisor using a CTE. Sort by the number of employees supervised.
	WITH SupervisorCTE AS 
	(
		SELECT E.EmployeeID, E.FirstName, E.LastName, 
		(
			SELECT COUNT(E3.EmployeeID) FROM Employees AS E3
			WHERE E3.ReportsTo = E.EmployeeID
		) AS AmountSupervised, 
		(
			SELECT FirstName + LastName FROM Employees AS E2
			WHERE E.ReportsTo = E2.EmployeeID
		) AS NameOfSupervisor 
		FROM Employees AS E
	)
	SELECT * FROM SupervisorCTE ORDER BY AmountSupervised DESC;
-- 4. One purpose of views is to denormalize databases for the purpose of efficiency, both machine efficiency and programmer efficiency. Creating denormalized objects can turn complex queries into simple ones.

-- For example, suppose you needed a list of all employees who took orders for a specific customer, or all customers who were served by a specific employee. You can create a “table” as a view that contains distinct pairs of customers and employees. This is somewhat complex, so do this in steps:
-- 1. Create a query that returns every distinct customer/employee pair.
	SELECT DISTINCT O.EmployeeID, C.CustomerID FROM Orders AS O
	JOIN Employees AS E
	ON E.EmployeeID = O.EmployeeID
	JOIN Customers AS C
	ON C.CustomerID = O.CustomerID;

-- 2. Use that query to write another query turning the customerid, customername, and customercontact, and the employeeid, firstname, and lastname.
	SELECT C.CustomerID, C.CompanyName, C.ContactName, E.EmployeeID, E.FirstName, E.LastName FROM Orders AS O
	JOIN Employees AS E
	ON E.EmployeeID = O.EmployeeID
	JOIN Customers AS C
	ON C.CustomerID = O.CustomerID;

-- 3. Make sure you drop any view that might exist.
-- 4. Create a view based on your query.
	DROP VIEW IF EXISTS DistinctCustomers;
	GO
	CREATE VIEW DistinctCustomers
	AS
		SELECT C.CustomerID, C.CompanyName, C.ContactName, E.EmployeeID, E.FirstName, E.LastName FROM Orders AS O
		JOIN Employees AS E
		ON E.EmployeeID = O.EmployeeID
		JOIN Customers AS C
		ON C.CustomerID = O.CustomerID
	GO

-- 5. Write a report listing all customers served by employee 7, Robert King.
	SELECT * FROM DistinctCustomers WHERE EmployeeID = 7;
-- 6. Write a report listing all employees who served customer CHOPS, Chop-suey Chinese.
	SELECT * FROM DistinctCustomers WHERE CustomerID LIKE 'CHOPS';
-- 7. Drop the view.
	DROP VIEW IF EXISTS DistinctCustomers;

USE TSQLV4;
-- Use the book’s database, TSQLV4, and do the exercises 1 through 6, beginning on page 183. The solutions are in the book beginning on page 188
-- Exercise 1 : The following query attempts to filter orders that were not placed on the last day of the year. It’s supposed to return the order ID, order date, customer ID, employee ID, and respective end-of-year date
--              for each order:

--					SELECT orderid, orderdate, custid, empid,
--						DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
--					FROM Sales.Orders
--					WHERE orderdate <> endofyear;

--				When you try to run this query, you get the following error:
--					Msg 207, Level 16, State 1, Line 233
--					Invalid column name ‘endofyear'.
--				Explain what the problem is, and suggest a valid solution.

--	Solution: Table aliases cannot be listed in the WHERE statement since it does not currently exist in the context of the application.
--			  A valid solution would be do a subquery in the WHERE statement.

-- Exercise 2-1 :
	SELECT empid, MAX(orderdate) as maxorderdate FROM Sales.Orders
	GROUP BY empid;

-- Exercise 2-2 :
	SELECT O.empid, orderdate, orderid, custid FROM Sales.Orders AS O
	JOIN (
		SELECT empid, MAX(orderdate) as maxorderdate FROM Sales.Orders
		GROUP BY empid
	) AS M
	ON O.empid = M.empid AND O.orderdate = M.maxorderdate;

-- Exercise 3-1 :
	SELECT orderid, orderdate, custid, empid, 
	ROW_NUMBER() OVER (ORDER BY orderdate, orderid) AS rownum 
	FROM Sales.Orders
	ORDER BY orderdate, orderid;

-- Exercise 3-2 :
	WITH OrdersCTE AS
	(
		SELECT orderid, orderdate, custid, empid, 
		ROW_NUMBER() OVER (ORDER BY orderdate, orderid) AS rownum 
		FROM Sales.Orders
	)
	SELECT * FROM OrdersCTE WHERE rownum BETWEEN 11 AND 20;

-- Exercise 4 :
	WITH EmpsCTE AS
	(
		-- This gets the information for the employee with empid = 9
		SELECT empid, mgrid, firstname, lastname
		FROM HR.Employees
		WHERE empid = 9
		
		UNION ALL -- Combines the two tables and allows duplicates
		
		-- Calls this recursivly and looks for the management grid that is equal to the one below it.
		SELECT P.empid, P.mgrid, P.firstname, P.lastname
		FROM EmpsCTE AS C
			INNER JOIN HR.Employees AS P
				ON C.mgrid = P.empid
	)
	SELECT empid, mgrid, firstname, lastname
	FROM EmpsCTE;

-- Exercise 5-1 :
	DROP VIEW IF EXISTS Sales.VEmpOrders;
	GO
	CREATE VIEW Sales.VEmpOrders
	AS
		SELECT empid, YEAR(orderdate) AS orderyear, SUM(OD.qty) AS qty  FROM Sales.OrderDetails AS OD
		JOIN Sales.Orders AS O
		ON O.orderid = OD.orderid
		GROUP BY empid, YEAR(orderdate);
	GO
	SELECT * FROM Sales.VEmpOrders ORDER BY empid, orderyear;

-- Exercise 5-2 :
	SELECT empid, orderyear, qty, 
	(
		SELECT SUM(qty) FROM Sales.VEmpOrders AS EO2
		WHERE EO.empid = EO2.empid
		AND EO2.orderyear <= EO.orderyear
	) 
	AS runqty FROM Sales.VEmpOrders AS EO
	ORDER BY empid, orderyear;

-- Exercise 6-1 :
	DROP FUNCTION IF EXISTS Production.TopProducts;
	GO
	CREATE FUNCTION Production.TopProducts
		(@supid AS INT, @n AS INT)
		RETURNS TABLE
	AS
	RETURN
		SELECT TOP (@n) productid, productname, unitprice
		FROM Production.Products
		WHERE supplierid = @supid
		ORDER BY unitprice DESC;
	GO

-- Exercise 6-2 :
SELECT S.supplierid, S.companyname, P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
	CROSS APPLY Production.TopProducts(S.supplierid, 2) AS P;
