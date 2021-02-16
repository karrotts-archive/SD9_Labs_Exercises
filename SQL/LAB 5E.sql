USE TSQLV4;

DROP TABLE IF EXISTS dbo.Orders;
CREATE TABLE dbo.Orders
(
orderid INT NOT NULL,
orderdate DATE NOT NULL,
empid INT NOT NULL,
custid VARCHAR(5) NOT NULL,
qty INT NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
INSERT INTO dbo.Orders(orderid, orderdate, empid, custid, qty)
VALUES
(30001, '20140802', 3, 'A', 10),
(10001, '20141224', 2, 'A', 12),
(10005, '20141224', 1, 'B', 20),
(40001, '20150109', 2, 'A', 40),
(10006, '20150118', 1, 'C', 14),
(20001, '20150212', 2, 'B', 12),
(40005, '20160212', 3, 'A', 10),
(20002, '20160216', 1, 'C', 20),
(30003, '20160418', 2, 'B', 15),
(30004, '20140418', 3, 'C', 22),
(30007, '20160907', 3, 'D', 30);
SELECT * FROM dbo.Orders;

------------------------------------------------------------------------

-- Exercise 1. Write a query against the dbo.Orders table that computes both a rank and a dense rank for each
--			   customer order, partitioned by custid and ordered by qty
--
			   SELECT custid, orderid, qty,
				RANK() OVER(PARTITION BY custid ORDER BY qty) AS rnk, -- Computes the rank over order quantity
				DENSE_RANK() OVER(PARTITION BY custid ORDER BY qty) AS drnk -- computes the dense rank over order quantity
			   FROM dbo.Orders;

-- Exercise 2. Earlier in the chapter in the section “Ranking window functions,” I provided the following query against
--             the Sales.OrderValues view to return distinct values and their associated row numbers:
--
--             SELECT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum
--             FROM Sales.OrderValues
--             GROUP BY val;
--
--             Can you think of an alternative way to achieve the same task?
-- 

				WITH GetRows AS
				(
					SELECT DISTINCT val
					FROM Sales.OrderValues
				)
				SELECT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum
				FROM GetRows;

-- Exercise 3. Write a query against the dbo.Orders table that computes for each customer order both the difference
--             between the current order quantity and the customer’s previous order quantity and the difference between the current order 
--             quantity and the customer’s next order quantity:
--
				SELECT custid, orderid, qty,
				qty - LAG(qty) OVER(PARTITION BY custid
								ORDER BY orderdate, orderid) AS diffprev,
				qty - LEAD(qty) OVER(PARTITION BY custid
								ORDER BY orderdate, orderid) AS diffnext
				FROM dbo.Orders;

-- Exercise 4. Write a query against the dbo.Orders table that returns a row for each employee, a column for each
--             order year, and the count of orders for each employee and order year:
--
			SELECT empid,
				COUNT(CASE WHEN orderyear = 2014 THEN orderyear END) AS cnt2014,
				COUNT(CASE WHEN orderyear = 2015 THEN orderyear END) AS cnt2015,
				COUNT(CASE WHEN orderyear = 2016 THEN orderyear END) AS cnt2016
			FROM (SELECT empid, YEAR(orderdate) AS orderyear
				FROM dbo.Orders) AS D
			GROUP BY empid;

-- Exercise 5. Run the following code to create and populate the EmpYearOrders table:

			   DROP TABLE IF EXISTS dbo.EmpYearOrders;
			   CREATE TABLE dbo.EmpYearOrders
			   (
				empid INT NOT NULL
					CONSTRAINT PK_EmpYearOrders PRIMARY KEY,
				cnt2014 INT NULL,
				cnt2015 INT NULL,
				cnt2016 INT NULL
			   );

			   INSERT INTO dbo.EmpYearOrders(empid, cnt2014, cnt2015, cnt2016)
				SELECT empid, [2014] AS cnt2014, [2015] AS cnt2015, [2016] AS cnt2016
				FROM (SELECT empid, YEAR(orderdate) AS orderyear
					FROM dbo.Orders) AS D
				PIVOT(COUNT(orderyear)
					FOR orderyear IN([2014], [2015], [2016])) AS P;

			   SELECT * FROM dbo.EmpYearOrders;

--             Here’s the output for the query:
--             empid cnt2014 cnt2015 cnt2016
--             ----------- ----------- ----------- -----------
--             1 1 1 1
--             2 1 2 1
--             3 2 0 2
--             Write a query against the EmpYearOrders table that unpivots the data, returning a row for each
--             employee and order year with the number of orders. Exclude rows in which the number of orders is 0
--             (in this example, employee 3 in the year 2015).
--
				SELECT empid, orderyear, numorders
				FROM dbo.EmpYearOrders
				CROSS APPLY (VALUES(2014, cnt2014),
					(2015, cnt2015),
					(2016, cnt2016)) AS A(orderyear, numorders)
				WHERE numorders <> 0;

-- Exercise 6. Write a query against the dbo.Orders table that returns the total quantities for each of the following:
--			   (employee, customer, and order year), (employee and order year), and (customer and order year).
--			   Include a result column in the output that uniquely identifies the grouping set with which the current
--			   row is associated:
--
			    SELECT
			    GROUPING_ID(empid, custid, YEAR(Orderdate)) AS groupingset,
			    	empid, custid, YEAR(Orderdate) AS orderyear, SUM(qty) AS sumqty
			    FROM dbo.Orders
			    GROUP BY
			    GROUPING SETS
			    (
			    	(empid, custid, YEAR(orderdate)),
			    	(empid, YEAR(orderdate)),
			    	(custid, YEAR(orderdate))
			    );

