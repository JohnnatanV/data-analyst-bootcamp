SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;

-- Inner Join

SELECT es.employee_id, ed.age, es.occupation 
FROM employee_demographics ed 
INNER JOIN employee_salary es 
	ON ed.employee_id = es.employee_id 
;

-- Outer Join (LEFT, RIGTH)

SELECT * 
FROM employee_demographics ed 
LEFT JOIN employee_salary es 
	ON ed.employee_id = es.employee_id 
;

SELECT * 
FROM employee_demographics ed 
RIGHT JOIN employee_salary es 
	ON ed.employee_id = es.employee_id 
;

SELECT es.employee_id, ed.age, es.occupation 
FROM employee_demographics ed 
LEFT JOIN employee_salary es 
	ON ed.employee_id = es.employee_id 
;

SELECT es.employee_id, ed.age, es.occupation 
FROM employee_demographics ed 
RIGHT JOIN employee_salary es 
	ON ed.employee_id = es.employee_id 
;

-- Self Join

SELECT es.employee_id, es.first_name, es.last_name, es2.employee_id ,es2.first_name ,es2.last_name  
FROM employee_salary es
JOIN employee_salary es2 
	ON es.employee_id + 1 = es2.employee_id	
;

-- Join Multiple Tables

SELECT es.employee_id, ed.age, es.occupation 
FROM employee_demographics ed 
JOIN employee_salary es 
	ON ed.employee_id = es.employee_id 
;

SELECT es.first_name, es.last_name, ed.age, es.occupation, pd.department_name 
FROM employee_demographics ed 
JOIN employee_salary es 
	ON ed.employee_id = es.employee_id
JOIN parks_departments pd 
	ON es.dept_id = pd.department_id 
;

SELECT es.first_name, es.last_name, ed.age, es.occupation
FROM employee_demographics ed 
JOIN employee_salary es 
	ON ed.employee_id = es.employee_id 
;