SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;


SELECT ed.gender, AVG(es.salary) avg_salary
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id
GROUP BY ed.gender
;

-- Over
SELECT ed.gender , AVG(es.salary) OVER()
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id 
;

-- Over - Partition By
SELECT ed.first_name, ed.last_name, ed.gender, AVG(es.salary) OVER(PARTITION BY ed.gender)
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id 
;

-- Rolling Total
SELECT ed.first_name, ed.last_name, ed.gender, es.salary,
SUM(es.salary) OVER(PARTITION BY ed.gender ORDER BY ed.employee_id) Rolling_Total -- OVER(PARTITION BY [filter column] ORDER BY [main data column)
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id
;

-- Row_Number - Rank - Dense_Rank
SELECT ed.employee_id, ed.first_name, ed.last_name, ed.gender, es.salary, 
ROW_NUMBER() OVER(PARTITION BY ed.gender ORDER BY es.salary DESC) row_num,
RANK() OVER(PARTITION BY ed.gender ORDER BY es.salary DESC) rank_num,
DENSE_RANK() OVER(PARTITION BY ed.gender ORDER BY es.salary DESC) dense_num
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id 
;