--Show the most recent five orders that were purchased from account numbers that have spent more than 
--$70,000 with AdventureWorks.

SELECT TOP 5 Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.AccountNumber, 
SUM(Sales.SalesOrderHeader.TotalDue) as Ammount
FROM Sales.SalesOrderHeader
GROUP BY Sales.SalesOrderHeader.AccountNumber,Sales.SalesOrderHeader.OrderDate,Sales.SalesOrderHeader.SalesOrderID
HAVING SUM(Sales.SalesOrderHeader.TotalDue) > 70000
ORDER BY Sales.SalesOrderHeader.OrderDate DESC ;







