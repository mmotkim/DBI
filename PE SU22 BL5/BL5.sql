--2
SELECT e.employeeNumber,e.lastName,e.firstName,e.email,e.jobTitle FROM dbo.employees e
WHERE e.jobTitle='Sales Rep'
--3
SELECT e.employeeNumber,e.firstName+e.lastName AS employeeFullname,
e.jobTitle,e.officeCode,o.city AS officeCity,o.state as officeState,
o.country AS officeCountry
FROM dbo.offices o, dbo.employees e
WHERE o.officeCode =e.officeCode AND (o.country='USA' OR o.country='France')
ORDER BY o.country ASC , o.city ASC,e.employeeNumber ASC
--4
SELECT DISTINCT c.customerNumber,c.customerName,c.city,c.state,c.country
FROM 
dbo.customers c, dbo.orders o,dbo.orderdetails od,dbo.products p
WHERE c.customerNumber=o.customerNumber AND
o.orderNumber=od.orderNumber 
AND od.productCode=p.productCode 
AND p.productLine = 'Classic Cars'
AND o.orderDate BETWEEN '2004-4-1' AND '2004-5-31'
ORDER BY c.country ASC,c.customerName ASC
--5
SELECT c.customerNumber,c.customerName,c.city,c.state,c.country,COUNT(*),SUM(p.amount)
FROM dbo.payments p,dbo.customers c ,dbo.orders o
WHERE p.customerNumber=o.customerNumber AND p.customerNumber=c.customerNumber
AND c.state='CA' OR c.state='NY' AND  c.country='USA'
GROUP BY c.customerNumber,c.customerName,c.city,c.state,c.country
ORDER BY c.state ASC , c.customerName ASC

SELECT X.customerNumber,Y.customerName,Y.city,Y.state,Y.country,Y.NumberOfOrders,X.TotalPaymentAmout FROM
(SELECT c.customerNumber,SUM(p.amount)TotalPaymentAmout 
FROM dbo.customers c, dbo.payments p
WHERE c.customerNumber=p.customerNumber
GROUP BY c.customerNumber)X,
(SELECT c.customerNumber,c.customerName,c.city,c.state,c.country,COUNT(*) NumberOfOrders
FROM dbo.customers c, dbo.orders o
WHERE c.customerNumber =o.customerNumber
GROUP BY c.customerNumber,c.customerName,c.city,c.state,c.country)Y
WHERE X.customerNumber =Y.customerNumber
AND (Y.state='CA' OR Y.state='NY') AND  Y.country='USA'
ORDER BY Y.state ASC , Y.customerName ASC
--6
SELECT *FROM
(SELECT e.employeeNumber,e.lastName,e.firstName,COUNT(c.customerNumber)NumberOfCustomers
FROM dbo.employees e LEFT join dbo.customers c
on e.employeeNumber=c.salesRepEmployeeNumber where e.jobTitle='Sales Rep'
GROUP BY e.employeeNumber,e.lastName,e.firstName)X
WHERE X.NumberOfCustomers=(SELECT MAX(X.NumberOfCustomers)  FROM (SELECT e.employeeNumber,e.lastName,e.firstName,COUNT(c.customerNumber)NumberOfCustomers
FROM dbo.employees e LEFT join dbo.customers c
on e.employeeNumber=c.salesRepEmployeeNumber where e.jobTitle='Sales Rep'
GROUP BY e.employeeNumber,e.lastName,e.firstName)X)
UNION
SELECT *FROM
(SELECT e.employeeNumber,e.lastName,e.firstName,COUNT(c.customerNumber)NumberOfCustomers
FROM dbo.employees e LEFT join dbo.customers c
on e.employeeNumber=c.salesRepEmployeeNumber where e.jobTitle='Sales Rep'
GROUP BY e.employeeNumber,e.lastName,e.firstName)X
WHERE X.NumberOfCustomers=(SELECT MIN(X.NumberOfCustomers)  FROM (SELECT e.employeeNumber,e.lastName,e.firstName,COUNT(c.customerNumber)NumberOfCustomers
FROM dbo.employees e LEFT join dbo.customers c
on e.employeeNumber=c.salesRepEmployeeNumber where e.jobTitle='Sales Rep'
GROUP BY e.employeeNumber,e.lastName,e.firstName)X)


--c2
WITH r as (SELECT e.employeeNumber,e.lastName,e.firstName,COUNT(c.customerNumber) as NumberOfCustomers
FROM dbo.employees e LEFT join dbo.customers c
on e.employeeNumber=c.salesRepEmployeeNumber where e.jobTitle='Sales Rep'
GROUP BY e.employeeNumber,e.lastName,e.firstName)

select *  from r
where NumberOfCustomers = (select Max(NumberOfCustomers) from r) or NumberOfCustomers = (select min(NumberOfCustomers) from r)
--8
CREATE PROC Proc1 @customerNumber int,@NumberOfOrders int OUTPUT
AS
BEGIN
SET @NumberOfOrders=( SELECT COUNT(*)
FROM dbo.customers c, dbo.orders o
WHERE c.customerNumber =o.customerNumber AND c.customerNumber=@customerNumber
GROUP BY c.customerNumber)
END
--9
CREATE TRIGGER Tr1
ON orderdetails FOR DELETE
AS 
BEGIN
SELECT d.productCode,p.productName,d.orderNumber,o.orderDate,d.quantityOrdered,d.priceEach 
FROM deleted d, dbo.products p,dbo.orders o
WHERE d.orderNumber=o.orderNumber AND d.productCode=p.productCode 
END

--10
INSERT INTO dbo.orders
(
    orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    customerNumber
)
VALUES
(   10900,         -- orderNumber - int
    '2022-8-12', -- orderDate - date
    '2022-8-17', -- requiredDate - date
    '2022-8-16', -- shippedDate - date
    'Shipped',        -- status - varchar(15)
    450          -- customerNumber - int
    )