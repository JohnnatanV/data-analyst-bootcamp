SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM employee_salary es
WHERE es.salary <= 50000;

SELECT *
FROM employee_demographics ed
WHERE gender != 'female';

SELECT *
FROM employee_demographics ed
WHERE ed.birth_date > '1985-01-01';

SELECT *
FROM employee_demographics ed
WHERE ed.birth_date > '1985-01-01'
AND ed.gender = 'male';

SELECT
	*
FROM
	employee_demographics ed
WHERE
	ed.birth_date > '1985-01-01'
	OR ed.gender != 'male';

SELECT
	*
FROM
	employee_demographics ed
WHERE
	ed.birth_date > '1985-01-01'
	OR NOT ed.gender = 'male';


SELECT *
FROM employee_demographics ed
WHERE (ed.first_name = 'Leslie' and age = 44) OR age > 55
;

SELECT *
FROM employee_demographics ed 
WHERE ed.first_name = 'Jerry';

-- Like Statement
-- %
SELECT *
FROM employee_demographics ed 
WHERE ed.first_name LIKE 'Jer%';

SELECT *
FROM employee_demographics ed 
WHERE ed.first_name LIKE '%er%';

SELECT *
FROM employee_demographics ed 
WHERE ed.first_name LIKE 'a%';

SELECT *
FROM employee_demographics ed 
WHERE ed.first_name LIKE 'a__';

SELECT *
FROM employee_demographics ed 
WHERE ed.first_name LIKE 'a___';

SELECT *
FROM employee_demographics ed 
WHERE ed.first_name LIKE 'a___%';

SELECT *
FROM employee_demographics ed 
WHERE ed.birth_date LIKE '1989%';


SELECT *
FROM employee_demographics ed 
WHERE ed.first_name LIKE '%n_';
