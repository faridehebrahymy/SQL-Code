SELECT JobTitle, AVG(Salary) As AvgSalary
FROM EmployeeDemograghics
JOIN Employeesalary
   ON EmployeeDemograghics.EmployeeID=Employeesalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(SALARY)