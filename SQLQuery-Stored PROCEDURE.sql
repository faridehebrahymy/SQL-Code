CREATE TABLE #Temp_Employee(
JobTitle Varchar(50),
EmployeePerJob Int,
AvgAge Int,
AvgSalary int
)

INSERT INTO #Temp_Employee
SELECT JobTitle,Count(JobTitle),Avg(Age),Avg(Salary)
FROM SQLTutorial..EmployeeDemograghics Dem 
JOIN SQLTutorial..Employeesalary Sal
    ON Dem.EmployeeID=sal.EmployeeID
GROUP BY JobTitle
  

SELECT * 
FROM #Temp_Employee


CREATE PROCEDURE TEST 
AS 
SELECT *
FROM EmployeeDemograghics




EXEC TEST

CREATE  PROCEDURE TEMP_Employee
AS 
CREATE TABLE #Temp_Employee(
JobTitle Varchar(50),
EmployeePerJob Int,
AvgAge Int,
AvgSalary int
)

EXEC TEMP_Employee