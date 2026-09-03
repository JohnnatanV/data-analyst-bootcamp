SELECT *
FROM employee_salary es;

SELECT * 
FROM Parks_and_Recreation.employee_demographics ed
WHERE MONTH(ed.birth_date) = 3;

SELECT *
FROM Parks_and_Recreation.employee_salary es
WHERE es.salary > 60000;

SELECT first_name, 
	last_name, 
	birth_date, 
	age, 
	age + 10 as plus
FROM employee_demographics ed;

SELECT DISTINCT gender, first_name
FROM employee_demographics ed;