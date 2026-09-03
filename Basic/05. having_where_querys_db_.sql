SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;



SELECT gender, AVG(age)
from employee_demographics ed
GROUP BY gender 
HAVING avg(age) > 40;

SELECT gender, AVG(es.salary )
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id AND es.employee_id 
GROUP BY gender 
HAVING avg(es.salary ) > 10;

SELECT es.occupation, AVG(es.salary) avg_salary
FROM employee_salary es 
WHERE es.occupation LIKE '%manager%'
GROUP BY es.occupation
HAVING avg_salary > 10000
;