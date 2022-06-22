--Exercise 1

--1.1 Display the number of records in the [SalesPerson] table. (Schema(s) involved: Sales)
Select count(*) from Sales.SalesPerson;


--1.2 Select both the FirstName and LastName of records from the Person table where the FirstName begins with the letter ‘B’. (Schema(s) involved: Person)
Select FirstName,LastName from Person.Person where FirstName like 'B%' ; 


--1.3 Select a list of FirstName and LastName for employees where Title is one of Design Engineer, 
--Tool Designer or Marketing Assistant. (Schema(s) involved: HumanResources, Person)
Select Person.Person.FirstName,Person.Person.LastName,HumanResources.Employee.JobTitle from Person.Person inner join 
HumanResources.Employee on(Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID) 
where HumanResources.Employee.JobTitle='Design Engineer' or HumanResources.Employee.JobTitle='Tool Designer' 
or HumanResources.Employee.JobTitle='Marketing Assistant' order by HumanResources.Employee.JobTitle;


--1.4 Display the Name and Color of the Product with the maximum weight. (Schema(s) involved: Production)
Select Production.Product.Name,Production.Product.Color, Production.Product.Weight
from Production.Product WHERE Production.Product.Weight=(SELECT MAX(Weight) FROM Production.Product);


--1.5 Display Description and MaxQty fields from the SpecialOffer table. Some of the MaxQty values are NULL, 
--in this case display the value 0.00 instead. (Schema(s) involved: Sales)
Select Sales.SpecialOffer.Description, ISNULL(Sales.SpecialOffer.MaxQty,0.00) as MaxQty from Sales.SpecialOffer;


--1.6 Display the overall Average of the [CurrencyRate].[AverageRate] values for the exchange rate ‘USD’ to ‘GBP’ for the year 
--2005 i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’. Note: The field [CurrencyRate].[AverageRate] is defined as
--'Average exchange rate for the day.' (Schema(s) involved: Sales)
Select AVG(Sales.CurrencyRate.AverageRate) as 'Average exchange rate for the day.' from Sales.CurrencyRate 
where Sales.CurrencyRate.ToCurrencyCode='GBP' and Sales.CurrencyRate.FromCurrencyCode='USD';


--1.7 Display the FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’. 
--Display an additional column with sequential numbers for each row returned beginning at integer 1. (Schema(s) involved: Person)
Select Person.Person.FirstName, Person.Person.LastName,ROW_NUMBER()   
OVER (ORDER BY Person.Person.FirstName asc) AS SequentialNumber from Person.Person where Person.Person.FirstName like '%ss%';


--1.8 Sales people receive various commission rates that belong to 1 of 4 bands. (Schema(s) involved: Sales)
--CommissionPct Commission Band
--         0.00 Band 0
--     Up To 1% Band 1
--   Up To 1.5% Band 2
-- Greater 1.5% Band 3
--Display the [SalesPersonID] with an additional column entitled ‘Commission Band’ indicating the appropriate band as above.

Select Sales.SalesPerson.BusinessEntityID as SalesPersonID,Sales.SalesPerson.CommissionPct, 'Commission Band'= CASE
WHEN Sales.SalesPerson.CommissionPct=0 then 'Band 0'
when Sales.SalesPerson.CommissionPct>0 and Sales.SalesPerson.CommissionPct<=0.01 then 'Band 1'
when Sales.SalesPerson.CommissionPct>0.01 and Sales.SalesPerson.CommissionPct<=0.015 then 'Band 2'
when Sales.SalesPerson.CommissionPct>0.015 then 'Band 3' END
from Sales.SalesPerson;

--1.9 Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez. Hint: use
--[uspGetEmployeeManagers] (Schema(s) involved: [Person], [HumanResources])

SELECT Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.MiddleName, 
Person.Person.LastName, HumanResources.EmployeePayHistory.Rate,                      
HumanResources.Employee.OrganizationLevel, HumanResources.Employee.JobTitle 
FROM HumanResources.Employee 
INNER JOIN
HumanResources.EmployeePayHistory 
ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeePayHistory.BusinessEntityID 
INNER JOIN
Person.Person ON HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID 
WHERE Person.person.BusinessEntityID<49                      
ORDER BY Person.person.BusinessEntityID ASC;


--1.10 Display the ProductId of the product with the largest stock level. Hint: Use the Scalar-valued function 
--[dbo]. [UfnGetStock].(Schema(s) involved: Production)
SELECT ProductID,Quantity
FROM Production.ProductInventory
ORDER BY Quantity DESC;



