SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;

-- Triggers
DELIMITER $
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
	FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Ralph', 'Wiggum', 'Entertainment CEO', 1000000,NULL);

-- Events
SET GLOBAL event_scheduler=ON;
DELIMITER $
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
	DELETE 
	FROM employee_demographics ed
	WHERE ed.age >= 60;
END $
DELIMITER ;

DROP EVENT delete_retirees;

SHOW VARIABLES LIKE 'event%';
