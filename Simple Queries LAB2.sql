USE Northwind;

/*1
SELECT EmployeeID, LastName +' ' + FirstName as EmployeeName, HomePhone, (YEAR(GETDATE()) - YEAR(BirthDate)) as Age
FROM Employees
*/

/*
SELECT *
FROM Employees
WHERE YEAR(BirthDate)<=1960
*/

/*
SELECT *
FROM Products
WHERE QuantityPerUnit like '%boxes'
*/

/*
SELECT * FROM Products 
WHERE UnitPrice > 10 AND UnitPrice < 15
*/

/*5
SELECT * FROM Orders
WHERE MONTH(OrderDate) = 9 AND YEAR(OrderDate) = 1996
*/

/*
SELECT ProductID, ProductName, UnitPrice, UnitsInStock, UnitsInStock*UnitPrice as TotalAccount
FROM Products
*/

/*
SELECT Top(5) * FROM Customers
WHERE City like 'M%'
*/

/*
SELECT Top(2) EmployeeID, LastName + ' ' + FirstName as EmployeeName, 
(YEAR(GETDATE()) - YEAR(BirthDate)) as Age  
FROM Employees
ORDER BY Age DESC
*/

/*
SELECT ProductID, ProductName, UnitPrice
FROM Products 
WHERE ProductID IN (
	SELECT ProductID FROM [Order Details]
	)
*/

/* 10
SELECT * FROM Customers
WHERE CustomerID NOT IN (
	SELECT CustomerID FROM Orders
	)
*/

/*
SELECT * FROM Customers
WHERE CustomerID NOT IN (
	SELECT CustomerID FROM Orders
	WHERE MONTH(OrderDate) = 7 AND YEAR(OrderDate) = 1997
	)
*/


--SELECT * FROM Customers
--WHERE CustomerID IN (
--	Select Top(15) CustomerID FROM Orders
--	WHERE MONTH(OrderDate) = 7 AND YEAR(OrderDate) = 1997
--	ORDER BY DAY(OrderDate) 
--	)


--SELECT p.ProductName, c.CategoryName, p.UnitPrice
--FROM Products p
--INNER JOIN Categories c ON p.CategoryID = c.CategoryID

--SELECT City FROM Customers
--UNION
--SELECT City FROM Employees

----15
--SELECT Country FROM Customers
--UNION
--SELECT Country FROM Employees

----16
--SELECT CONVERT(nvarchar, CustomerID) as CodeID, CompanyName as Name, Address, Phone FROM Customers
--UNION
--SELECT CONVERT(nvarchar, EmployeeID) as CodeID, 
--LastName + ' ' + FirstName as Name, 
--Address, HomePhone as Phone 
--FROM Employees