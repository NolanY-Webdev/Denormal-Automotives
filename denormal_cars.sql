-- ## Denormal Cars
-- Write your queries in `denormal.sql` when instructed to.

-- 1. Create a new postgres user named `denormal_user`
\c EnemyBoss;
DROP DATABASE denormal_cars;
DROP USER denormal_user;
CREATE USER denormal_user;

-- 1. Create a new database named `denormal_cars` owned by `denormal_user`
CREATE DATABASE denormal_cars OWNER denormal_user;
\c denormal_cars;

-- 1. Run the provided `scripts/denormal_data.sql` script on the `denormal_cars` database
\i ./scripts/denormal_data.sql;

-- 1. Inspect the table named `car_models` by running `\dS` and look at the data using some `SELECT` statements
\dS;
SELECT *
FROM car_models;

-- 1. In `denormal.sql` Create a query to get a list of all `make_title` values in the `car_models` table, without any duplicate rows. (should have 71 results)
SELECT DISTINCT make_title
FROM car_models;

--  make_title
-- ---------------
--  Ferrari
--  Merkur
--  Mazda
--  SRT
--  Maybach
--  DeLorean
--  Mercedes-Benz
--  Avanti
--  Fisker
--  Bentley
--  Honda
--  Infiniti
--  Lincoln
--  Renault
--  Dodge
--  Plymouth
--  Rolls-Royce
--  Triumph
--  BMW
--  Volkswagen
--  Mercury
--  Hyundai
--  AMC
--  Nissan
--  Geo
--  Audi
--  Chrysler
--  Alfa Romeo
--  Cadillac
--  Aston Martin
--  Eagle
--  RAM
--  Jeep
--  Daewoo
--  Peugeot
--  Mitsubishi
--  Oldsmobile
--  Chevrolet
--  Freightliner
--  Jaguar
--  Volvo
--  Maserati
--  Daihatsu
--  Lexus
--  Buick
--  Isuzu
--  Porsche
--  Land Rover
--  Acura
--  Lotus
--  smart
--  MINI
--  Sterling
--  Subaru
--  Tesla
--  Toyota
--  HUMMER
--  Suzuki
--  Lancia
--  Pontiac
--  GMC
--  Kia
--  Lamborghini
--  McLaren
--  FIAT
--  Yugo
--  Scion
--  Saturn
--  Saab
--  Datsun
--  Ford
-- (71 rows)

-- 1. In `denormal.sql` Create a query to list all `model_title` values where the `make_code` is `'VOLKS'`, without any duplicate rows (should have 27 results)
SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';

--         model_title
-- ----------------------------
--  Golf and Rabbit Models (2)
--  Tiguan
--  Golf R
--  Phaeton
--  Eos
--  Cabriolet
--  Passat
--  Corrado
--  Other Volkswagen Models
--  Eurovan
--  R32
--  Vanagon
--  GLI
--   - Rabbit
--  Pickup
--  Quantum
--  Touareg
--  GTI
--  Jetta
--  CC
--  Dasher
--   - Golf
--  Cabrio
--  Beetle
--  Scirocco
--  Routan
--  Fox
-- (27 rows)

-- 1. In `denormal.sql` Create a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'` (should have 136 rows)
SELECT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';

-- 1. In `denormal.sql` Create a query to list all fields from all `car_models` in years between `2010` and `2015` (should have 7884 rows)
SELECT *
FROM car_models
WHERE year BETWEEN 2010 AND 2015;