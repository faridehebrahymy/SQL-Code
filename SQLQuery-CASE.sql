Use SQLTutorial
SELECT FirstName ,LastName,Age,
CASE 
	WHEN AGE =38 then 'Stanley'
    WHEN AGE > 30 THEN 'OLD'
	ELSE 'Baby'
END AS O_Y
FROM EmployeeDemograghics 
WHERE age IS NOT NULL
ORDER BY AGE
;
Use SQLTutorial
SELECT FirstName,LastName,JobTitle,Salary,
CASE 
	WHEN JobTitle='Salesman' THEN Salary+(Salary*.10)
	WHEN Jobtitle= 'Accountant'THEN Salary+(Salary*.5)
	WHEN Jobtitle= 'HR'THEN Salary+(Salary*.000001)
	ELSE Salary+(Salary*.3)
END AS NewYearSalary
FROM EmployeeDemograghics 
JOIN Employeesalary
   ON EmployeeDemograghics.EmployeeID=Employeesalary.EmployeeID
