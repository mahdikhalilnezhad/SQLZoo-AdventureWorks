-- 1. Show the first name and the email address of customer with CompanyName 'Bike World'
SELECT FirstName, EmailAddress
FROM Customer
WHERE CompanyName LIKE 'Bike World';

-- 2.Show the CompanyName for all customers with an address in City 'Dallas'.
SELECT c.FirstName, c.LastName, c.CompanyName
FROM Customer AS c 
JOIN CustomerAddress AS ca ON c.CustomerID = ca.CustomerID
JOIN Address as a ON ca.AddressID = a.AddressID
WHERE City LIKE 'Dallas';

-- 3.How many items with ListPrice more than $1000 have been sold?
SELECT COUNT(*) AS Total
FROM SalesOrderDetail
JOIN Product ON SalesOrderDetail.ProductID = Product.ProductID
WHERE Product.ListPrice > 1000;

-- 4.Give the CompanyName of those customers with orders over $100000. Include the subtotal plus tax plus freight.
SELECT Customer.CompanyName,
       SalesOrderHeader.SubTotal,
       SalesOrderHeader.TaxAmt,
       SalesOrderHeader.Freight
FROM Customer 
JOIN SalesOrderHeader ON Customer.CustomerID = SalesOrderHeader.CustomerID
WHERE SalesOrderHeader.SubTotal + SalesOrderHeader.TaxAmt + SalesOrderHeader.Freight > 100000;

-- 5.Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'
SELECT SalesOrderDetail.OrderQty
FROM Product JOIN SalesOrderDetail ON Product.ProductID = SalesOrderDetail.ProductID
JOIN SalesOrderHeader ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID
WHERE Product.Name = 'Racing Socks, L' AND Customer.CompanyName = 'Riding Cycles';
