SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;

-- Limit
SELECT *
FROM employee_demographics ed
ORDER BY ed.age DESC 
LIMIT 3;

SELECT *
FROM employee_demographics ed
ORDER BY ed.age DESC 
LIMIT 2;

SELECT *
FROM employee_demographics ed
ORDER BY ed.age DESC 
LIMIT 2, 1;

-- Aliasing
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics ed 
GROUP BY ed.gender 
HAVING avg_age > 40;


SELECT department_name, AVG(salary) avg_salary
FROM employee_salary es
JOIN parks_departments pd ON es.dept_id = pd.department_id
WHERE es.dept_id > 0
GROUP BY department_name 
;


SELECT dept_id, pd.department_name, AVG(salary) avg_salary
FROM employee_salary es 
JOIN parks_departments pd on es.dept_id = pd.department_id
WHERE es.dept_id > 0 
GROUP BY dept_id ,department_name 
ORDER BY avg_salary DESC 
LIMIT 1
;


SELECT es.dept_id, pd.department_name, AVG(salary) avg_salary
FROM employee_salary es 
JOIN parks_departments pd on es.dept_id = pd.department_id
WHERE es.salary > 30000
GROUP BY dept_id ,department_name 
HAVING avg_salary < 70000
ORDER BY avg_salary DESC 
LIMIT 3
;