USE Northwind;
--What is the order number and the date of each order sold by each employee?
  SELECT e.FirstName, e.LastName, o.OrderID, o.OrderDate FROM Orders AS o
  JOIN Employees AS e
  ON o.EmployeeID = e.EmployeeID
  ORDER BY e.EmployeeID;

--List each territory by region.
  SELECT r.RegionDescription, t.TerritoryDescription
  FROM Territories as t
  JOIN Region as r
  ON t.RegionID = r.RegionID
  ORDER BY r.RegionID;


--What is the supplier name for each product alphabetically by supplier?
  SELECT s.CompanyName, p.ProductName FROM Products AS p
  JOIN Suppliers AS s
  ON p.SupplierID = s.SupplierID
  ORDER BY s.CompanyName, p.ProductName;

--For every order on May 5, 1998, how many of each item was ordered, and what was the price of the item?
  SELECT od.ProductID, od.Quantity, od.UnitPrice 
  FROM [Order Details] as od
  JOIN Orders as o 
  ON o.OrderID = od.OrderID
  WHERE o.OrderDate = '1998-5-5'
  ORDER BY ProductID;
  
--For every order on May 5, 1998, how many of each item was ordered giving the name of the item, and what was the price of the item?
  SELECT p.ProductName, p.UnitPrice, od.Quantity
  FROM [Order Details] as od
  JOIN Orders as o 
  ON o.OrderID = od.OrderID
  JOIN Products AS p
  ON od.ProductID = p.ProductID
  WHERE o.OrderDate = '1998-5-5'
  ORDER BY od.ProductID;

--For every order in May, 1998, what was the customer’s name and the shipper’s name?
  SELECT c.CompanyName, s.CompanyName FROM Orders AS o
  JOIN Customers AS c
  ON o.CustomerID = c.CustomerID
  JOIN Shippers AS s
  ON o.ShipVia = s.ShipperID
  WHERE MONTH(o.OrderDate) = 5 AND YEAR(o.OrderDate) = 1998;

--What is the customer’s name and the employee’s name for every order shipped to France?
  SELECT * FROM Orders;
  SELECT c.CompanyName, (e.FirstName + ' ' + e.LastName) AS EmployeeName
  FROM Orders AS o
  JOIN Customers AS c
  ON o.CustomerID = c.CustomerID
  JOIN Employees AS e
  ON o.EmployeeID = e.EmployeeID
  WHERE o.ShipCountry LIKE '%France%';

--List the products by name that were shipped to Germany.
  SELECT DISTINCT p.ProductName, o.ShipCountry
  FROM [Order Details] as od
  JOIN Orders as o 
  ON o.OrderID = od.OrderID
  JOIN Products AS p
  ON od.ProductID = p.ProductID
  WHERE o.ShipCountry LIKE '%Germany%';

