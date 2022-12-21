select *
FROM EmployeeSalary

--SubQuery In select
 SELECT EmployeeID,Salary,( SELECT AVG(Salary) FROM Employeesalary)AS ALLAvgSalary
 FROM Employeesalary


--How To Do It With Partition By
SELECT EmployeeID,Salary, AVG(Salary)  AS ALLAvgSalary
FROM Employeesalary
GROUP BY EmployeeID,Salary
Order By 1,2

--Why Group By Doesen't Work
SELECT EmployeeID,Salary, AVG(Salary) OVER() AS ALLAvgSalary
FROM Employeesalary


--SubQuery In FROM
SELECT A.EmployeeID,ALLAvgSalary
FROM (SELECT EmployeeID,Salary, AVG(Salary) over() AS ALLAvgSalary
FROM Employeesalary) A

--SubQuery In WHERE
SELECT EmployeeID,JobTitle,Salary
FROM Employeesalary
WHERE EmployeeID in (
    SELECT EmployeeID 
	FROM EmployeeDemograghics
	WHERE Age > 30)
)


