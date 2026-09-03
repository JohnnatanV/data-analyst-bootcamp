SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;


-- Store Procedure Example
SELECT *
FROM employee_salary es
WHERE es.salary >= 50000
;

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary es
WHERE es.salary >= 50000
;

CALL large_salaries();

DROP PROCEDURE large_salaries;

DELIMITER $

CREATE PROCEDURE filter_salaries()
BEGIN
	SELECT * 
	FROM employee_salary es
	WHERE es.salary>=50000;
	SELECT *
	FROM employee_salary es
	WHERE es.salary <= 50000;
END $

DELIMITER ;

CALL filter_salaries;

DROP PROCEDURE IF EXISTS filter_salaries;

DELIMITER //

CREATE PROCEDURE filter_salary(
	IN p_salary INT
	)
BEGIN
	SELECT *
	FROM employee_salary es
	WHERE es.salary >= p_salary;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS apply_bonus;

CALL filter_salary(70000);


DROP PROCEDURE IF EXISTS filter_employee;
DELIMITER $
CREATE PROCEDURE filter_employee(p_gender VARCHAR(50), p_salary INT)
BEGIN
	SELECT es.first_name, ed.gender, es.salary
	FROM employee_salary es
	JOIN employee_demographics ed ON es.employee_id = ed.employee_id
	WHERE ed.gender = p_gender AND es.salary >= p_salary
	GROUP BY ed.gender, es.salary;
END $
DELIMITER ;

CALL filter_employee('male',50000);