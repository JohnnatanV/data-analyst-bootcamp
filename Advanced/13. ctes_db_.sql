SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;


SELECT AVG(avg_sal)
FROM
(
SELECT gender, AVG(es.salary) avg_sal, MAX(es.salary) max_sal, MIN(es.salary) min_sal, COUNT(es.salary) count_sal
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id 
GROUP BY ed.gender 
) example_querie

-- CTEs
WITH CTE_Example AS 
(
SELECT gender, AVG(es.salary) avg_sal, MAX(es.salary) max_sal, MIN(es.salary) min_sal, COUNT(es.salary) count_sal
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id 
GROUP BY ed.gender 
)
SELECT AVG(avg_sal)
FROM CTE_Example
;

WITH CTE_Example AS 
(
SELECT gender, AVG(es.salary) avg_sal, MAX(es.salary) max_sal, MIN(es.salary) min_sal, COUNT(es.salary) count_sal
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id 
GROUP BY ed.gender 
)
SELECT *
FROM CTE_Example
;

WITH CTE_Example(Gender, AVG_Sal, MAX_Sal, MIN_Sal, Count_Sal) AS 
(
SELECT gender, AVG(es.salary), MAX(es.salary), MIN(es.salary), COUNT(es.salary)
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id 
GROUP BY ed.gender 
)
SELECT *
FROM CTE_Example
;				

WITH CTE_Example AS 
(
SELECT ed.employee_id, gender, ed.birth_date
FROM employee_demographics ed
WHERE ed.birth_date > '1985-01-01'
),
CTE_Example_2 AS
(
SELECT es.employee_id, es.salary
FROM employee_salary es
WHERE es.salary > 50000
)
SELECT *
FROM CTE_Example ce
JOIN CTE_Example_2 ce2
	ON ce.employee_id = ce2.employee_id 
;