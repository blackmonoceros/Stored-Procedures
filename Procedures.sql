--TASK 1

CREATE PROC Z1 AS
SELECT ProductName, UnitPrice FROM Products
GO EXEC Z1


--TASK 2

CREATE PROCEDURE Z2
@CategoryName NVARCHAR(255) AS
BEGIN
SELECT p.ProductName, p.UnitPrice FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID WHERE c.CategoryName = @CategoryName;
END; GO
EXEC Z2 @CategoryName = 'Beverages';


--TASK 3

CREATE PROCEDURE Z3 @CategoryName NVARCHAR(255), @ProductCount INT OUTPUT AS BEGIN SELECT @ProductCount = COUNT(*) FROM Products p INNER JOIN Categories c ON p.CategoryID = c.CategoryID WHERE c.CategoryName = @CategoryName; DECLARE @Count INT; EXEC Z3 @CategoryName = 'Beverages', @ProductCount = @Count OUTPUT; SELECT @Count AS ProductCount; END
Zadanie 4
CREATE PROCEDURE Z4
@CategoryID INT AS
BEGIN
;WITH RankedProducts AS ( SELECT
ProductName, UnitPrice,
RANK() OVER (ORDER BY UnitPrice DESC) AS PriceRank FROM Products
WHERE CategoryID = @CategoryID
)
SELECT ProductName, UnitPrice FROM RankedProducts
WHERE PriceRank = 1; END;
GO
EXEC Z4 @CategoryID = 1;


--TASK 5
CREATE PROCEDURE Z5
@ProductID INT, @NewPrice DECIMAL(10, 2)
AS BEGIN
IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID) BEGIN
UPDATE Products
SET UnitPrice = @NewPrice WHERE ProductID = @ProductID;
END END; GO
EXEC Z5 @ProductID = 10, @NewPrice = 29.99;


--TASK 6

CREATE PROCEDURE AddCustomerIfNotExistsSimple @CustomerID NVARCHAR(5),
@CompanyName NVARCHAR(40) AS
BEGIN
IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID) BEGIN
INSERT INTO Customers (CustomerID, CompanyName)
VALUES (@CustomerID, @CompanyName); END
END; GO
EXEC AddCustomerIfNotExistsSimple @CustomerID = 'NEW01', @CompanyName = 'Nowa Firma';


--TASK 7

SELECT * INTO Products2 FROM Products
ALTER TABLE Products2 ADD PRIMARY KEY (ProductID)
CREATE PROCEDURE z7
@ProductID INT AS
BEGIN
IF EXISTS (SELECT 1 FROM Products2 WHERE ProductID = @ProductID) BEGIN
DELETE FROM Products2 WHERE ProductID = @ProductID;
END
END; GO
EXEC z7 @ProductID = 1;


--TASK 8

SELECT * INTO ProductsArchive1 FROM Products DELETE FROM ProductsArchive1 ; ALTER TABLE ProductsArchive1 DROP Column ProductID; ALTER TABLE ProductsArchive1 ADD ProductID INT; CREATE SEQUENCE ProductsArchive1Sequence AS INT START WITH 1 ALTER TABLE ProductsArchive1 ADD ArchiveID INT DEFAULT NEXT VALUE FOR ProductsArchive1Sequence GO CREATE PROCEDURE z888 @ProductID INT AS BEGIN DECLARE @ProductName NVARCHAR(40), @UnitPrice DECIMAL(10, 2);
SELECT @ProductName = ProductName, @UnitPrice = UnitPrice FROM Products2 WHERE ProductID = @ProductID;
DELETE FROM Products2 WHERE ProductID = @ProductID;
IF @@ROWCOUNT > 0 BEGIN INSERT INTO ProductsArchive (ProductID, ProductName, UnitPrice) VALUES (@ProductID, @ProductName, @UnitPrice); END END; GO


--TASK 9

SELECT * INTO ProductsCopy FROM Products;
ALTER TABLE ProductsCopy ADD PRIMARY KEY (ProductID);
ALTER TABLE ProductsCopy ADD Login NVARCHAR(128), Modified DATETIME;
GO
CREATE PROCEDURE z9 @ProductID INT, @NewPrice DECIMAL(10, 2), @UserLogin NVARCHAR(128) = NULL AS BEGIN UPDATE ProductsCopy SET UnitPrice = @NewPrice, Login = COALESCE(@UserLogin, SUSER_SNAME()), Modified = GETDATE() WHERE ProductID = @ProductID; END; GO
EXEC z9 @ProductID = 1, @NewPrice = 20.00;



