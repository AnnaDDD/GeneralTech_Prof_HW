CREATE DATABASE telran_customers;
USE telran_customers;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(20),
    lastname VARCHAR(20),
    gender char(1) check(gender in ('f', 'm')),
    age integer
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    customerid integer,
    productid integer,
    ordertype varchar(128),
    product_count integer
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    title varchar(128),
    price numeric(8, 2)
);

INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (1, 3, 'online', 3);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (1, 2, 'online', 5);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (3, 1, 'direct', 2);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (3, 4, 'direct', 6);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (3, 3, 'direct', 3);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (1, 3, 'online', 4);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (5, 7, 'online', 2);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (5, 9, 'online', 7);
INSERT INTO orders (customerid, productid, ordertype, product_count) VALUES (6, 5, 'direct', 4);

INSERT INTO customers (name, lastname, age, gender) VALUES ('Гайк', 'Инанц', 29, 'm');
INSERT INTO customers (name, lastname, age, gender) VALUES ('Максим', 'Грибов', 32, 'm');
INSERT INTO customers (name, lastname, age, gender) VALUES ('Антон', 'Куликов', 27, 'm');
INSERT INTO customers (name, lastname, age, gender) VALUES ('Юрий', 'Митрофанов', 30, 'm');
INSERT INTO customers (name, lastname, age, gender) VALUES ('Нелли', 'Ефремян', 25, 'f');
INSERT INTO customers (name, lastname, age, gender) VALUES ('Ольга', 'Степанова', 35, 'f');

INSERT INTO products (title, price) VALUES ('молоко', 70);
INSERT INTO products (title, price) VALUES ('колбаса', 230);
INSERT INTO products (title, price) VALUES ('хлопья', 150);
INSERT INTO products (title, price) VALUES ('хлеб', 30);
INSERT INTO products (title, price) VALUES ('масло', 120);
INSERT INTO products (title, price) VALUES ('чипсики', 60);
INSERT INTO products (title, price) VALUES ('шоколад', 70);
INSERT INTO products (title, price) VALUES ('кетчуп', 150);
INSERT INTO products (title, price) VALUES ('яблоко', 70);

-- 1) найдите имя и фамилию пользователей, у которых нет заказов

SELECT 
	customers.name, 
	customers.lastname
FROM customers 
LEFT JOIN orders 
ON customers.id = orders.customerid
WHERE orders.id IS NULL;

-- 2) найдите название товаров, которые ни разу не заказывали

SELECT 
	title
FROM products
LEFT JOIN orders 
ON products.id = orders.productid
WHERE orders.id IS NULL;

-- 3) найдите название товаров, которые ни разу не заказывали онлайн

SELECT 
	title
FROM products
LEFT JOIN orders 
ON products.id = orders.productid
WHERE orders.ordertype IS NULL OR orders.ordertype <> 'online';

-- 4) найдите имя и фамилию покупателя, который сделал самый дорогой заказ

SELECT 
	c.name, 
	c.lastname
FROM customers c
JOIN orders o 
ON c.id = o.customerid
ORDER BY (o.product_count * (SELECT price FROM products WHERE id = o.productid)) DESC
LIMIT 1;



