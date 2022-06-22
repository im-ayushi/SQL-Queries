--Exercise 5
/*Write a Procedure supplying name information from the Person.Person table and accepting a filter for the first name.
Alter the above Store Procedure to supply Default Values if user does not enter any value. ( Use AdventureWorks)*/

CREATE or ALTER PROCEDURE FilterPersonalInfo(@Name VARCHAR(20))
AS
BEGIN
SELECT BusinessEntityID, CONCAT(FirstName+' ',LastName) AS FullName FROM Person.Person WHERE FirstName = @Name;
END
--for execution
EXEC FilterPersonalInfo @Name='Syed';

