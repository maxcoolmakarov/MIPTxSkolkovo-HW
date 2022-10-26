--INSERT
--Без указания списка полей INSERT INTO table_name VALUES (value1, value2, value3, ...);"
INSERT INTO author
VALUES (0, 'Fedor Dostoevsky', '12-12-1812', 'Russia'), (1,'Stephen King', '21-09-1947', 'USA');
--С указанием списка полей INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...)
INSERT INTO book (title, author, author_id, annotation) 
VALUES ('Crime and punishment', 'Fedor Dostoevsky', 0, 'Babushki Bla bla bla'), ('IT', 'Stephen King', 1, 'One of the best...');
--С чтением значения из другой таблицыINSERT INTO table2 (column_name(s)) SELECT column_name(s) FROM table1;
INSERT INTO book (author) SELECT name FROM author;

INSERT INTO author
VALUES (3, 'Pavil Sanaev', '12-12-1972', 'Russia');

INSERT INTO publisher
VALUES(0,'OOO Moia Oborona', 'Russia', 'Ploshad vostaniya 28');

INSERT INTO books_publisher
VALUES (6, 0);



--DELETE
--All
TRUNCATE TABLE author cascade
--With condition
DELETE FROM book WHERE author_id = 0;

--UPDATE
--Всех записе
UPDATE book 
SET annotation = 'Best books ever';

--По условию обновляя один атрибут
UPDATE book SET author_id = 1 WHERE author = 'Stephen King';

--Поусловиюобновляянесколькоатрибутов
UPDATE book SET author_id = 0, title = 'Sobranie sochenehiy' WHERE author = 'Fedor Dostoevsky' and title is null

--SELECT
--С набором извлекаемых атрибутов (SELECTatr1, atr2 FROM...)
SELECT author_id, author FROM book;
--Со всеми атрибутами (SELECT* FROM...)
SELECT * FROM author;
--Сусловиемпоатрибуту(SELECT * FROM ... WHERE atr1 = value)
SELECT * FROM BOOK WHERE author_id = 0;

--3.5. SELECT ORDER BY + TOP (LIMIT)
--С сортировкой по возрастанию ASC + ограничение вывода количества записе
SELECT * FROM book ORDER BY title LIMIT 3;
--С сортировкой по убыванию DESC
SELECT * FROM book ORDER BY title DESC;
--С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT CONCAT(author, '-', title) AS d
FROM book ORDER BY d;
--С сортировкой по первому атрибуту, из списка извлекаемых
SELECT title, author, annotation FROM book ORDER BY 1;

--DATA
--WHERE по дате
SELECT * FROM author WHERE date_of_birth < '01.01.2000';
--WHERE дата в диапазоне
SELECT * FROM author WHERE date_of_birth BETWEEN '03.03.1900' AND '01.01.2000'
--Uзвлечь из таблицы не всю дату, а только год
SELECT extract (year from date_of_birth) FROM author;

--Functions and agragators
--Посчитать количество записей в таблице
SELECT COUNT(title) as number_of_books FROM book;
--Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT author) as number_of_authors FROM book;
--Вывести уникальные значения столбц
SELECT DISTINCT author FROM book;
--Найти максимальное значение столбца
SELECT MAX(id) FROM author;
--Найти минимальное значение столбца
SELECT MIN(id) FROM author;
--Написать запрос COUNT() + GROUP BY
SELECT author, COUNT(title) FROM book GROUP BY author;

--Select + Having
SELECT COUNT(title) as number_of_books FROM book 
GROUP BY author_id HAVING author_id = 1;

SELECT COUNT(name), date_of_birth FROM author
GROUP BY date_of_birth HAVING  COUNT(name)>1;

SELECT store, SUM(amount) as total_book_number FROM books_in_store
GROUP BY store HAVING SUM(amount) > 10



--JOIN
--LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT * FROM author LEFT JOIN book ON author.name = book.author WHERE country = 'USA';
--RIGHT JOIN. Получить такую же выборку, как и в 3.9a
SELECT * FROM author RIGHT JOIN book ON author.name = book.author;
--LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT * FROM author
LEFT JOIN book ON author.name = book.author
LEFT JOIN books_publisher ON book.id = books_publisher.book
WHERE publisher is not null;
--INNERJOIN двух таблиц
SELECT * FROM author
INNER JOIN book ON author.name = book.author;

--SUBQUERIES
--Написать запрос сусловиемWHERE IN (подзапрос)
SELECT * FROM author
WHERE author.name IN 
	(SELECT author FROM book);
--Написать запрос SELECT atr1, atr2, (подзапрос) FROM ..	
SELECT 
	author.id, 
	(SELECT name FROM author AS a WHERE author.id = a.id) AS name
FROM author
--Написать запрос вида SELECT* FROM(подзапрос)
SELECT * FROM (SELECT name FROM author) AS lll
--НаписатьзапросвидаSELECT * FROM table JOIN (подзапрос)ON 
SELECT * FROM author JOIN ( SELECT * FROM book ) AS book ON author.COUNTRY = 'USA'
 
