-- MYSQL
DROP TABLE titi;

CREATE TABLE IF NOT EXISTS titi (id INT, name VARCHAR(10));

INSERT INTO titi (id, name) VALUES(12, "baba"), (1, "zik"), (12, "zok");

SELECT * FROM titi;

UPDATE titi
SET name = "DOUMBA"
WHERE id = 12;

------------------
-- POSTGRESQL
DROP SCHEMA tata CASCADE;

CREATE SCHEMA tata;

CREATE TABLE IF NOT EXISTS tata.titi (inside BOOLEAN, description TEXT);

INSERT INTO tata.titi (inside, description)
VALUES (true, 'this is a test');
INSERT INTO tata.titi (inside, description)
VALUES (false, 'bingo gindo');

SELECT * FROM tata.titi;

DELETE FROM tata.titi WHERE 1=1;

---

CREATE TABLE IF NOT EXISTS tracked (
    tid INT NOT NULL AUTO_INCREMENT,

    session VARCHAR(10),
    description VARCHAR(200) DEFAULT "...",
    date DATE,

    PRIMARY KEY (tid)
);
ALTER TABLE tracked
ADD COLUMN rate INT NOT NULL;

ALTER TABLE tracked
MODIFY COLUMN rate INT NOT NULL
AFTER sess;

ALTER TABLE tracked
ADD CONSTRAINT CHECK(rate < 10);

ALTER TABLE tracked
MODIFY COLUMN date DATE DEFAULT(CURRENT_DATE());

ALTER TABLE tracked
MODIFY COLUMN sess VARCHAR(10) NOT NULL;

ALTER TABLE tracked
ADD CONSTRAINT UNIQUE(session);

ALTER TABLE tracked
RENAME COLUMN session TO sess;

SELECT * from INFORMATION_SCHEMA.COLUMNS WHERE table_name="tracked";

INSERT INTO tracked
VALUES
    (1, "session_1", NULL, NULL),
    (2, "s__2", NULL, NULL),
    (3, "s__3", NULL, NULL);

INSERT INTO tracked
VALUES
    (4, "s__4", "bloumberg", CURRENT_DATE() + 1);
-- CURRENT_DATE() + 1 add a new day
-- CURRENT_TIMESTAMP() == NOW()

INSERT INTO tracked
    (tid, sess, rate, info)
VALUES
    (5, "s__5", 9, "xyz");

INSERT INTO tracked
    (sess, rate)
VALUES
    ("s__6", 8);

UPDATE tracked
SET info="bbb"
WHERE info = "bloumberg";

SHOW TABLES;
DROP TABLE  tracked;

SELECT * FROM tracked;

DELETE FROM tracked WHERE session is NULL;

CREATE TABLE IF NOT EXISTS yyy (
    id INT AUTO_INCREMENT NOT NULL,
    colA TEXT,

    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS xxx;
CREATE TABLE IF NOT EXISTS xxx (
    id INT AUTO_INCREMENT NOT NULL,
    col1 VARCHAR(10) UNIQUE,
    col2 DECIMAL(4, 2) DEFAULT 0.22,
    col3 DATE DEFAULT(CURRENT_DATE()),
    f_col4 INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (f_col4) REFERENCES yyy(id)
);

ALTER TABLE xxx
ADD COLUMN tx_time DATETIME AFTER col3;

ALTER TABLE xxx
ALTER COLUMN tx_time SET DEFAULT(NOW());

INSERT INTO yyy
    (colA)
VALUES
    ("this a test");
SELECT * FROM yyy;

INSERT INTO xxx
    (col1, f_col4)
VALUES
    ("abbx",2);

SELECT * FROM xxx;
