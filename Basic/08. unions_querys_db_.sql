SELECT *
FROM employee_salary es;

SELECT ed.first_name, ed.last_name  
FROM employee_demographics ed
UNION 
SELECT es.first_name, es.last_name 
FROM employee_salary es 
;

SELECT ed.first_name, ed.last_name , 'Old Man' Label
FROM employee_demographics ed
WHERE ed.age > 50 AND ed.gender = 'Male'
UNION 
SELECT ed.first_name, ed.last_name , 'Old Lady' Label
FROM employee_demographics ed
WHERE ed.age > 40 AND ed.gender = 'Female'
UNION
SELECT es.first_name, es.last_name , 'Highly Paid Salary' Label
FROM employee_salary es 
WHERE es.salary > 70000
;