SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;

SELECT es.first_name, es.last_name, es.occupation, es.salary,
CASE 
	WHEN es.salary > 60000 THEN 'Highly Paid'
	WHEN es.salary BETWEEN 40000 AND 60000 THEN 'Stable'
	ELSE 'Lowly Paid'
END AS Earnings
FROM employee_salary es 
;

SELECT es.first_name, es.last_name, es.salary,
CASE 
	WHEN es.salary <= 50000 THEN es.salary * 1.05
	WHEN es.salary > 50000 THEN es.salary * 1.07
END New_Salary,
CASE 
	WHEN es.dept_id = 6 THEN salary * .10
END Bonus
FROM employee_salary es
;

