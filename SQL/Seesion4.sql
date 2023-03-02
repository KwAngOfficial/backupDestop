USE CPL1Db
GO
--INNER JOIN 
CREATE TABLE table1 
(
	Id INT
	,Name1 VARCHAR(20)
)
CREATE TABLE table2 
(
	Id INT
	,Name2 VARCHAR(20)
)
--OUTER JOIN
INSERT table1(Id,Name1) VALUES 
(1,'DEV_1'),(2,'DEV_2'),(3,'DEV_3'),(4,'DEV_4'),(5,'DEV_5')

INSERT table2(Id,Name2) VALUES 
(1,'DEV_6'),(2,'DEV_7'),(3,'DEV_8'),(4,'DEV_9'),(5,'DEV_10')

SELECT * FROM table1
SELECT * FROM table2

SELECT t1.Id Id1,t1.Name1,t2.Id Id2,t2.Name2
FROM table1 t1
INNER JOIN table2 t2
ON t1.Id=t2.Id

USE Northwind
GO
SELECT * FROM Products
SELECT * FROM Categories
--Lấy ra ProductId,ProductName,CategoryName,UnitPrice
SELECT p.ProductID,p.ProductName,c.CategoryName,p.UnitPrice
FROM Products p
INNER JOIN Categories c
ON p.CategoryID=c.CategoryID

--LEFT JOIN
USE CPL1Db
GO
--==========================
SELECT t1.Id Id1, t1.Name1,t2.Id Id2,t2.Name2
FROM table1 t1 LEFT JOIN table2 t2
ON t1.Id=t2.Id
--RIGHT JOIN
SELECT t1.Id Id1,t1.Name1, t2.Id Id2,t2.Name2
FROM table1 t1 RIGHT JOIN table2 t2
ON t1.Id=t2.Id
--==========================
--CROSS JOIN
SELECT t1.Id Id1,t1.Name1, t2.Id Id2,t2.Name2
FROM table1 t1,table2 t2

CREATE TABLE NhanVien
(
	Id				INT PRIMARY KEY IDENTITY,
	Name			NVARCHAR(50),
	Age 			INT,
	ManagerId		INT REFERENCES NhanVien(Id)
)
SELECT * FROM NhanVien
--TRUNCATE TABLE NhanVien
--SELF JOIN
INSERT NhanVien (Name,Age,ManagerId) VALUES
('tong giam doc',23,NULL),
('giam doc nhan su',23,1),
('giam doc kinh doanh',23,1),
('Truong phong nhan su',23,2),
('Truong phong kinh doanh',23,3)

SELECT e1.Id,e1.Name,e1.Age,e2.Name ManagerName 
FROM NhanVien e1 LEFT JOIN NhanVien e2
ON e1.ManagerId=e2.Id
--LEFT EXCLUDING JOIN
SELECT t1.Id Id1,t1.Name1, t2.Id Id2,t2.Name2
FROM table1 t1 LEFT JOIN table2 t2
ON t1.Id=t2.Id
WHERE t2.Id IS NULL
--Right EXCLUDING JOIN
SELECT t1.Id Id1,t1.Name1, t2.Id Id2,t2.Name2
FROM table1 t1 RIGHT JOIN table2 t2
ON t1.Id=t2.Id
WHERE t1.Id IS NULL
--FULL EXCLUDING JOIN
SELECT t1.Id Id1,t1.Name1, t2.Id Id2,t2.Name2
FROM table1 t1 FULL JOIN table2 t2
ON t1.Id=t2.Id
WHERE t1.Id IS NULL OR t2.Id IS NULL

USE Northwind
GO
--Liệt kê Mã KH,TÊN KH, Mã ORder, Mã Sp, Tên sp, số lượng sp 

SELECT c.CustomerID,c.ContactName,od.OrderID,dt.ProductID,p.ProductName,dt.Quantity,dt.UnitPrice
FROM Customers c INNER JOIN Orders od
ON c.CustomerID=od.CustomerID
INNER JOIN [Order Details] dt
ON od.OrderID=dt.OrderID
INNER JOIN Products p
ON dt.ProductID=p.ProductID
ORDER BY c.CustomerID,od.OrderID

--Liệt kê mã kh, tên kh, mã order, tổng tiền của order đó
--Cuối cùng hiện thị tổng tiền của cả đơn hàng
SELECT 
	c.CustomerID,c.ContactName,od.OrderID,SUM(dt.Quantity*dt.UnitPrice) [Total Price]
FROM Customers c 
INNER JOIN Orders od
ON c.CustomerID=od.CustomerID
INNER JOIN [Order Details] dt
ON od.OrderID=dt.OrderID
GROUP BY ROLLUP(c.CustomerID,c.ContactName,od.OrderID)
HAVING c.ContactName IS NOT NULL OR od.OrderID IS NOT NULL
