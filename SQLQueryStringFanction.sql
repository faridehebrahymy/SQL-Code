CREATE TABLE EmployeeErrors(
EmployeeID Varchar(50)
,FirstName Varchar(50)
,LastName varchar(50)
)


INSERT INTO EmployeeErrors VALUES
('1001  ','Jimbo','Halbert')
,('   1002','Pamela','Beasely')
,('1005','TOby','Flendeson - Fired')

SELECT *
FROM EmployeeErrors


--Using Trim , LTRIM, RTRIM
SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

--Using Replace
SELECT LastName ,REPLACE(LastName,' - Fired','') AS LastNameFixed
FROM EmployeeErrors



--Using SubString
SELECT SUBSTRING(FirstName,3,3)
FROM EmployeeErrors

SELECT  Err.FirstName,SUBSTRING(Err.FirstName,1,3) ,Dem.FirstName, SUBSTRING(Dem.FirstName,1,3)
FROM EmployeeErrors Err
JOIN EmployeeDemograghics Dem
     ON SUBSTRING(Err.FirstName,1,3) = SUBSTRING(Dem.FirstName,1,3)

--Gender
--LastName
--AGE
--DOB


--USING UPPER and LOWER
SELECT FirstName,LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName,UPPER(FirstName)
FROM EmployeeErrors
