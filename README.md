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
-- no modif... just access to it (read only).
-- so the DROP will not work.
-- to reset rerun the ALTER query with ONLY = 0;
```

### TABLES

- To create a new table:
```sql
CREATE TABLE `table_x`(
    `id` INT AUTO_INCREMENT,  -- PRIMARY KEY,
    `name` VARCHAR(30) NOT NULL,
    `age` INT NOT NULL,
    `date` DATE,
    -- 5 is the maximum digit and 2 the precision.
    `price` DECIMAL(5, 2),

    PRIMARY KEY (id)
);
```

NOTE `PRIMARY KEY` == `UNIQUE` and `NOT NULL`
(so no need to specify that twice).

- To show tables:
```sql
SHOW TABLES;
```

- To describe the structure of a table:
```sql
DESCRIBE `table_1`;
```

- To list columns from a table:
```sql
SELECT column_name, data_type FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = "titi";
```

- To rename a table
```sql
RENAME TABLE table_1 TO table_11;
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

- The `WHERE` clause for conditions and/or... LIKE or BETWEEN:
```sql
-- With some interesting operators
SELECT * FROM `people` FROM `people` WHERE `age`<28 AND (`points` > 12 OR `sub_points` <= 12) AND `name` LIKE 'd%';

-- Instead of %, we can also use __
SELECT * FROM test WHERE xxx LIKE "___-02-__";

-- another interesting keywords
SELECT * FROM `students` WHERE `age` BETWEEN 20 AND 22;

-- Fetch with updates on the output
SELECT name, (marks-10) as `new_marks` FROM students WHERE val=12;
```

- For many insertions:

```sql
INSERT INTO table VALUES ('elt'), ('elt2'), ('elt3');

-- or smarter
INSERT INTO table (col1, col2) VALUES("ok", "ok2");
```

- For updates
```sql
UPDATE table_x SET columnx="element" WHERE columny="another-thing";

-- to update multiple columns at the same time :
UPDATE table_x
SET col1 = "aaa", col2 = "bbb"
WHERE col3 = 1;

-- We can also update a whole column independantly of a specific line
UPDATE table_y
SET col_z = "aox"
-- no WEHRE clause
```

- For the deletes
```sql
DELETE FROM target WHERE column="xxx";

-- if WHERE clause is missing it will delete all rows;
```

### JOIN, INNER_JOIN, OUTER_JOIN(left, right, full), CROSS_JOIN

```sql
SELECT * FROM table1 INNER JOIN table2 ON table1.col1=table2.col2;
-- we can also do LEFT JOIN and RIGHT JOIN

-- we got a lot of output but in the LEFT, and the RIGHT are NUll if there are not existing
SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.col1=table2.col2;
-- Same logic wih the RIGHT OUTER JOIN

-- The FULL is a combination of the LEFT and the RIGHT using UNION
SELECT *
FROM table1
LEFT OUTER JOIN table2
    ON table1.col1=table2.col2
UNION
    SELECT * FROM table2
        RIGHT OUTER JOIN table2
    ON table1.col1=table2.col2;

-- We can display two tables besides as soon as they have the same amount of columns.
-- With the UNION key.
SELECT tid, sess FROM tracked
UNION
SELECT cid, name  FROM customers;

-- UNION does not inclue duplicated, but 'UNION ALL' allow duplicated values.

-- We can also do SELF JOIN by joining a table by it's own clone
-- For example :
SELECT
    a.name, a.code, CONCAT(b.name, " ", b.code) AS "from"
FROM customers a
-- LEFT JOIN/ RIGHT JOIN(to take into account left or right side admiting empty values)
INNER JOIN customers b
ON a.c_id = b.referral_id;

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

-- To Calculate the lenght of a column
SELECT LENGTH(firstname) as length FROM table1;

-- For Concatenation
SELECT CONCAT(col1, col2) AS CONCAT_COL FROM table1;
-- we can also CONCAT(col1, "delimiter", col2)
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

```

