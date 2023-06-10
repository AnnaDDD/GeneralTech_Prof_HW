create database homework;
use homework;

CREATE TABLE Students (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  age INTEGER
);

CREATE TABLE Teachers (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  age INTEGER
);

CREATE TABLE Competencies (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(128) NOT NULL
);

CREATE TABLE Teachers2Competencies (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  teacher_id INTEGER,
  competencies_id INTEGER
);

CREATE TABLE Courses (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  teacher_id INTEGER,
  title VARCHAR(128) NOT NULL,
  headman_id INTEGER
);

CREATE TABLE Students2Courses (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  student_id INTEGER,
  course_id INTEGER
);

INSERT INTO Students (name, age) VALUES ('Анатолий', 29),
										('Олег', 25),
										('Семен', 27),
										('Олеся', 28),
										('Ольга', 31),
										('Иван', 22);

INSERT INTO Teachers (name, age) VALUES ('Петр', 39),
										('Максим', 35),
										('Антон', 37),
										('Всеволод', 38),
										('Егор', 41),
										('Светлана', 32);

INSERT INTO Competencies (title) VALUES ('Математика'),
										('Информатика'),
										('Программирование'),
										('Графика');

INSERT INTO Teachers2Competencies (teacher_id, competencies_id) VALUES (1, 1),
																	   (2, 1),
																	   (2, 3),
																       (3, 2),
																       (4, 1),
																       (5, 3);

INSERT INTO Courses (teacher_id, title, headman_id) VALUES (1, 'Алгебра логики', 2),
														   (2, 'Математическая статистика', 3),
														   (4, 'Высшая математика', 5),
														   (5, 'Javascript', 1),
														   (5, 'Базовый Python', 1);

INSERT INTO Students2Courses (student_id, course_id) VALUES (1, 1),
														    (2, 1),
														    (3, 2),
														    (3, 3),
														    (4, 5);

-- **Задачи**

-- 1) Вывести имена студентов и курсы, которые они проходят

SELECT 
Students.name, 
Courses.title
FROM Students
INNER JOIN Students2Courses 
ON Students.id = Students2Courses.student_id
INNER JOIN Courses 
ON Students2Courses.course_id = Courses.id;


-- 2) Вывести имена всех преподавателей с их компетенциями

SELECT 
Teachers.name AS teacher_name, 
Competencies.title AS competency_title
FROM Teachers
INNER JOIN Teachers2Competencies 
ON Teachers.id = Teachers2Competencies.teacher_id
INNER JOIN Competencies 
ON Teachers2Competencies.competencies_id = Competencies.id;

-- 3) Найти преподавателя, у которого нет компетенций

SELECT 
Teachers.name AS teacher_name
FROM Teachers
LEFT JOIN Teachers2Competencies 
ON Teachers.id = Teachers2Competencies.teacher_id
WHERE Teachers2Competencies.teacher_id IS NULL;

-- 4) Найти имена студентов, которые не проходят ни один курс

SELECT 
Students.name AS student_name
FROM Students
LEFT JOIN Students2Courses 
ON Students.id = Students2Courses.student_id
WHERE Students2Courses.student_id IS NULL;

-- 5) Найти курсы, которые не посещает ни один студент

SELECT Courses.title AS course_title
FROM Courses
LEFT JOIN Students2Courses 
ON Courses.id = Students2Courses.course_id
WHERE Students2Courses.course_id IS NULL;

-- 6) Найти компетенции, которых нет ни у одного преподавателя

SELECT 
Competencies.title
FROM Competencies
LEFT JOIN Teachers2Competencies 
ON Competencies.id = Teachers2Competencies.competencies_id
WHERE Teachers2Competencies.competencies_id IS NULL;

-- 7) Вывести название курса и имя старосты

SELECT 
Courses.title AS course_title, 
Students.name AS headman_name
FROM Courses
JOIN Students 
ON Courses.headman_id = Students.id;

-- 8) Вывести имя студента и имена старост, которые есть на курсах, которые он проходит

SELECT 
Students.name AS student_name, 
Headmen.name AS headman_name
FROM Students
JOIN Students2Courses 
ON Students.id = Students2Courses.student_id
JOIN Courses 
ON Students2Courses.course_id = Courses.id
JOIN Students AS Headmen 
ON Courses.headman_id = Headmen.id;




