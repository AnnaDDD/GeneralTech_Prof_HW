use hr;

-- 1) Найти количество сотрудников в каждом департаменте. Вывести department_id и employees_cnt

SELECT 
	department_id, 
	COUNT(*) AS employees_cnt
FROM 
	employees
GROUP BY department_id;

-- 2) Найти количество сотрудников в каждом департаменте. Вывести department_name и employees_cnt

SELECT 
	departments.department_name, 
	COUNT(employees.employee_id) AS employees_cnt
FROM 
	employees
JOIN 
	departments 
ON 
	employees.department_id = departments.department_id
GROUP BY departments.department_name;

-- 3) Найти количество сотрудников у каждого менеджера. Вывести manager_id и employees_cnt

SELECT 
	manager_id, 
COUNT(*) AS employees_cnt
FROM 
	employees
GROUP BY manager_id;

-- 4) Найти количество сотрудников у каждого менеджера. Вывести firstname, lastname и employees_cnt

SELECT 
    managers.first_name, 
    managers.last_name, 
    COUNT(employees.employee_id) AS employees_cnt
FROM 
    employees
JOIN 
    employees AS managers ON employees.manager_id = managers.employee_id
GROUP BY 
    managers.employee_id, 
    managers.first_name, 
    managers.last_name;

-- 5) Найти максимальную зарплату в каждом департаменте. Вывести department_id и max_salary

SELECT 
	department_id, 
MAX(salary) AS max_salary
FROM 
	employees
GROUP BY department_id;

-- 6) Найти сотрудников, у которых наибольшая зарплата в их департаменте

SELECT 
	employees.employee_id, 
	employees.first_name, 
	employees.last_name, 
	employees.salary, 
	departments.department_name
FROM 
	employees
JOIN 
	departments 
ON 
	employees.department_id = departments.department_id
WHERE 
	employees.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE employees.department_id = departments.department_id
)




