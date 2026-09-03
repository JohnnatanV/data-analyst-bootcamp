SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;


CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(50)
);

SELECT *
FROM temp_table
;

INSERT INTO temp_table
VALUES('Johnnatan', 'Villaneda', 'Gladiator');

SELECT *
FROM temp_table
;

SELECT * FROM employee_salary es;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT * FROM salary_over_50k;
