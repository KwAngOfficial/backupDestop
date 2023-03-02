USE CPL1Db
GO

--CREATE CLUSTERED INDEX Ix1 ON NhanVien(Name) sai

CREATE TABLE TestIndex
(
	Id		INT,
	Name	NVARCHAR(50)
)

CREATE CLUSTERED INDEX Ix1 ON TestIndex(Id)
CREATE NONCLUSTERED INDEX Ix2 ON TestIndex(Name)
DROP INDEX TestIndex.Ix2

CREATE TABLE TableIdentity
(
	Id			INT IDENTITY(1,1),
	Name		NVARCHAR(50)
)

INSERT TableIdentity VALUES ('A'),('B'),('C'),('D')

SELECT * FROM TableIdentity

CREATE TABLE AutoColumn
(
	Id			UNIQUEIDENTIFIER
	,Name		NVARCHAR(50)
)

INSERT AutoColumn(Id,Name) 
VALUES	(NEWID(),'A'),
		(NEWID(),'B'),
		(NEWID(),'C'),
		(NEWID(),'D'),
		(NEWID(),'E')

SELECT * FROM AutoColumn


USE Northwind
GO
SELECT * FROM Categories
SELECT * FROM Products

--Lấy thông tin sản phẩm có danh mục bắt đầu bằng chữ c

SELECT *
FROM Products p
WHERE p.CategoryID IN
(
	SELECT c.CategoryID
	FROM Categories c
	WHERE c.CategoryName LIKE 'C%'
)

--Lấy tất cả các sản phẩm có trong OrderDetails mà có quantity=10
--ANY
SELECT *
FROM [Products] p
WHERE p.ProductID =ANY --ALL
(
	SELECT o.ProductID
	FROM [Order Details] o
	WHERE o.Quantity=10
)
--ALL
SELECT *
FROM [Products] p
WHERE p.ProductID =ALL
(
	SELECT o.ProductID
	FROM [Order Details] o
	WHERE o.Quantity=10
)

SELECT *
FROM Suppliers

--Lấy tên nhà cung cấp mà có bất kì 1 sản phẩm nào có giá nhỏ hơn 20
--Exits
SELECT s.CompanyName
FROM Suppliers s
WHERE EXISTS 
(
	SELECT 1
	FROM Products p
	WHERE p.UnitPrice<20 AND s.SupplierID=p.SupplierID
)