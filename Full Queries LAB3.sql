----1
--SELECT LOWER(LastName + ' ' + FirstName) FROM Employees

----2
--SELECT UPPER(LastName + ' ' + FirstName) FROM Employees

----3
--SELECT * FROM Employees 
--WHERE Country = 'USA'

----4
--SELECT * FROM Customers
--WHERE Country = 'UK'

----5
--SELECT * FROM Customers
--WHERE Country = 'Mexico'

----6
--SELECT * FROM Customers
--WHERE Country = 'Sweden'

----7
--SELECT ProductID, ProductName, UnitPrice FROM Products
--WHERE UnitsInStock BETWEEN 5 AND 10

----8
--SELECT  * FROM Products
--WHERE UnitsOnOrder BETWEEN 60 AND 100;

----9
--SELECT e.EmployeeID, LastName, FirstName, City, Country, 
--COUNT(o.EmployeeID) as totalorder 
--FROM Employees e
--LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
--WHERE YEAR(OrderDate) = 1996
--GROUP BY e.EmployeeID, LastName, FirstName, City, Country

----10
--SELECT e.EmployeeID, LastName, FirstName, City, Country, 
--COUNT(o.EmployeeID) as totalorder 
--FROM Employees e
--LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
--WHERE YEAR(OrderDate) = 1998
--GROUP BY e.EmployeeID, LastName, FirstName, City, Country

----11
--SELECT e.EmployeeID, LastName, FirstName, HireDate,
--COUNT(o.EmployeeID) as totalorder 
--FROM Employees e
--LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
--WHERE OrderDate BETWEEN '1998-01-01' AND '1998-07-31'
--GROUP BY e.EmployeeID, LastName, FirstName, e.HireDate

----12
--SELECT e.EmployeeID, LastName, FirstName, City, HireDate, HomePhone,
--COUNT(o.EmployeeID) as totalorder 
--FROM Employees e
--LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
--WHERE OrderDate BETWEEN '1997-01-01' AND '1997-06-30'
--GROUP BY e.EmployeeID, LastName, FirstName, City, HireDate, HomePhone

----13
--SELECT OrderID, DAY(OrderDate) as OrderDay, MONTH(OrderDate) as OrderMonth, YEAR(OrderDate) as OrderYear, 
--Freight,

--CASE 
--WHEN Freight >= 100 THEN '10%' ELSE '5%'
--END AS tax,

--CASE
--WHEN Freight >= 100 THEN Freight*1.1 ELSE Freight*1.05 
--END AS 'Freight with tax'

--FROM Orders
--WHERE OrderDate BETWEEN '1996-8-1' AND '1996-8-5'

----14
--SELECT LastName + FirstName as 'Full name', TitleOfCourtesy,
--CASE 
--WHEN TitleOfCourtesy = 'Mr.' THEN 'Male'
--WHEN TitleOfCourtesy = 'Ms.' OR TitleOfCourtesy = 'Mrs.' THEN 'Female'
--END AS Sex
--FROM Employees
--WHERE TitleOfCourtesy IN ('Mr.','Ms.','Mrs.')


----15
--SELECT LastName + FirstName as 'Full name', TitleOfCourtesy,
--CASE 
--WHEN TitleOfCourtesy = 'Mr.' OR TitleOfCourtesy = 'Dr.' THEN 'M'
--WHEN TitleOfCourtesy = 'Ms.' OR TitleOfCourtesy = 'Mrs.' THEN 'F'
--END AS Sex
--FROM Employees
--WHERE TitleOfCourtesy IN ('Mr.','Dr.','Ms.','Mrs.')

----16
--SELECT LastName + FirstName as 'Full name', TitleOfCourtesy,
--CASE 
--WHEN TitleOfCourtesy = 'Mr.' THEN 'Male'
--WHEN TitleOfCourtesy = 'Ms.' OR TitleOfCourtesy = 'Mrs.' THEN 'Female'
--ELSE 'Unknown'
--END AS Sex
--FROM Employees

--17 to 20 almost the same requirements so skipped

--21
SELECT c.CategoryID, CategoryName,  ProductName, 
DAY(OrderDate) as day, MONTH(OrderDate) as month, YEAR(OrderDate) as year, 
Quantity*od.UnitPrice as Revenue

FROM Categories c, Products p, [Order Details] od, Orders o
WHERE c.CategoryID = p.CategoryID 
AND p.ProductID = od.ProductID
AND od.OrderID = o.OrderID
