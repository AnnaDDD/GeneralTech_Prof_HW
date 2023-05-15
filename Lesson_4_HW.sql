-- use learn;
-- 1. Создать таблицу students с полями: name (не null), lastname (не null), 
-- avg_mark(от 0 до 5), gender varchar(128) (или "M" или "F") (использовать оператор "in")

CREATE TABLE students (
    name VARCHAR(128) NOT NULL,
    lastname VARCHAR(128) NOT NULL,
    avg_mark NUMERIC(2,1) CHECK (avg_mark BETWEEN 0 AND 5),
    gender VARCHAR(128) CHECK (gender IN ('M', 'F'))
);

SELECT * FROM students;

-- 2. Добавить 5 записей студентов. Олег Петров 4.3 М, Семен Степанов 3.1 М, 
-- Ольга Семенова 4.7 F, Игорь Романов 3.1 М, Ирина Романова 2.2 F

INSERT INTO students (name, lastname, avg_mark, gender) VALUES  ('Олег', 'Петров', 4.3, 'M'), 
																('Семен', 'Степанов', 3.1, 'M'), 
																('Ольга', 'Семенова', 4.7, 'F'), 
																('Игорь', 'Романов', 3.1, 'M'), 
																('Ирина', 'Романова', 2.2, 'F');


-- 3. Добавить поле id integer primary key auto_increment
--  Поменять тип у gender на char(1)
--  переименовать поле name на firstname

ALTER TABLE students
ADD COLUMN id INTEGER PRIMARY KEY AUTO_INCREMENT;
SELECT * FROM students;

ALTER TABLE students
MODIFY gender VARCHAR(1);

ALTER TABLE students CHANGE name firstname VARCHAR(128);
SELECT * FROM students;

-- 4.
-- - найти учеников, у которых оценка больше 4
-- - найти учеников, у которых не входит в диапазон от 3 до 4
-- - найти учеников, у которых имя начинается на И
-- - найти учеников, у которых оценка 2.2 или 3.1 или 4.7   

SELECT * FROM students WHERE avg_mark > 4;
SELECT * FROM students WHERE avg_mark NOT BETWEEN 3 AND 4;
SELECT * FROM students WHERE firstname LIKE 'И%';
SELECT * FROM students WHERE avg_mark IN (2.2, 3.1, 4.7);

-- 5.Создать представление, которое содержит всех мужчин

CREATE VIEW v_students_m AS
SELECT * FROM students WHERE gender = 'M';

-- 6. Создать представление, которое содержит всех женщин
CREATE VIEW v_students_f AS
SELECT * FROM students WHERE gender = 'F';


-- Homework
-- 1.  Найти набор уникальных оценок

SELECT DISTINCT avg_mark FROM students;

-- 2.  Увеличить всем учащимся оценку в 10 раз
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE students MODIFY avg_mark NUMERIC(3,1);
ALTER TABLE students DROP CHECK students_chk_1;
UPDATE students SET avg_mark = avg_mark * 10;
SELECT * FROM students;

-- 3.  Поменяйте у Олега Петрова фамилию на Сидоров

UPDATE students SET lastname = 'Сидоров' 
WHERE firstname = 'Олег' AND lastname = 'Петров';

-- 4.  Для всех учеников, у которых оценка не больше 31 увеличить на 10

UPDATE students
SET avg_mark = avg_mark + 10
WHERE avg_mark <= 31;
SELECT * FROM students;