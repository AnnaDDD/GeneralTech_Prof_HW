use hr;

-- 1. Найти департаменты в которых есть работники, зарабатывающие больше 10 000. 
-- В результате выборки формируются два поля (department_id и поле со значениями 1 или 0) (использовать метод max)

SELECT department_id, MAX(CASE WHEN salary > 10000 THEN 1 ELSE 0 END) AS has_high_salary
FROM employees
GROUP BY department_id;

-- 2. Найти департаменты в которых все работники зарабатывают больше 10 000. 
-- В результате выборки формируются два поля (department_id и поле со значениями 1 или 0)  (использовать метод min)

SELECT department_id, MIN(CASE WHEN salary <= 10000 THEN 0 ELSE 1 END) AS all_high_salary
FROM employees
GROUP BY department_id;

-- 3. Отсортировать сотрудников по фамилии в алфавитном порядке.

SELECT *
FROM employees
ORDER BY last_name ASC;

-- 4. Отсортировать сотрудников по зарплате - от самой большой зарплаты до самой маленькой

SELECT *
FROM employees
ORDER BY salary DESC;

-- 5*. Вывести сотрудников, работающих в департаментах с id 60, 90 и 110, отсортированными в алфавитном порядке по фамилии (оператор in).

SELECT *
FROM employees
WHERE department_id IN (60, 90, 110)
ORDER BY last_name ASC;

-- 6. Вывести сотрудников с job_id ST_CLERK, отсортированными по зарплате - от самой большой зарплаты до самой маленькой.

SELECT *
FROM employees
WHERE job_id = 'ST_CLERK'
ORDER BY salary DESC;

-- 7. Вывести сотрудников, чьи имена начинаются на букву D и отсортировать их в алфавитном порядке по фамилии.

SELECT *
FROM employees
WHERE first_name LIKE 'D%'
ORDER BY last_name ASC;

-- 1. На основе БД airplanes.
-- Выведите данные о билетах разной ценовой категории. 
-- Среди билетов экономкласса (Economy) добавьте в выборку билеты с ценой от 10 000 до 11 000 включительно. 
-- Среди билетов комфорт-класса (PremiumEconomy) — билеты с ценой от 20 000 до 30 000 включительно. 
-- Среди билетов бизнес-класса (Business) — с ценой строго больше 100 000. 
-- В решении необходимо использовать оператор CASE.
-- В выборке должны присутствовать три атрибута — id, service_class, price.

use airplanes;

SELECT
  id,
  service_class,
  price
FROM
  tickets
WHERE
  CASE
    WHEN service_class = 'Economy' THEN price BETWEEN 10000 AND 11000
    WHEN service_class = 'PremiumEconomy' THEN price BETWEEN 20000 AND 30000
    WHEN service_class = 'Business' THEN price > 100000
  END;

-- 2. Разделите самолеты на три класса по возрасту. Если самолет произведен раньше 2000 года, то отнесите его к классу 'Old'. 
-- Если самолет произведен между 2000 и 2010 годами включительно, то отнесите его к классу 'Mid'. Более новые самолеты отнесите к классу 'New'. 
-- Исключите из выборки дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. Отсортируйте выборку по классу возраста в порядке возрастания.
-- В выборке должны присутствовать два атрибута — side_number, age.

SELECT
  side_number,
  CASE
    WHEN production_year < 2000 THEN 'Old'
    WHEN production_year BETWEEN 2000 AND 2010 THEN 'Mid'
    ELSE 'New'
  END AS age
FROM
  airliners
WHERE
  range_value <= 10000
ORDER BY
  age ASC;
  
-- 3. Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%.
-- Определите цену билета в каждом сегменте с учетом скидки.
-- В выборке должны присутствовать три атрибута — id, trip_id, newprice.

SELECT
  id,
  trip_id,
  CASE
    WHEN service_class = 'Economy' THEN price * 0.85
    WHEN service_class = 'Business' THEN price * 0.9
    WHEN service_class = 'PremiumEconomy' THEN price * 0.8
    ELSE price
  END AS newprice
FROM
  tickets
WHERE
  trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G');
  
  -- 4. Создайте таблицу goods (id, title, quantity)
  
  CREATE TABLE goods (
  id VARCHAR(128) PRIMARY KEY ,
  title VARCHAR(128),
  quantity INTEGER
);

-- 5, 6. Добавьте поле price (integer) со значением по умолчанию 0. Проверьте содержимое таблицы.

ALTER TABLE goods
ADD COLUMN price INTEGER DEFAULT 0;

SELECT * FROM goods;

-- 7. Сделайте удаление, изменение, добавление полей в таблице.

ALTER TABLE goods
DROP COLUMN quantity;

ALTER TABLE goods
MODIFY COLUMN title VARCHAR(256);

ALTER TABLE goods
ADD country_of_origin VARCHAR(128);

-- 8. Удалите таблицу.

DROP TABLE IF EXISTS goods;

-- 9. Заново создайте, добавьте данные и на ее основе создайте новую таблицу.

CREATE TABLE goods (
  id VARCHAR(128) PRIMARY KEY,
  title VARCHAR(128),
  quantity INTEGER,
  price INTEGER,
  country_of_origin VARCHAR(128)
);
INSERT INTO goods (id, title, quantity, price, country_of_origin)
VALUES
  ('1', 'Pants', 10, 100, 'Germany'),
  ('2', 'Dress', 5, 200, 'Russia'),
  ('3', 'Sweater', 15, 150, 'USA');
CREATE TABLE new_goods AS
SELECT *
FROM goods;

SELECT * FROM new_goods;



















