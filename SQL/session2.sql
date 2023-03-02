USE CPL1Db
GO
--tao ra mot nhom(schema)
CREATE SCHEMA cpl01
GO
CREATE TABLE cpl01.Students(
	Id		INT,
	Name	NVARCHAR
)

CREATE TABLE Categories(
	Id				INT,
	Name			NVARCHAR(50),
	Description		NVARCHAR(MAX)
)
CREATE TABLE Products(
	Id				INT,
	Name			NVARCHAR(50),
	CategoryId		INT,
	Price			MONEY,
	Quantity		INT
)
--sua bang categories cho cot Id not null
ALTER TABLE Categories ALTER COLUMN Id INT NOT NULL
ALTER TABLE Products ALTER COLUMN Id INT NOT NULL


--Them constraint khoa chinh, khoa ngoai cho bang Categori Product
ALTER TABLE Categories ADD CONSTRAINT pk1 PRIMARY KEY (Id)
ALTER TABLE Products ADD CONSTRAINT pk2 PRIMARY KEY (Id)
--Them khoa ngoai (Foreign key) cho bang Products cua cot CategoryId
--Tham Chieu sang bang Categories(Id)
ALTER TABLE Products ADD CONSTRAINT fk1 FOREIGN KEY (CategoryId)
REFERENCES Categories(Id)
--Them 1 truong CREATEDDate vao bang Product
ALTER TABLE Products ADD CreatedDate DATETIME

--dat gia tri default cho cot CreatedDate laf ngay thang hien tai
ALTER TABLE Products ADD CONSTRAINT df1 DEFAULT GETDATE() FOR CreatedDate
--INSERT INTO Categories(Name) VALUES ('laptop')
--INSERT INTO Products(Id,Name,CategoryId,Price,Quantity) VALUES (1,'LENOVO',1,3000,23)
SELECT * FROM Products
--Thay doi kieu du lieu description cua bang categories sang NTEXT
ALTER TABLE Categories ALTER COLUMN Description NTEXT
-- xoa colum Description
ALTER TABLE Categories DROP COLUMN Description

--XOa CONSTRAINT df1 Product
ALTER TABLE Products DROP CONSTRAINT df1

--them rang buoc Check, Them Contraint Kiem tra Quantity cua bang Product >0
ALTER TABLE Products ADD CONSTRAINT ck CHECK (Quantity>0)

--them rang buoc unique -duy nhat
ALTER TABLE Products ADD CONSTRAINT uq1 UNIQUE(Name)

--Them rang buoc khi tao bang
CREATE TABLE Departerments(
	Id					INT PRIMARY KEY IDENTITY(1000,1),
	Name				NVARCHAR(50) UNIQUE
)
--doi ten table
EXEC sp_rename Departerments, Departments
--
CREATE TABLE Employee(
	Id					INT PRIMARY KEY IDENTITY,
	NAME				NVARCHAR(50) NOT NULL,
	DepartmentId		INT REFERENCES Departments(Id),
	DateOfJoin			DATETIME CHECK (DateOfJoin >= GETDATE()) DEFAULT GETDATE(),
	Email				VARCHAR(50)
)

INSERT Departments(Name) Values ('Hr')
INSERT Departments(Name) Values ('Academic')
INSERT Departments(Name) Values ('FHN')
SELECT * FROM Departments

--Drop Foreign Key Cua bang Employees
ALTER TABLE Employee DROP CONSTRAINT [FK__Employee__Depart__5629CD9C] 
-- Xoa vi tri insert sai, xoa tat ca du lieu cua bang
TRUNCATE TABLE Departments
SELECT * FROM Departments

--tạo view để lấy dữ liêu trong bảng Departments giúp hạn chế quyền truy cập dữ liệu
GO
CREATE VIEW vwSelectDepartements
AS
	SELECT d.Id,d.Name
	FROM dbo.Departments d
GO

SELECT * FROM vwSelectDepartements

GO
ALTER VIEW vwSelectDepartements
AS
	SELECT d.Name
	FROM dbo.Departments d
GO
SELECT * FROM vwSelectDepartements

--Xoa view
DROP VIEW vwSelectDepartements


--Insert update delete dữ liệu
INSERT Categories(Id,Name) 
VALUES (1,N'đồ điện tử'),(2,N'Đồ Gia Dụng'),(3,N'Thời Trang')

SELECT * FROM Categories

UPDATE Categories SET Name=N'Thời trang Name' WHERE Id=3

DELETE Categories WHERE Id=3

--Viết các câu lệnh select
USE Northwind
GO
SELECT * FROM Categories
SELECT * FROM Products
SELECT * FROM Employees

SELECT City FROM Employees
-- bo di các kết quả trùng lặp
SELECT DISTINCT City FROM Employees

--lấy ra những sản phẩm có giá lớn hơn 10
SELECT * FROM Products WHERE UnitPrice>10
SELECT * FROM Products WHERE ProductName LIKE 'A%'
--lấy ra những sản phẩm bắt đầu bằng nguyên âm
SELECT * FROM Products WHERE ProductName LIKE '[AIUOE]%'
-- hoac
SELECT *
FROM Products
	WHERE ProductName LIKE 'A%'
	OR ProductName LIKE 'I%'
	OR ProductName LIKE 'U%'
	OR ProductName LIKE 'O%'
	OR ProductName LIKE 'E%'
-- hoac
SELECT * FROM Products WHERE LEFT (ProductName,1) IN ('A','I','U','O','E')