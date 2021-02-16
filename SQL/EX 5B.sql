USE TSQLV4;

-- Exercise 1. Explain the difference between the UNION ALL and UNION operators. In what cases are the two
--			   equivalent? When they are equivalent, which one should you use?

--	Answer:    UNION eliminates all duplicate values from the result while UNION ALL allow for duplicate values to be in the results.
--			   They can have the same results when there is no duplicates in the result. UNION ALL is faster than just UNION when results are the same.

-- Exercise 2. Write a query that generates a virtual auxiliary table of 10 numbers in the range 1 through 10 without
--			   using a looping construct.
				
				SELECT 1 AS n
				UNION ALL SELECT 2
				UNION ALL SELECT 3
				UNION ALL SELECT 4
				UNION ALL SELECT 5
				UNION ALL SELECT 6
				UNION ALL SELECT 7
				UNION ALL SELECT 8
				UNION ALL SELECT 9
				UNION ALL SELECT 10;

				-- You have to manually UNION ALL each of the inputs to do this without a loop.

-- Exercise 3. Write a query that returns customer and employee pairs that had order activity in January 2016 but not
--			   in February 2016:
				
				SELECT custid, empid
				FROM Sales.Orders
				WHERE orderdate >= '20160101' AND orderdate < '20160201'

				EXCEPT -- This removes the second query results from the first query results so it eliminates all pairs where there is an order in february

				SELECT custid, empid
				FROM Sales.Orders
				WHERE orderdate >= '20160201' AND orderdate < '20160301';

-- Exercise 4. Write a query that returns customer and employee pairs that had order activity in both January 2016
--			   and February 2016
			   
			   SELECT custid, empid
			   FROM Sales.Orders
			   WHERE orderdate >= '20160101' AND orderdate < '20160201'

			   INTERSECT -- This acts like an AND operator, and join them where both sides are the same.

			   SELECT custid, empid
			   FROM Sales.Orders
			   WHERE orderdate >= '20160201' AND orderdate < '20160301';

-- Exercise 5. Write a query that returns customer and employee pairs that had order activity in both January 2016
--			   and February 2016 but not in 2015:
				
				SELECT custid, empid
				FROM Sales.Orders
				WHERE orderdate >= '20160101' AND orderdate < '20160201'

				INTERSECT

				SELECT custid, empid
				FROM Sales.Orders
				WHERE orderdate >= '20160201' AND orderdate < '20160301'

				EXCEPT

				SELECT custid, empid
				FROM Sales.Orders
				WHERE orderdate >= '20150101' AND orderdate < '20160101';

				-- (side1 && side2) && NOT side3

-- Exercise 6. You are given the following query:
--             SELECT country, region, city
--             FROM HR.Employees
--             UNION ALL
--             SELECT country, region, city
--             FROM Production.Suppliers;

--             You are asked to add logic to the query so that it guarantees that the rows from Employees are
--             returned in the output before the rows from Suppliers. Also, within each segment, the rows should be
--             sorted by country, region, and city

			
			SELECT country, region, city
			FROM (
				SELECT 1 AS sortcol, country, region, city
				FROM HR.Employees

				UNION ALL

				SELECT 2, country, region, city
				FROM Production.Suppliers
			) AS D
			ORDER BY sortcol, country, region, city;

			-- We do an subquery with a union all inside that unions the two tables by an identifier
			-- Then we can sort based on that identifier