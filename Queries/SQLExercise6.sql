/*Exercise 6
Write a trigger for the Product table to ensure the list price can never be raised more than 15 Percent in a singlechange.
Modify the above trigger to execute its check code only if the ListPrice column is updated (Use AdventureWorks Database).
*/


--- Creating TRIGGER
CREATE or ALTER TRIGGER Production.UpdateProductTable
ON Production.Product
AFTER UPDATE
AS
BEGIN
IF UPDATE(ListPrice)
BEGIN


--- Variables Declaration
DECLARE @OldPrice MONEY;
DECLARE @NewPrice MONEY;
DECLARE @ID INT;


SELECT @OldPrice=ListPrice FROM Production.Product;
SELECT @NewPrice=ListPrice FROM Production.Product;
SELECT @ID = ProductID FROM Production.Product;
IF(@NewPrice > @OldPrice*1.15)
BEGIN
PRINT 'Sorry , Update Request is more than 15%'
ROLLBACK
END
ELSE
BEGIN
Update Production.Product SET ListPrice=@NewPrice
WHERE Production.Product.ProductID = @ID;
PRINT 'Updated Successfully'
END
END
END
GO




--- FOR EXECUTION TESTING
UPDATE Production.Product SET
ListPrice=0.677
WHERE ProductID=736;

--checking execution
Select * from Production.Product where ProductID=736;