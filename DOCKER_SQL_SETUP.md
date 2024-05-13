## DOCKER

### SETUP

#### MySql

To run a docker image of MySQL
Put these in a `.env.mysql` file:

```
MYSQL_DATABASE=TESTDB
MYSQL_USER=u
MYSQL_PASSWORD=p
MYSQL_ROOT_PASSWORD=p
```

Then run :
```bash
docker run -d --rm --env-file .env.mysql -p 3306:3306 mysql:latest
```

To connect to the database:
- Either inside the container:
```bash
docker exec -ti <container-id> mysql -u u -D TESTDB -p
>>> <then provide password 'p' in this case>

# Note, the container-id can be obtain with :
$(docker ps | grep mysql | awk '{print $1}')
```

- Or from another client with `mysql -h <host>`

- Or with the direct host url `mysql://u:p@localhost:3306/TESTDB`.

then play with some queries:

```sql
DROP TABLE titi;

CREATE TABLE IF NOT EXISTS titi (id INT, name VARCHAR(10));
INSERT INTO titi (id, name) VALUES(12, "baba"), (1, "zik"), (12, "zok");
SELECT * FROM titi;

UPDATE titi
SET name = "DOUMBA"
WHERE id = 12;
```

#### POSTGRESQL

In the .env.psql
```
POSTGRES_PASSWORD=p
POSTGRES_USER=u
POSTGRES_DB=TESTDB
```

then

```bash
docker run -d --rm --env-file .env.psql -p 5432:5432 postgres:latest
```
```sql
CREATE SCHEMA tata;
CREATE TABLE IF NOT EXISTS tata.titi (id INT, name VARCHAR(10));
INSERT INTO tata.titi (id, name) VALUES (11, 'bobo');
SELECT * FROM tata.titi;
DELETE FROM tata.titi WHERE 1=1;
```

### TO RUN/EXECUTE QUERIES

- Either with the CLI too :
(note the -pPassword)
```bash
$ docker exec -ti <container-id> cli -u u -pPassword -D TESTDB -e 'query'
```
