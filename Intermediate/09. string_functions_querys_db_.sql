SELECT *
FROM employee_salary es;

SELECT *
FROM employee_demographics ed;

SELECT *
FROM parks_departments pd;


-- String Function

-- Length
SELECT LENGTH('Paranguacutirimicuaro');

SELECT ed.first_name , LENGTH(ed.first_name)
FROM employee_demographics ed ;

-- Mas util para verificar cantidad de caracteres en datos, numeros de telefono o numeros de cuentas

-- Upper y Lower
SELECT UPPER('Nombre');

SELECT ed.first_name , UPPER(ed.first_name )
FROM employee_demographics ed ;

SELECT LOWER('ApeLliDo');
-- Util para hacer estandarizaciones de texto

-- Trim

SELECT TRIM('       Trim      '), '                     Espacio      ', 'Sin espacio';
-- Ayuda a limpiar el texto que este mal espaciado tambien con las variantes de RTRIM y LTRIM

-- Left y Right

SELECT ed.first_name, 
	LEFT(ed.first_name, 3),
	RIGHT(ed.first_name, 3)
FROM employee_demographics ed ;

-- Substrings

SELECT ed.first_name ,
	SUBSTRING(ed.first_name, 1, 3),
	SUBSTRING(ed.first_name, 3, 6),
	ed.birth_date,
	SUBSTRING(ed.birth_date,6,2 ) birth_month
FROM employee_demographics ed ;

-- Replace

SELECT ed.first_name, REPLACE(ed.first_name, 'A', 'z')
FROM employee_demographics ed ;

-- Locate

SELECT ed.first_name, LOCATE('An', ed.first_name)
FROM employee_demographics ed ;

-- Concat

SELECT ed.first_name, ed.last_name,
CONCAT(ed.first_name,' ',ed.last_name) full_name
FROM employee_demographics ed ;