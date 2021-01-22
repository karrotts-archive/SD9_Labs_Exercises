--1.  Who are our customers in North America?
SELECT ContactName FROM Customers WHERE Country IN ('USA','Mexico','Canada');

--2.  What orders were placed in April, 1998?
SELECT * FROM Orders WHERE OrderDate BETWEEN '1998-03-31' AND '1998-04-30';

--3.  What sauces do we sell?
SELECT * FROM Products 
WHERE CategoryID = (
	SELECT CategoryID FROM Categories 
	WHERE CategoryName LIKE 'Condiments'
	)  
AND ProductName LIKE '%sauce';

--4.  You sell some kind of dried fruit that I liked very much. What is its name?
SELECT * FROM Products 
WHERE CategoryID = (
	SELECT CategoryID FROM Categories 
	WHERE CategoryName LIKE 'Produce'
	)
AND ProductName LIKE '%dried%';

--5.  What employees ship products to Germany in December?
SELECT firstname, lastname FROM Employees WHERE EmployeeID IN (
	SELECT DISTINCT EmployeeID FROM  Orders
	WHERE MONTH(ShippedDate) = 12 AND ShipCountry LIKE 'Germany'
);

--6.  We have an issue with product 19. I need to know the total amount and the net amount of all orders for product 19 where the customer took a discount.
SELECT SUM(UnitPrice * Quantity) as 'Total Amount',
SUM((UnitPrice * Quantity) - (UnitPrice * Quantity) * Discount) as 'Net Amount'
FROM [Order Details] WHERE ProductID = 19 AND Discount > 0;

--7.  I need a list of employees by title, first name, and last name, with the employee’s position under their names, and a line separating each employee.
SELECT FirstName + ' ' + LastName + CHAR(10) + Title + CHAR(10) + '________________' FROM Employees;

--8.  I need a list of our customers and the first name only of the customer representative.
SELECT LEFT(ContactName, CHARINDEX(' ', ContactName)), CompanyName From Customers;

--9.  Give me a list of our customer contacts alphabetically by last name.
SELECT ContactNameFROM CustomersORDER BY REVERSE(SUBSTRING(REVERSE(ContactName), 0, CHARINDEX(' ', REVERSE(ContactName))))


--10. How many days old are you today?
SELECT DATEDIFF(DAY, '1996-08-27', GETDATE());