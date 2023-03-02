USE Northwind
GO

-- lay ra 1 san pham co gia cao nhat
SELECT TOP 1 * 
FROM Products 
ORDER BY UnitPrice DESC

-- lay tat ca san pham co gia nho nhat
--Cach 1
SELECT *
FROM Products p
WHERE p.UnitsInStock=(
	SELECT MIN(p1.UnitsInStock)
	FROM Products p1
)
ORDER BY UnitPrice DESC

--Cach 2
SELECT TOP 1 WITH TIES *
FROM Products 
ORDER BY UnitsInStock

--SELECT INTO Lay du lieu ra roi them vao bang moi
--Lấy dữ liệu bảng Products ra thêm vào bẳng ProductsLog(Chưa tồn tại)
SELECT * INTO ProductsLog FROM Products
SELECT * FROM ProductsLog

--GROUP BY
SELECT c.CategoryID,c.CategoryName,AVG(p.UnitPrice)
FROM Categories c,Products p
WHERE c.CategoryID=p.CategoryID			--Loc tren du lieu tung ban ghi co san
GROUP BY c.CategoryID,c.CategoryName	--Nhóm lại theo...
HAVING AVG(p.UnitPrice)>=30				-- Lọc khi ban ghi do khong ton tai (dữ liệu đã được nhóm)
ORDER BY c.CategoryID					--Sắp xếp 

--LEN trả về độ dài của một chuỗi
--ROUND làm tròn
SELECT ROUND(3.15,1)
SELECT ROUND(3.14,1)
--GETDATE() lấy ngày tháng hiện tại
SELECT FORMAT(0333070321,'+84###-###-###')
--UNION loại bỏ các bản ghi bị trùng lặp
SELECT c.CategoryID,c.CategoryName Name
FROM Categories c,Products p
UNION
SELECT p.CategoryID,p.ProductName Name
FROM Products p

SELECT c.CategoryID,c.CategoryName Name
FROM Categories c,Products p
UNION ALL
SELECT p.CategoryID,p.ProductName Name
FROM Products p

--Insert into
TRUNCATE TABLE ProductsLog
SELECT * 
FROM ProductsLog

INSERT INTO ProductsLog	SELECT * FROM Products --(do id tự tăng nên phải dùng truyền giá trị cụ thể)

--CAST
SELECT 'hello' +2023 --(error)
SELECT 'hello' + CAST(2023 AS CHAR(4))
CREATE TABLE TestDateTime
(
	Id INT PRIMARY KEY IDENTITY
	,CreatedDate DATETIME
)

--CONVERT
INSERT TestDateTime(CreatedDate) VALUES ('12/01/2022') --error yyyy-mm-dd
SELECT * FROM TestDateTime
--mm-dd-yyyy
INSERT TestDateTime(CreatedDate) VALUES (CONVERT(DATETIME,'12/01/2022',103)) 
SELECT * FROM TestDateTime
--dd-mm-yyyy
INSERT TestDateTime(CreatedDate) VALUES (CONVERT(DATETIME,'12/01/2022',103)) 
SELECT * FROM TestDateTime

--lấy 1 phần của dữ liệu ngày tháng
SELECT DATEPART(yyyy,GETDATE())
SELECT DATEPART(mi,GETDATE()) --minite
SELECT DATEPART(MM,GETDATE())
SELECT DATEPART(dd,GETDATE())

SELECT YEAR(GETDATE())
SELECT MONTH(GETDATE())
SELECT DATEADD(DD,90,GETDATE())
SELECT DATEDIFF(mi,GETDATE(),CONVERT(DATE,'31/12/2023',103))


--CONCAT() Cộng chuỗi
--LTRIM() cắt khoảng trắng bên trái

SELECT CONCAT('KwAng ',LTRIM('       Hello     '),'KwAng')
SELECT CONCAT('KwAng ',RTRIM('       Hello     '),' KwAng')

--Substring lấy chuỗi con từ vị trí 1 và độ dài là 8 kí tự
SELECT CONCAT('"',SUBSTRING('Cong hoa xa hoi Chu nghia Viet Nam',1,8),'"')
SELECT CHARINDEX('hoa','Cong hoa xa hoi chu nghia Viet nam')
SELECT PATINDEX('%hoa%','Cong hoa xa hoi chu nghia Viet nam')
SELECT PATINDEX('_ong%','Cong hoa xa hoi chu nghia Viet nam')