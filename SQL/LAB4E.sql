USE Northwind;
-- 1. Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly’s Homestead, and Tokyo Traders.
	SELECT ProductName, SupplierID FROM Products AS P
	WHERE SupplierID IN
	(
		SELECT SupplierID FROM Suppliers
		WHERE CompanyName LIKE 'Exotic%'
			OR CompanyName LIKE 'grandma kelly%'
			OR CompanyName LIKE 'tokyo%'
	);

-- 2. Create a report that shows all products by name that are in the Seafood category.
	SELECT ProductName FROM Products AS P
	WHERE CategoryID IN
	(
		SELECT CategoryID FROM Categories
		WHERE CategoryName LIKE 'seafood%'
	);

-- 3. Create a report that shows all companies by name that sell products in CategoryID 8.
	SELECT S.CompanyName FROM Suppliers AS S
	WHERE SupplierID IN 
	(
		SELECT SupplierID FROM Products
		WHERE CategoryID = 8
	);

-- 4. Create a report that shows all companies by name that sell products in the Seafood category.
	SELECT S.CompanyName FROM Suppliers AS S
	WHERE SupplierID IN 
	(
		SELECT SupplierID FROM Products
		WHERE CategoryID IN 
		(
			SELECT CategoryID FROM Categories
			WHERE CategoryName LIKE 'seafood%'
		)
	);

-- 5. Create a report that lists the ten most expensive products.
	SELECT TOP 10 * FROM Products
	ORDER BY UnitPrice DESC;

-- 6. Create a report that shows the date of the last order by all employees.
	SELECT * FROM
	(
		SELECT EmployeeID, MAX(OrderDate) AS OrderDate FROM Orders
		GROUP BY EmployeeID
	) AS TopDate
	ORDER BY TopDate.EmployeeID;

USE TSQLV4;
-- Use the book’s database, TSQLV4, and do the exercises 1 through 10, beginning on page 150. The solutions are in the book beginning on page 154.
-- Exercise 1 : Write a query that returns all orders placed on the last day of activity that can be found in the Orders
	SELECT orderid, orderdate, custid, empid FROM Sales.Orders
	WHERE orderdate = (SELECT MAX(orderdate) FROM Sales.Orders);

-- Exercise 2 : Write a query that returns all orders placed by the customer(s) who placed the highest number of orders
	SELECT custid, orderid, orderdate, empid FROM Sales.Orders
	WHERE custid IN 
	(
		SELECT TOP(1) WITH TIES custid FROM Sales.Orders -- WITH TIES allows items to be returned when they are tied with something else
														 -- For example 2 racers can finish at the same time, that is considered a tie
		GROUP BY custid
		ORDER BY COUNT(*) DESC
	);

-- Exercise 3 : Write a query that returns employees who did not place orders on or after May 1, 2016:
	SELECT empid, firstname, lastname FROM HR.Employees
	WHERE empid IN 
	(
		SELECT empid FROM Sales.Orders
		GROUP BY empid
		HAVING MAX(orderdate) < '2016-05-01'
	);

-- Exercise 4 : Write a query that returns countries where there are customers but not employees
	SELECT DISTINCT country FROM Sales.Customers
	WHERE country NOT IN
	(
		SELECT country FROM HR.Employees
	);

-- Exercise 5 : Write a query that returns for each customer all orders placed on the customer’s last day of activity
	SELECT custid, orderid, orderdate, empid FROM Sales.Orders AS O
	WHERE orderdate =
	(
		SELECT MAX(orderdate) FROM Sales.Orders AS O2
		WHERE O.custid = O2.custid
	)
	ORDER BY custid;

-- Exercise 6 : Write a query that returns customers who placed orders in 2015 but not in 2016
	SELECT custid, companyname FROM Sales.Customers
	WHERE custid IN 
	(
		SELECT custid FROM Sales.Orders
		GROUP BY custid
		HAVING YEAR(MAX(orderdate)) = '2015'
	);

-- Exercise 7 : Write a query that returns customers who ordered product 12
	SELECT custid, companyname FROM Sales.Customers
	WHERE custid IN
	(
		SELECT custid FROM Sales.Orders 
		WHERE orderid IN 
		(
			SELECT orderid FROM Sales.OrderDetails 
			WHERE productid = 12
		)
	);

-- Exercise 8 : Write a query that calculates a running-total quantity for each customer and month
	SELECT custid, ordermonth, qty,
	(
		SELECT SUM(CO2.qty) FROM Sales.CustOrders AS CO2
		WHERE CO.custid = CO2.custid
		AND CO2.ordermonth <= CO.ordermonth
	) AS runqty 
	FROM Sales.CustOrders AS CO
	ORDER BY custid;
-- Exercise 9 : Explain the difference between IN and EXISTS
-- The difference between the two are the amount of values returned. Exists returns a boolean true/false while IN can be true false or null.

-- Exercise 10 : Write a query that returns for each order the number of days that passed since the same customer’s
--				 previous order. To determine recency among orders, use orderdate as the primary sort element and
--				 orderid as the tiebreaker
	SELECT custid, orderdate, orderid,
	(
		SELECT TOP(1) o2.orderdate FROM Sales.Orders AS O2
		WHERE O2.custid = O.custid
		AND (O2.orderdate = O.orderdate AND O2.orderid < O.orderid
			 OR O2.orderdate < O.orderdate)
		ORDER BY O2.orderdate DESC, O2.orderid DESC
	) AS prevdate
	FROM Sales.Orders AS O
	ORDER BY custid, orderdate, orderid;
