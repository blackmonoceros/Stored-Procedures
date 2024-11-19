___________________________________________________________________________________________________________________________________________________________
# Stored-Procedures


The following tasks involving stored procedures and functions in Microsoft SQL Server should be performed in a copy of the Northwind database.


Task 1

Create a stored procedure that displays the name and price of all products.

CREATE PROC Z1
AS
SELECT ProductName, UnitPrice
FROM Products
GO

EXEC Z1


Task 2

Create a stored procedure that displays the name and price of products belonging to the category whose name (not identifier) ​​is provided as a parameter.


Task 3

Modify the previous procedure so that it passes the number of products in the selected category via the output parameter (OUTPUT).


Task 4

Write a procedure that displays the name and price of products with the maximum price in the category whose identifier is provided as a procedure parameter.


Task 5

Create a procedure that updates the price of a product with the specified ID number. Check the procedure to see if a product with that identifier exists. 
If it does not, the procedure should exit without making any changes to the table.


Task 6

Create a procedure that adds a record to the Customers table. Check in the procedure whether the customer with the given ID is already entered in the table. 
If it is, the procedure should end its operation.


Task 7

Before creating the procedure described below, perform the following operations:
Create a copy of the Products table and name it Products2:


SELECT * INTO Products2 FROM Products

Create a primary key in this table (the SQL statement presented above does not do this:

ALTER TABLE Products2 ADD PRIMARY KEY (ProductID)

Then create a procedure that removes the product with the specified number (ProductID) from the Products2 table.


Task 8

Create the archive table (ProductsArchive – this will be a copy of Products2):

SELECT * INTO ProductsArchive FROM Products2

Delete records from ProductsArchive:

DELETE FROM ProductsArchive

Remove automatic numbering from the ProductID column. To do this, remove this column and add it again – this time without IDENTITY:

ALTER TABLE ProductsArchive DROP Column ProductID -- to remove Identity
ALTER TABLE ProductsArchive ADD ProductID INT

Add the ArchiveID column to the ProductsArchive table, which will retrieve values ​​from the sequence:

CREATE SEQUENCE ProductsArchiveSequence AS INT START WITH 1
ALTER TABLE ProductsArchive ADD ArchiveID INT
DEFAULT NEXT VALUE FOR ProductsArchiveSequence

Write a procedure that will delete the product data with the identifier given as a parameter 
(the procedure is to delete from the Products2 table) and add it to the ProductsArchive table.


Task 9

Create the ProductsCopy table:
SELECT * INTO ProductsCopy FROM Products
ALTER TABLE ProductsCopy ADD PRIMARY KEY (ProductID)

Add the Login column of type NVARCHAR(128) and the Modified column of type DATETIME to the ProductsCopy table.
Write a procedure that will modify the unit price of the product in the ProductsCopy table, whose identifier is a parameter of the procedure. 
The second parameter is to be the new price value. In addition, the procedure should enter the login name of the person who entered the new price 
into the Login column (use the SUSER_SNAME() function) and enter the date and time of modification into the Modified column (use the GETDATE() function).
