SELECT FirstName,LastName,Gender,Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM EmployeeDemograghics Dem
JOIN Employeesalary Sal
    ON Dem.EmployeeID=Sal.EmployeeID

--PARTITION BY is doing is basically taking this query right here
--and sticking it on one line in the select statmente
SELECT Gender,COUNT(Gender) 
FROM EmployeeDemograghics Dem
JOIN Employeesalary Sal
    ON Dem.EmployeeID=Sal.EmployeeID
GROUP BY Gender