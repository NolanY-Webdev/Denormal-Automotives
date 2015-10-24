-- ## Modeling a Normalized Schema
-- Write your queries in `normalized.sql` when instructed to.

-- 1. Create a new postgres user named `normal_user`
\c EnemyBoss;
DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;
CREATE USER normal_user;
DROP TABLE IF EXISTS car_models;
-- 1. Create a new database named `normal_cars` owned by `normal_user`
CREATE DATABASE normal_cars OWNER normal_user;
\c normal_cars;
\i ./scripts/denormal_data.sql;
-- 1. Whiteboard your solution to normalizing the `denormal_cars` schema.


-- 1. [bonus] Generate a diagram (somehow) in .png (or other) format, that of your normalized cars schema. (save and commit to this repo)


-- 1. In `normalized.sql` Create a query to generate the tables needed to accomplish your normalized schema, including any primary and foreign key constraints. Logical renaming of columns is allowed.

CREATE TABLE IF NOT EXISTS makes
(
  id serial PRIMARY KEY,
  make_title character varying(125) NOT NULL,
  make_code character varying(125) NOT NULL
);

CREATE TABLE IF NOT EXISTS models
(
  id serial PRIMARY KEY,
  model_title character varying(125) NOT NULL,
  model_code character varying(125) NOT NULL
);

CREATE TABLE IF NOT EXISTS year
(
  id int PRIMARY KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS normalized
(
  id serial PRIMARY KEY,
  make_id integer REFERENCES makes (id) NOT NULL,
  model_id integer REFERENCES models (id) NOT NULL,
  year integer REFERENCES year (id) NOT NULL
);

-- 1. Using the resources that you now possess, In `normal.sql` Create queries to insert **all** of the data that was in the `denormal_cars.car_models` table, into the new normalized tables of the `normal_cars` database.
INSERT INTO makes (make_title, make_code)
SELECT DISTINCT make_title, make_code
FROM car_models;

INSERT INTO models (model_title, model_code)
SELECT DISTINCT model_title, model_code
FROM car_models;

INSERT INTO year (id)
SELECT DISTINCT year
FROM car_models;

INSERT INTO normalized (make_id, model_id, year)
SELECT makes.id, models.id, year.id
FROM makes, models, year, car_models
  WHERE makes.make_title = car_models.make_title
      AND makes.make_code = car_models.make_code
    AND models.model_title = car_models.model_title
      AND models.model_code = car_models.model_code
    AND year.id = car_models.year;

-- 1. In `normal.sql` Create a query to get a list of all `make_title` values in the `car_models` table. (should have 71 results)
SELECT DISTINCT make_title
FROM normalized
INNER JOIN makes
ON makes.id = normalized.make_id;


-- 1. In `normal.sql` Create a query to list all `model_title` values where the `make_code` is `'VOLKS'` (should have 27 results)
SELECT DISTINCT model_title
FROM normalized
INNER JOIN makes
on makes.id = normalized.make_id
INNER JOIN models
ON normalized.model_id = models.id
WHERE makes.make_code = 'VOLKS';

-- 1. In `normal.sql` Create a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'` (should have 136 rows)
-- SELECT DISTINCT make_code, model_code, model_title, year
-- FROM normalized
-- INNER JOIN makes
-- ON makes.id = normalized.make_id
-- INNER JOIN models
-- ON normalized.model_id = models.id
-- WHERE makes.make_code = 'LAM';

SELECT DISTINCT cm.make_code AS make, cd.model_code AS model, cd.model_title AS title, year
FROM normalized AS cn
INNER JOIN makes cm
ON cn.make_id = cm.id
INNER JOIN models cd
ON cn.model_id = cd.id
WHERE cm.make_code = 'LAM';

-- 1. In `normal.sql` Create a query to list all fields from all `car_models` in years between `2010` and `2015` (should have 7884 rows)
SELECT DISTINCT *
FROM normalized
INNER JOIN makes
on makes.id = normalized.make_id
INNER JOIN models
ON normalized.model_id = models.id
WHERE year BETWEEN 2010 and 2015;