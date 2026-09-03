SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;


SELECT gender, COUNT(ed.gender)
FROM employee_demographics ed
GROUP BY gender;

SELECT gender, AVG(age)
FROM employee_demographics ed 
GROUP BY gender;

select occupation, count(es.occupation)
from employee_salary es
group by occupation;

-- ORDER BY

select *
from employee_demographics ed
order by age DESC;

SELECT * from employee_demographics ed 
order by gender, age;


SELECT * from employee_demographics ed 
order by gender, age desc;

SELECT * from employee_demographics ed 
order by 5, 4 DESC ;