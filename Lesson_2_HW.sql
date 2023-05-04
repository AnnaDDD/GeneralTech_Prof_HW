use hr;

SELECT salary 
FROM employees 
WHERE first_name = 'Lex' AND last_name = 'De Haan';

SELECT * 
FROM employees 
WHERE job_id = 'FI_ACCOUNT' AND salary < 8000;

SELECT * 
FROM employees 
WHERE last_name LIKE '%kk%' OR last_name LIKE '%ll%';

SELECT * 
FROM employees 
WHERE commission_pct IS NULL;

SELECT * 
FROM employees 
WHERE department_id <> 80 AND department_id <> 110;

SELECT * 
FROM employees 
WHERE salary BETWEEN 5000 AND 7000;

create database airplanes;

use airplanes;

SELECT model_name,
 CASE 
    WHEN range_value > 1000 AND range_value <= 2500 THEN 'short-haul'
    WHEN range_value > 2500 AND range_value <= 6000 THEN 'medium-haul'
    WHEN range_value > 6000 THEN 'long-haul'
  END 
  AS category
  FROM airliners;
  
SELECT model_name,
  CASE 
    WHEN COALESCE(range_value, 0) <= 1000 THEN 'UNDEFINED'
    WHEN COALESCE(range_value, 0) > 1000 AND COALESCE(range_value, 0) <= 2500 THEN 'short-haul'
    WHEN COALESCE(range_value, 0) > 2500 AND COALESCE(range_value, 0) <= 6000 THEN 'medium-haul'
    WHEN COALESCE(range_value, 0) > 6000 THEN 'long-haul'
    ELSE 'UNDEFINED'
  END 
  AS category
FROM airliners;

