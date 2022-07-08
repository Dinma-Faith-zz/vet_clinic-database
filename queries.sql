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

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT A.name, S.name
FROM animals A
JOIN species S
ON S.id = A.species_id
WHERE S.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT O.full_name AS OWNER, A.name as animal
FROM animals A
RIGHT JOIN owners O
ON O.id = A.owner_id;

/* How many animals are there per species? */
SELECT COUNT(*), S.name
FROM animals A
JOIN species S
ON S.id = A.species_ID
GROUP BY S.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT A.name, O.full_name
FROM animals A
JOIN species S
ON S.id = A.species_id
JOIN owners O
ON O.id = A.owner_id
WHERE O.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT A.name , O.full_name
FROM animals A
JOIN species S
ON S.id = A.species_id
JOIN owners O
ON O.id = A.owner_id
WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;

/* Who owns the most animals? */

SELECT owners.id, full_name
FROM animals
JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.id, owners.full_name
ORDER BY count(*)
DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT A.name FROM animals A
JOIN visits V
ON A.id = V.animal_id
JOIN vets VE
ON VE.id = V.vet_id
WHERE VE.name = 'William Tatcher'
ORDER BY V.date_of_visit

-- How many different animals did Stephanie Mendez see?
SELECT count(A.name), VE.name FROM animals A
JOIN visits V
ON A.id = V.animal_id
JOIN vets VE
ON VE.id = V.vet_id
WHERE VE.name ='Stephanie Mendez'
GROUP BY  VE.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT VE.name as name_of_vets, S.name as name_of_animals FROM  vets VE
LEFT  JOIN specializations SP
ON VE.id = SP.vet_id
LEFT JOIN species S
ON  S.id = SP.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.name, VE.name, V.date_of_visit  FROM animals A
JOIN visits V
ON A.id = V.animal_id
JOIN vets VE
ON VE.id = V.vet_id
WHERE VE.name = 'Stephanie Mendez' and V.date_of_visit >= 'Apr 01, 2020' and V.date_of_visit >= 'Aug 30, 2020';

-- What animal has the most visits to vets?
SELECT A.name, COUNT(V.animal_id) AS visit_number FROM animals A
JOIN visits V
ON V.animal_id = A.id
GROUP BY A.name
ORDER BY (visit_number)
DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name,V.date_of_visit FROM animals A
JOIN visits V
ON A.id = V.animal_id
JOIN vets VE
ON VE.id = V.vet_id
WHERE VE.name = 'Vet Maisy Smith'
ORDER BY V.date_of_visit
ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT A.* as animal, V.*, VE.* as vet from animals A
JOIN visits V
ON V.animal_id = A.id
JOIN vets VE
ON VE.id = V.vet_id
ORDER BY V.date_of_visit
DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT VE.name, COUNT(V.vet_id) FROM vets VE
JOIN visits V
ON V.vet_id = VE.id
JOIN animals A
ON A.id = V.animal_id
WHERE A.species_id IN (
SELECT SP.species_id FROM specializations SP
JOIN vets V
ON V.id = SP.vet_id
WHERE V.name = VE.name
)
GROUP BY VE.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT VE.name, A.species_id , COUNT(A.species_id) AS species_count
FROM vets VE
JOIN visits V
ON V.vet_id = VE.id
JOIN animals A
ON A.id = V.animal_id
WHERE VE.name = 'Vet Maisy Smith'
GROUP BY (VE.name, A.species_id)
ORDER BY species_count
DESC LIMIT 1;