SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;

-- Subqueries
SELECT *
FROM employee_demographics ed
WHERE ed.employee_id IN (
	SELECT es.employee_id 
	FROM employee_salary es
	WHERE es.dept_id = 1
);

-- Exists
SELECT *
FROM employee_demographics ed
WHERE EXISTS (
	SELECT 1 
	FROM employee_salary es 
	WHERE es.employee_id = ed.employee_id 
	AND dept_id = 1
	)
;

-- Join
SELECT ed.*
FROM employee_demographics ed 
JOIN employee_salary es ON ed.employee_id = es.employee_id 
WHERE es.dept_id = 1
; 

SELECT es.first_name , es.salary , 
(SELECT AVG(es.salary)
FROM employee_salary es) avg_salary
FROM employee_salary es 
;

SELECT gender, AVG(ed.age), MAX(ed.age), MIN(ed.age), COUNT(ed.age)
FROM employee_demographics ed 
GROUP BY gender

SELECT gender, AVG(`COUNT(ed.age)`)
FROM (SELECT gender, AVG(ed.age), MAX(ed.age), MIN(ed.age), COUNT(ed.age)
FROM employee_demographics ed 
GROUP BY gender) as agg_table
GROUP BY gender
;

SELECT gender, AVG(max_age)
FROM (SELECT gender, AVG(ed.age) avg_age, MAX(ed.age) max_age, MIN(ed.age) min_age, COUNT(ed.age) count_age
FROM employee_demographics ed 
GROUP BY gender) as agg_table
GROUP BY gender
;

