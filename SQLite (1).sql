-- 1. List the SalesOrderNumber for the customer 'Good Toys' 'Bike World'
SELECT cu.companyname, soh.salesorderid
FROM Customer cu LEFT JOIN SalesOrderHeader soh ON cu.customerid = soh.customerid
WHERE cu.companyname LIKE '%Good Toys%' OR cu.companyname LIKE '%Bike World%';

-- 2.List the ProductName and the quantity of what was ordered by 'Futuristic Bikes'
SELECT cu.companyname, p.name, SUM(sod.orderqty) quantity
FROM Customer cu JOIN SalesOrderHeader soh ON cu.customerid = soh.customerid
JOIN SalesOrderDetail sod ON soh.salesorderid = sod.salesorderid
JOIN Product p ON sod.productid = p.productid
WHERE companyname LIKE '%Futuristic Bikes%'
GROUP BY companyname, p.name;

-- 3.List the name and addresses of companies containing the word 'Bike' (upper or lower case) and companies containing 'cycle' (upper or lower case). Ensure that the 'bike's are listed before the 'cycles's.

-- 4. Show the total order value for each CountryRegion. List by value with the highest first.
SELECT countyregion, SUM(subtotal) total_order_value
FROM Address a JOIN SalesOrderHeader soh ON a.addressid = soh.shiptoaddressid
GROUP BY countyregion;

-- 5.Find the best customer in each region.
WITH t AS (
  SELECT a.countyregion, cu.companyname, SUM(subtotal) total,
    RANK() OVER (PARTITION BY countyregion ORDER BY total DESC) rank
  FROM Address a JOIN SalesOrderHeader soh ON a.addressid = soh.shiptoaddressid
  JOIN Customer cu ON soh.customerid = cu.customerid
  GROUP BY a.countyregion, cu.companyname
)
SELECT countyregion, companyname, total
FROM t
WHERE rank = 1;