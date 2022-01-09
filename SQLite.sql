-- 11.For every customer with a 'Main Office' in Dallas show AddressLine1 of the 'Main Office' and AddressLine1 of the 'Shipping' address - if there is no shipping address leave it blank. Use one row per customer.
SELECT
  cu.CompanyName,
  MAX(CASE WHEN AddressType = 'Main Office' THEN AddressLine1 ELSE '' END) 'Main Office Address',
  MAX(CASE WHEN AddressType = 'Shipping' THEN AddressLine1 ELSE '' END) 'Shipping Address'
FROM
  Customer cu 
  JOIN
    CustomerAddress ca
    ON cu.CustomerID = ca.CustomerID
  JOIN
    Address a
    ON ca.AddressID = a.AddressID
WHERE
  a.City = 'Dallas'
GROUP BY
  cu.CompanyName;

-- 12. For each order show the SalesOrderID and SubTotal calculated three ways:
-- A) From the SalesOrderHeader
-- B) Sum of OrderQty*UnitPrice
-- C) Sum of OrderQty*ListPrice
SELECT
  soh.SalesOrderID,
  soh.SubTotal,
  SUM(sod.OrderQty * sod.UnitPrice),
  SUM(sod.OrderQty * p.ListPrice)
FROM
  SalesOrderHeader soh
  JOIN
    SalesOrderDetail sod
    ON sod.SalesOrderID = sod.SalesOrderID
  JOIN
    Product p
    ON sod.ProductID = p.ProductID
GROUP BY
  soh.SalesOrderID,
  soh.SubTotal;
  
 -- 13.Show the best selling item by value
 SELECT name, SUM(orderqty * unitprice) total_value
FROM SalesOrderDetail sod JOIN Product p ON sod.productid = p.productid
GROUP BY name
ORDER BY total_value DESC
LIMIT 1;

-- 14.Show how many orders are in the following ranges (in $):
WITH t1 AS (
  SELECT salesorderid, SUM(orderqty * unitprice) order_total
  FROM SalesOrderDetail
  GROUP BY salesorderid
), t2 AS (
  SELECT salesorderid, order_total, CASE
    WHEN order_total BETWEEN 0 AND 99 THEN '0-99'
    WHEN order_total BETWEEN 100 AND 999 THEN '100-999'
    WHEN order_total BETWEEN 1000 AND 9999 THEN '1000-9999'
    WHEN order_total >= 10000 THEN '10000-'
    ELSE 'Error'
    END AS range
  FROM t1
)
SELECT range, COUNT(rng) 'Num Orders', SUM(order_total) 'Total Value'
FROM t2
GROUP BY rng;

-- 15.Identify the three most important cities. Show the break down of top level product category against city.
WITH t1 AS (
  SELECT city, SUM(unitprice * orderqty) total_sales
  FROM SalesOrderDetail sod JOIN SalesOrderHeader soh ON sod.salesorderid = soh.salesorderid
  JOIN Address a ON soh.shiptoaddressid = a.addressid
  GROUP BY city
  ORDER BY total_sales DESC
  LIMIT 3
)
SELECT city, pc.name, SUM(unitprice * orderqty) total_sales
FROM SalesOrderDetail sod JOIN SalesOrderHeader soh ON sod.salesorderid = soh.salesorderid
JOIN Address a ON soh.shiptoaddressid = a.addressid
JOIN Product p ON sod.productid = p.productid
JOIN ProductCategory pc ON p.productcategoryid = pc.productcategoryid
WHERE city IN (SELECT city FROM t1)
GROUP BY city, pc.name
ORDER BY city, total_sales DESC;


