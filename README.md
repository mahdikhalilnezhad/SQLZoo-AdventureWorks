# SQLZoo-AdventureWorks-Challenge

This data is based on [Microsoft's AdventureWorks](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms) database

* Customer(CustomerID, FirstName, MiddleName, LastName, CompanyName, EmailAddress)

* CustomerAddress(CustomerID, AddressID, AddressType)

* Address(AddressID, AddressLine1, AddressLine2, City, StateProvince, CountyRegion, PostalCode)

* SalesOrderHeader(SalesOrderID, RevisionNumber, OrderDate, CustomerID, BillToAddressID, ShipToAddressID, ShipMethod, SubTotal, TaxAmt, Freight)

* SalesOrderDetail(SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount)

* Product(ProductID, Name, Color, ListPrice, Size, Weight, ProductModelID, ProductCategoryID)

* ProductModel(ProductModelID, Name)

* ProductCategory(ProductCategoryID, ParentProductCategoryID, Name)

* ProductModelProductDescription(ProductModelID, ProductDescriptionID, Culture)

* ProductDescription(ProductDescriptionID, Description)

![Database-relations](https://sqlzoo.net/w/images/2/28/AdventureWorks.png)
