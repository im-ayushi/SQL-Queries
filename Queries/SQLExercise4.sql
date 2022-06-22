--Create a function that takes as inputs a SalesOrderID, a Currency Code, and a date, and returns a table of all the 
--SalesOrderDetail rows for that Sales Order including Quantity, ProductID, UnitPrice, and the unit price 
--converted to the target currency based on the end of day rate for the date provided. 
--Exchange rates can be found in the Sales.CurrencyRate table. (Use AdventureWorks)

CREATE FUNCTION SalesInformation(@SalesOrderId int, @CurrencyCode varchar(10),@Date datetime)
RETURNS TABLE
as
return
select Sales.SalesOrderDetail.ProductID as ProductId, Sales.SalesOrderDetail.OrderQty as OrderQuantity,
Sales.SalesOrderDetail.UnitPrice as UnitPrice,
Sales.SalesOrderDetail.UnitPrice*Sales.CurrencyRate.EndOfDayRate as ConvertedPrice
from Sales.SalesOrderDetail, Sales.CurrencyRate
where Sales.SalesOrderDetail.SalesOrderID = @SalesOrderId and Sales.CurrencyRate.ToCurrencyCode = @CurrencyCode and
Sales.CurrencyRate.CurrencyRateDate = @Date;


--Execution
SELECT * FROM SalesInformation(43659,'ARS','2005-07-01 00:00:00.000');

