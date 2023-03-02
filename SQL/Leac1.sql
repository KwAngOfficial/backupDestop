CREATE DATABASE CPL1Db
GO
USE CPL1Db
GO
--tao bang Students(Id,Name,Email,Dob)
CREATE TABLE Students
(
	Id		INT PRIMARY KEY IDENTITY,
	Name	NVARCHAR(50),
	Email	VARCHAR(50),
	Dob		DATETIME,
	--Age INT
)
--CHAR co dinh do dai chuoi (fix length)
--DECLARE @name char (khai bao bien)
DECLARE @name	CHAR(20) ='abc'
DECLARE @name1	VARCHAR(20) =N'Nguyễn Văn A'
DECLARE @name2	NVARCHAR(20) =N'Nguyễn Văn A'
SELECT CONCAT('"',@name,'"')
SELECT CONCAT('"',@name1,'"')
SELECT CONCAT('"',@name2,'"')
INSERT Students(Name,Email,Dob) VALUES (N'Nguy?n V?n A','a@fsoft.com.vn','11/12/2021')
SELECT * FROM Students