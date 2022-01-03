-- 6. A "Single Item Order" is a customer order where only one item is ordered. Show the SalesOrderID and the UnitPrice for every Single Item Order.
SELECT SalesOrderID, MAX(UnitPrice) as UnitPrice
FROM SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(SalesOrderID) = 1;

-- 7. Where did the racing socks go? List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.
SELECT p.Name, cu.CompanyName, sod.OrderQty
FROM Product p JOIN SalesOrderDetail sod ON p.ProductID = sod.ProductID
  JOIN SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
  JOIN Customer cu ON soh.CustomerID = cu.CustomerID
WHERE p.ProductModelID = 
  (SELECT ProductModelID
  FROM ProductModel
  WHERE Name = 'Racing Socks');
  
-- 8.Show the product description for culture 'fr' for product with ProductID 736.  
SELECT p.ProductID, pmpd.Culture, pd.Description
FROM ProductDescription pd JOIN ProductModelProductDescription pmpd ON pd.ProductDescriptionID = pmpd.ProductDescriptionID
  JOIN ProductModel pm ON pmpd.ProductModelID = pm.ProductModelID
  JOIN Product p ON pm.ProductModelID = p.ProductModelID
WHERE pmpd.Culture = 'fr' AND p.ProductID = 736;

-- 9.Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest. For each order show the CompanyName and the SubTotal and the total weight of the order.
SELECT soh.SubTotal, cu.CompanyName, SUM(sod.OrderQty * p.weight)
FROM Product p JOIN SalesOrderDetail sod ON p.ProductID = sod.ProductID 
    JOIN SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Customer cu ON soh.CustomerID = cu.CustomerID
GROUP BY
  soh.SalesOrderID, soh.SubTotal, cu.CompanyName
ORDER BY
  soh.SubTotal DESC;
  
-- 10.How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?
SELECT SUM(sod.OrderQTy) total_product
FROM ProductCategory pc JOIN Product p ON pc.ProductCategoryID = p.ProductCategoryID
    JOIN SalesOrderDetail sod ON sod.ProductID = p.ProductID
    JOIN SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Address ad ON ad.AddressID = soh.BillToAddressID
WHERE pc.Name LIKE 'Cranksets' AND ad.City LIKE 'London';
    



















