CREATE TABLE #TempEmployee (
EmployeeID int,
JobTitle Varchar(100),
Salary int
)
SELECT *
FROM #TempEmployee

INSERT INTO #TempEmployee 
SELECT *
FROM SQLTutorial..Employeesalary



DROP TABLE IF EXISTS #Temp_Employee
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
















