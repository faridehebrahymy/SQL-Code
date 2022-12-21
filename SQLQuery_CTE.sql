WITH CTE_Employee AS 
(SELECT FirstName ,LastName,Gender,Salary
,COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
,AVG(Salary) OVER (PARTITION BY Gender)AS AvgSalary
FROM SQLTutorial..EmployeeDemograghics Demo
JOIN SQLTutorial..Employeesalary Sal
     ON Demo.EmployeeID=Sal.EmployeeID
WHERE Salary > '45000'
)
 SELECT FirstName,AvgSalary
 FROM CTE_Employee