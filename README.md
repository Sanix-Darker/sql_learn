# SQL CLI USEFULL TO KNOW

> S: Structured
> Q: Query
> L: Language

> DBMS (Database Management System)

NOTE : Never forget the `;` at the end of the command.

- To connect inside mysql database:

```bash
mysql -u root -p password
```

### DATABASES

- To list databases
```sql
SHOW DATABASES;
```

- To Create the database
```sql
CREATE DATABASE test_db;
```

- To delete that database
```sql
DROP DATABASE test_db;
```

- To use a database:
```sql
USE test_db;
```

- It's possible to Alter a database
```sql
ALTER DATABASE test_db READ ONLY = 1;
-- no modif... just access to it.
-- so the DROP will not work.
-- to reset rerun the ALTER query with ONLY = 0;
```

### TABLES

- To create a new table:
```sql
CREATE TABLE `table_x`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `age` INT NOT NULL,
    `date` VARCHAR(15),
    PRIMARY KEY (id)
);
```

- To show tables:
```sql
SHOW TABLES;
```

- To describe the structure of a table:
```sql
DESCRIBE `table_1`;
```

- To insert a new row inside a table :
```sql
INSERT INTO `table_x VALUES(1, 'darker', 27, '2021/07/30')`
```

- To Select everything from the table :
```sql
SELECT * FROM `table_x`
```

- To prevent duplication when we are fetching elements:
```sql
SELECT DISTINCT `age` FROM `people`
```

- The `WHERE` clause for conditions and/or:
```sql
-- With some interesting operators
SELECT * FROM `people` FROM `people` WHERE `age`<28 AND (`points` > 12 OR `sub_points` <= 12) AND `name` LIKE 'd%';

-- another interesting keywords
SELECT * FROM `students` WHERE `age` BETWEEN 20 AND 22;

-- Fetch with updates on the output
SELECT name, (marks-10) as `new_marks` FROM students WHERE val=12;
```
- For many insertions:
```
INSERT INTO table VALUES ('elt'), ('elt2'), ('elt3');

-- or smarter
INSERT INTO table (col1, col2) VALUES("ok", "ok2");
```

- For updates
```sql
UPDATE table_x SET columnx="element" WHERE columny="another-thing";
```

- FOr the deletes
```sql
DELETE FROM target WHERE column="xxx";
```

### JOIN, INNER_JOIN, OUTER_JOIN(left, right, full), CROSS_JOIN

```sql
SELECT * FROM table1 INNER JOIN table2 ON table1.col1=table2.col2;
-- we can also do LEFT JOIN and RIGHT JOIN

-- we got a lot of output but in the LEFT, and the RIGHT are NUll if there are not existing
SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.col1=table2.col2;
-- Same logic wih the RIGHT OUTER JOIN


-- The FULL is a combination of the LEFT and the RIGHT using UNION
SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.col1=table2.col2 UNION SELECT * FROM table2 RIGHT OUTER JOIN table2 ON table1.col1=table2.col2;

-- The cross join select for each element all link to the second table
SELECT * FROM table1 CROSS JOIN table2;
```


### OPERATORS
```sql
-- AVG for the avrage
SELECT AVG(col1) as `avg_col` FROM table1;

-- COUNT for the count
SELECT COUNT(*) AS count_all FROM table1;

-- MIN / MAX
SELECT MIN(col1) AS min_col FROM table1;

-- SUM
SELECT SUM(col1) AS sum_col FROM table1;

-- UCASE / LCASE (For uppercase string in a column and lower case it)
SELECT * FROM UCASE(col1) as ucase_col1 FROM table1;

-- MID to cut the string we'r getting, as parameter
-- (the column, the start point and the number of characters, we want to cut from)
SELECT MID(firstname, 1, 4) as nn FROM table1;

-- TO Calculate the lenght of a column
SELECT LENGTH(firstname) as length FROM table1;
```

### CONSTRAINTS

```sql
UNIQUE
NOT NULL
DEFAULT ''
```

### PRIMARY KEY / FOREIGN KEY

```sql
-- We create the database
CREATE DATABASE shop;
-- We select it to use it
USE shop;

-- We create the table
CREATE TABLE IF NOT EXISTS customers(
    customer_id INT NOT NULL AUTO_INCREMENT,

    name VARCHAR(20),
    location VARCHAR(30),

    PRIMARY KEY (customer_id)
);

INSERT INTO customers (name, location) VALUES("tangua", "cameroun");

SELECT * FROM customers;
SELECT * FROM customers WHERE location IN ("france", "usa");

CREATE TABLE IF NOT EXISTS products(
    product_id INT NOT NULL AUTO_INCREMENT,

    name VARCHAR(20) NOT NULL,
    description VARCHAR(100) DEFAULT "Product description",

    PRIMARY KEY(product_id)
);

INSERT INTO products (name, description) VALUES("VABOUM", "short and quite range");
SELECT * FROM products;

ALTER TABLE products
RENAME COLUMN product_id TO pid;

DROP TABLE orders;
-- And we link them
CREATE TABLE orders(
    oid INT NOT NULL AUTO_INCREMENT,

    product_id INT NOT NULL,
    quantity INT(10) NOT NULL,
    customer_id INT NOT NULL,

    PRIMARY KEY (oid),
    FOREIGN KEY (customer_id) REFERENCES customers(cid),
    FOREIGN KEY (product_id) REFERENCES products(pid)
);

SELECT * FROM orders;
INSERT INTO orders(product_id, quantity, customer_id) VALUES(1, 12, 1);
INSERT INTO orders(product_id, quantity, customer_id) VALUES(3, 10, 2);
INSERT INTO orders(product_id, quantity, customer_id) VALUES(2, 3, 1);

SELECT
    c.name AS user,
    p.name AS product,
    o.quantity AS quantity
FROM orders o
LEFT OUTER JOIN products p ON o.product_id = p.pid
LEFT OUTER JOIN customers c ON o.customer_id = c.cid
ORDER BY o.quantity ASC;

-- LEFT OUTER JOIN (with no NULL NULL items)
-- RIGHT OUTER JOIN (with NULL NULL items allowed)
-- ON same as WHERE

```

### ALTER A TABLE

```sql
-- to add a new column
ALTER TABLE target
ADD COLUMN columnx INT(10) NOT NULL AFTER columny;

-- or to add a foreign key
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

-- to rename also a column
ALTER TABLE customers
RENAME COLUMN c_id TO cid;
```

### EXTRATS

```sql
-- to order by something and we can reverse with DESC
ORDER BY attr (DESC/ASC)-- we can order with multiple attributes
LIMIT 3
WHERE attr IN ('test', 'test2')

-- We can also use REGEXP
SELECT * FROM employee WHERE REGEXP 'field|mac|rose'
-- or '[gim]e' means ie ge me
-- or '[a-h]e' a or b or c ...h with e

SELECT LAST_INSERT_ID();
```

### TRIGGERS

```sql
DELIMITTER $$
CREATE
    TRIGGER triggerx....

    END$$
DELIMITTER ;
