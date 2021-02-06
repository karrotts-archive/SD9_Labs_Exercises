--1. Use a derived table to build a query that returns the number of distinct products per year that each customer ordered. 
--   Use internal aliasing. 
--   Use a variable to set the customer number. 
--   For example, if the customer ID is 1234, the query should report the number of distinct products ordered by customer 1234 for the years 2014, 2015, and 2016.
DECLARE @CUSTNUM int;
SET @CUSTNUM = 2;

	 SELECT mytable.custid, mytable.OrderYear, SUM(mytable.totalAmount) AS TotalDistinct
	 FROM (
		SELECT DISTINCT P.productid, c.custid, COUNT(YEAR(o.orderdate)) AS totalAmount, YEAR(o.orderdate) AS OrderYear FROM Sales.OrderDetails AS OD
		JOIN Sales.Orders AS O
		ON OD.orderid = O.orderid
		JOIN Production.Products AS P
		ON OD.productid = P.productid
		JOIN Sales.Customers AS C
		ON O.custid = C.custid
		GROUP BY c.custid, P.productid, o.orderdate
	  ) AS mytable
	  WHERE mytable.custid = @CUSTNUM
	  GROUP BY mytable.custid, mytable.OrderYear
	  ORDER BY mytable.custid;

--2. Use multiple common table expressions to build a query that returns the number of distinct products per year that each country's customers ordered. 
--   Use external aliasing. Use a variable to set the country name. 
--   For example, if the country name is "France", the query should report the number of distinct products ordered by French customers for the years 2014, 2015, and 2016.
--
	DECLARE @country AS NVARCHAR(50) = 'France';
	WITH MyTable AS
	(
		SELECT DISTINCT P.productid, c.custid, COUNT(YEAR(o.orderdate)) AS totalAmount, YEAR(o.orderdate) AS OrderYear FROM Sales.OrderDetails AS OD
		JOIN Sales.Orders AS O
		ON OD.orderid = O.orderid
		JOIN Production.Products AS P
		ON OD.productid = P.productid
		JOIN Sales.Customers AS C
		ON O.custid = C.custid
		WHERE c.country LIKE @country
		GROUP BY c.custid, P.productid, o.orderdate
	)
	SELECT custid, OrderYear, SUM(totalAmount) AS TotalDistinct FROM MyTable
	GROUP BY mytable.custid, mytable.OrderYear
	ORDER BY mytable.custid;

--3. Create a view that shows:
--   for each year, the total dollar amount spent by customers in each country for all the years in the database.
	DROP VIEW IF EXISTS Sales.TotalSpent;
	GO
		CREATE VIEW Sales.TotalSpent
	AS
		SELECT C.country, SUM(OD.qty * OD.unitprice) AS TotalSpent FROM Sales.OrderDetails AS OD
		JOIN Sales.Orders AS O
		ON OD.orderid = O.orderid
		JOIN Sales.Customers AS C
		ON O.custid = C.custid
		GROUP BY C.country;
	GO

--4. Create an inline table valued function that:
--   accepts as a parameter a country name and returns a table with the distinct products ordered by customers from that country. 
--   Products are to be identified by both product ID and product name.
	DROP FUNCTION IF EXISTS dbo.GetDistinctProducts;
	GO
		CREATE FUNCTION dbo.GetDistinctProducts
		(@country AS NVARCHAR(50)) RETURNS TABLE
	AS
	RETURN
		SELECT DISTINCT P.productid, P.productname FROM Sales.OrderDetails AS OD
		JOIN Sales.Orders AS O
		ON OD.orderid = O.orderid
		JOIN Production.Products AS P
		ON OD.productid = P.productid
		JOIN Sales.Customers AS C
		ON O.custid = C.custid
		WHERE c.country LIKE @country
		GROUP BY P.productid, P.productname
	GO

	SELECT * FROM dbo.GetDistinctProducts('France');

--5. Use the CROSS APPLY operator to create a query showing the top three products shipped to customers in each country. 
--   Your report should contain the name of the country, the product id, the product name, and the number of products shipped to customers in that country.
SELECT T.country, P.productid, P.productname, COUNT(P.productid) AS Total FROM Production.Products AS P
CROSS APPLY
		(SELECT O.orderid, OD.qty AS TotalBought, OD.productid, C.country FROM Sales.OrderDetails AS OD
		JOIN Sales.Orders AS O
		ON OD.orderid = O.orderid
		JOIN Production.Products AS P
		ON OD.productid = P.productid
		JOIN Sales.Customers AS C
		ON O.custid = C.custid
		GROUP BY OD.productid, O.orderid, OD.qty, C.country) AS T
GROUP BY T.country, P.productid, P.productname;