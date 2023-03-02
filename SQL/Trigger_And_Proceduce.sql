CREATE DATABASE [exTRIGGER]
GO
 USE exTRIGGER
 GO

 CREATE TABLE Students
 (
	Id		INT IDENTITY PRIMARY KEY,
	Name	NVARCHAR(50),
	DoB		DATE,
	Age		INT
 )

 CREATE TRIGGER autoCalAge
 ON Students
 FOR INSERT
 AS
	BEGIN
	UPDATE Students
	SET Age = (
		SELECT h.Age FROM 
		(
			SELECT DATEDIFF(Year,s.DoB,GETDATE()) as Age 
			FROM Students s 
			WHERE s.Id= ( SELECT top(1) Id FROM inserted i)
		) AS h
	)
	WHERE Id = ( SELECT top(1) Id FROM inserted i)
	END

	-- DROP TRIGGER
	DROP TRIGGER autoCalAge
	INSERT INTO Students(Name,Dob) 
		Values('Quang','2001-09-26')
			INSERT INTO Students(Name,Dob) 
		Values('Nhat','2007-02-26')
		SELECT * FROM Students
		drop table Students

-- PROCEDURE
CREATE PROC getInfo
@StudentId INT
AS 
	BEGIN
	SELECT * FROM Students s WHERE s.Id = @StudentId
	END

	exec getInfo 5