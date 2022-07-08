/* Populate database with sample data. */

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
)
VALUES (
  'Agumon',
  date '2020-02-03',
  0,
  'true',
  10.23
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg)
VALUES (
  'Gabumon',
  date '2018-11-15',
  2,
  'true',
  8
);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Pikachu', date '2021-1-7', 1, 'false', 15.04),('Devimon', date '2017-5-12', 5, 'true', 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Charmander', date '2020-02-08', 0, 'false', -11), ('Plantmon', date '2021-11-15', 2, 'true', -5.7), ('Squirtle', date '1993-04-02', 3, 'false', -12.13), ('Angemon', date '2005-06-12', 1, 'true', -45), ('Boarmon', date '2005-06-07', 7, 'true', 20.4), ('Blossom', date '1998-10-13', 3, 'true', 17), ('Ditto', date '2022-05-14', 4, 'true', 22);

INSERT INTO owners (full_name, age) VALUES('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

/* Modify your inserted animals so it includes the species_id value */ 
/* If the name ends in "mon" it will be Digimon */
BEGIN; 
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

/* All other animals are Pokemon */
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
COMMIT;

/* Modify your inserted animals to include owner information (owner_id) */ 
BEGIN;
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

COMMIT;

SELECT * FROM animals;

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Vet William Tatcher', 45, 'Apr 23 2000'),
('Vet Maisy Smith', 26 ,'Jan 17 2019'),
('Vet Stephanie Mendez', 64, 'May 04 1981'),
('Vet Jack Harkness', 38,'Jun 08 2008'); 

INSERT INTO specialization (vet_id, species_id) VALUES(1, 1), (3, 2), (3, 1), (4, 2);


INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES(1, 1, date '2020-05-24'), (1, 3, date '2020-07-22'), (2, 4, date '2021-02-20'), (3, 2, date '2020-01-05'), (3, 2, date '2020-03-08'), (3, 2, date '2020-05-14'), (4, 3, date '2021-05-04'), (5, 4, date '2021-02-24'), (6, 2, date '2019-12-21'), (6, 1, date '2020-08-10'), (6, 2, date '2021-04-07'), (7, 3, date '2019-09-29'), (8, 4, date '2020-10-03'), (8, 4, date '2020-11-04'), (9, 2, date '2019-01-24'), (9, 2, date '2019-05-15'), (9, 2, date '2020-02-27'), (9, 2, date '2020-08-03'), (10, 3, date '2020-03-24'), (10, 1, date '2021-01-11');