### ALTER A TABLE

```sql
-- to add a new column
ALTER TABLE target
ADD COLUMN columnx INT(10) NOT NULL AFTER columny;

-- And to drop a column
ALTER TABLE target
DROP COLUMN columnx;

-- Or to add a foreign key
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
-- or
ALTER TABLE Orders
ADD CONSTRAINT xxx_2
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

-- It's also possible to drop a FOREIGH KEY
-- only if we have its name;
ALTER TABLE Orders
DROP FOREIGH KEY xxx_2;

-- to add a specific constraints to a column
ALTER TABLE Orders
ADD CONSTRAINT UNIQUE(column_y);

-- to add a primary key constraint
ALTER TABLE tracked
ADD CONSTRAINT
PRIMARY KEY(column_x);

-- to rename also a column
ALTER TABLE customers
RENAME COLUMN c_id TO cid;

-- to modify a column data type already set
ALTER TABLE customers
MODIFY COLUMN xxx VARCHAR(100);

-- We can also move a column from its original order
-- considering | name | age | date |
-- To move `date` before `age` :
ALTER TABLE customers
MODIFY age INT
AFTER name; -- Or for it to be the first column, just say FIRST; here.

-- We can also add a CHECK constraint for next future values evaluation before storing them.
ALTER TABLE tracked
ADD CONSTRAINT CHECK(rate < 10); -- we can put a custom name for each constraint we create, either way it will generated automatically.
-- on a chnage if the rate value is > 10, it will raise and error.

-- it's also possible to drop a CHECK constraint
ALTER TABLE tracked
DROP CHECK xxxx_chk;

-- To alter table to set a default value:
ALTER TABLE tracked
ALTER COLUMN SET DEFAULT "xxx";

-- It's possible to set the AUTO_INCREMENT to another
-- value than 1 when it start counting
ALTER TABLE table_x
AUTO_INCREMENT = 100;
-- now on, the incrementation will be started at 100, 101, 102..
```

### TRIGGERS

- To Create a trigger on update for product to set new value.
```sql
DELIMITTER $$
CREATE
    TRIGGER triggerx....
        BEFORE/AFTER UPDATE ON table_y
        FOR EACH ROW
        UPDATE table_x -- only if table_x is different from the other table_y
        SET price = (NEW.amount * 1.0)
    END$$
DELIMITTER ;
```

- To show triggers
```sql
SHOW TRIGGERS;
```


### TRANSACTIONS

- AUTOCOMMIT (COMMIT /ROLLBACK) -- for changes

By default it's on `ON`.
It is a good idea to have it set on `OFF`.
To UNDO precedent SQL queries
```sql
SET AUTOCOMMIT = OFF;
 -- to create a save point.
COMMIT;

SELECT * FROM titi;
INSERT INTO titi (id, name) VALUES(21, "doum"), (0, "ack");
SELECT * FROM titi;

-- let say i made now an error and i deleted all rows.
DELETE FROM titi;
SELECT * FROM titi;

-- to rollback, i just need to call ROLLBACK;
ROLLBACK;
SELECT * FROM titi;
```

## VIEWS

Virtuals tables from a result-set of an SQL statement.

To create a view :
```sql
CREATE VIEW products_upper_than_0 AS
    SELECT * FROM products WHERE price > 0;
```

We can then access datas from those views:
```sql
SELECT * FROM products_upper_than_0;
```

*NOTE:* Views are always up to date, this means, that if the table is updated (new records, deleted ones) the view
will always contains the up to date datas. But not for new columns added.

And to delete :
```sql
DROP VIEW products_upper_than_0;
```

## INDEXES

- Ideal for selecting/searching datas.
- Not suitable for updating frequently.

So when creating indexes on a table, we should make sure the table
will be mostly requested for selecting datas.

By default indexes are primary keys.

- To show current index of a table
```sql
SHOW INDEX FROM products;
-- or
SHOW INDEXES FROM products;
```

- To create an INDEX on a column from a table.
```sql
CREATE INDEX p_name
ON products(name);
```

- We can also create a `multi column index` for multiple column a single index at the same time.
```sql
CREATE INDEX name_price
ON products(name, price);
```

- To Drop an INDEX:
```sql
ALTER TABLE products
DROP INDEX name_price;
```

## SUBQUERIES

For example, mixing the count of product with a custom COUNT statement:
```sql
SELECT
    name, price,
    (SELECT COUNT(*) FROM products WHERE price > 0) as count_product_upper_0
FROM products;
```

Or use in Where clause to compare with the average price amoung the table:
```sql
SELECT
    name, price
FROM products
    WHERE price >= (SELECT AVG(price) FROM products);
```

Another example:
```sql
SELECT name
FROM  customers
WHERE customer_id in (SELECT DISTINCT customer_id FROM transactions WHERE customer_id IS NOT NULL);
```

## GROUP BY

We can group results based on a specific column for a specific aggregation function
In this example we're using average :
```sql
SELECT reg_date, AVG(price) as avg_price FROM products GROUP BY reg_date;

-- We can even store results in a VIEW...
CREATE VIEW count_view_product AS
    SELECT reg_date, COUNT(*) as count_product FROM products GROUP BY reg_date;
SELECT * FROM count_view_product;
```

To Use the WHERE clause in an ORDER BY, we should use the `HAVING` clause instead.

```sql
SELECT * FROM customers
GROUP BY registered_id
HAVING price > 10;
```

## ROLLUP

It's an extension of GROUP BY
but produces anthoer row for the GRAND TOTAL
Example:

```sql
SELECT * FROM products;

SELECT reg_date, SUM(price) AS "$" FROM products
GROUP BY reg_date WITH ROLLUP;

reg_date        $
---------------------
2024-05-16      1210
2024-05-17      0
2024-05-18      39
NULL            1249 --<<< it gave a GRAND TOTAL result
```

## STORED PROCEDURE

Queries we can saved on the SGBD and just call when needed.

To create a new procedure:
```sql
-- we need to change the delimiter for the instruction
-- and also for the procedure set
-- this will help us use the ';' only from the stoed procedure and use
-- $$ as the the delimiter to create the procedure.

DELIMITER $$

CREATE PROCEDURE get_products()
BEGIN
    SELECT * FROM products;
END $$

DELIMITER ;

CALL get_products();
```

For a procedure with param as function :
```sql
DELIMITER $$

CREATE PROCEDURE get_product_by_name(IN search_name VARCHAR(50)) -- this can take multiple items with the data type
BEGIN
    SELECT * FROM products WHERE name = search_name;
END $$

DELIMITER ; -- we reset ';' as the delimiter for instructions.

-- then we can use it
CALL get_product_by_name("this");
```

To drop a stored procedure :
```sql
DROP PROCEDURE get_products;
```

### EXTRATS

```sql
-- to order by something and we can reverse with DESC
ORDER BY attr (DESC/ASC)-- we can order with multiple attributes
-- or
-- we can also order by multiple attrs.
ORDER BY attr1 DESC, attr2 ASC
-- limit
LIMIT 3
LIMIT 10 OFFSET 3;
WHERE attr IN ('test', 'test2')

-- it's possible to update all columns based on existing values
-- programattically
UPDATE products
SET size_name = LENGTH(name);

-- We can also use REGEXP
SELECT * FROM employee WHERE REGEXP 'field|mac|rose'
-- or '[gim]e' means ie ge me
-- or '[a-h]e' a or b or c ...h with e

SELECT LAST_INSERT_ID();

-- Allow deleting items even with FOREIGN KEYS sets
-- on other tables.
SET foreign_key_checks = 1;

-- usualy used in the CREATE table  statement.
ON DELETE SET NULL -- When FK deleted, replace fk with NULL;
ON DELETE CASCADE -- When FK deleted, delete whole row;
```
