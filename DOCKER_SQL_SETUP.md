# SQL CLI USEFULL TO KNOW

Note : Never forget the `;` at the end of the command.

- To connect inside mysql database:
```bash
mysql -u root -p password
```

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
-- we can also do EFT JOIN and RIGHT JOIN


-- we got a lot of output but in the left, and the right are NUll if there are not existing
SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.col1=table2.col2;
-- Same logic wih the RIGHT OUTER JOIN


-- The FULL is a combination of the LEFT and the right using UNION
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

-- UCASE / LCASE (For uppercase a column and lower case it)
SELECT * FROM UCASE(col1) as ucase_col1 FROM table1;

-- MID to cut the string we'r getting, as parameter(the column, the start point and the number of characters, we want to cut from)
SELECT MID(firstname, 1, 4) as nn FROM table1;

-- TO Calculate the lenght of a column its LENGTH
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
CREATE TABLE customers(
    customer_id INT NOT NULL AUTO_INCREMENT,
    
    name VARCHAR(20),
    location VARCHAR(30),
    
    PRIMARY KEY (customer_id)
);

CREATE TABLE products(
    product_id INT NOT NULL AUTO_INCREMENT,

    name VARCHAR(20) NOT NULL,
    description TEXT DEFAULT 'Product description',

    PRIMARY KEY(product_id),
);


-- And we link them
CREATE TABLE orders(
    order_id INT NOT NULL AUTO_INCREMENT,

    product_id INT NOT NULL,
    quantity INT(10) NOT NULL,
    customer_id INT NOT NULL,

    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

```

### Alter a table

```sql
ALTER TABLE target
ADD COLUMN columnx INT(10) NOT NULL AFTER columny;

-- or to add a foreign key
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```

### Extrats

```sql
-- to order by something and we can reverse with DESC
ORDER BY attr -- we can order with multiple attributes

LIMIT 3

WHERE attr IN ('test', 'test2')

-- We can also use REGEXP
SELECT * FROM employee WHERE REGEXP 'field|mac|rose'
-- or '[gim]e' means ie ge me
-- or '[a-h]e' a or b or c ...h with e

SELECT LAST_INSERT_ID();
```

### TRIGGERS
```
DELIMITTER $$
CREATE
    TRIGGER triggerx....

    END$$
DELIMITTER ;
