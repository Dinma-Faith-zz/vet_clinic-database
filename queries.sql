/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >='2016-01-01' and date_of_birth<='2019-12-31';
SELECT  name FROM animals WHERE  neutered = 'true' and escape_attempts < 3 ;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' or name = 'Pikachu' ;
SELECT name, escape_attempts FROM animals WHERE  weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon' ; 
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;

ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digmon'
WHERE name LIKE '%mon';
SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon'
WHERE species IS null;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT my_save;
UPDATE animals
SET weight_kg = weight_kg * (-1);
ROLLBACK TO my_save;
UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT (*) as number_of_animals FROM animals;
SELECT COUNT (*) as number_no_escape FROM animals WHERE escape_attempts = 0;
SELECT AVG (weight_kg) as average_weight FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-01-01' GROUP BY species;

/* What animals belong to Melody Pond? */
SELECT A.name, O.full_name FROM animals A
JOIN owners O
ON O.id = A.owner_id
WHERE O.full_name = 'Melody Pond';
