--Write separate queries using a join, a subquery, a CTE, and then an EXISTS to list all AdventureWorks customers 
--who have not placed an order.


--Using JOIN:
SELECT *
FROM Sales.Customer 
LEFT OUTER JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
WHERE Sales.SalesOrderHeader.SalesOrderID IS NULL order by Sales.Customer.CustomerID;


--Subquery:
SELECT *
FROM Sales.Customer 
where Sales.Customer.CustomerID not in (SELECT Sales.SalesOrderHeader.CustomerID FROM Sales.SalesOrderHeader);


--with CTE
WITH s AS
	(
	SELECT SalesOrderID
    FROM Sales.SalesOrderHeader
	)
SELECT * FROM Sales.Customer
LEFT OUTER JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
WHERE Sales.SalesOrderHeader.SalesOrderID IS NULL ORDER BY Sales.Customer.CustomerID;

--with exist
SELECT *
FROM Sales.Customer 
where NOT EXISTS( SELECT * FROM Sales.SalesOrderHeader WHERE Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID);