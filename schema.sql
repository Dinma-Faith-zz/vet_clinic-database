/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR (100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

ALTER TABLE animals ADD COLUMN species
   VARCHAR (100);

CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(100),
  age INT
);

SELECT * FROM owners;

CREATE TABLE IF NOT EXISTS species(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100)
);

SELECT * FROM species;

-- Modify animal table
ALTER TABLE animals
  DROP COLUMN species
  ADD COLUMN species_id INT,
  ADD FOREIGN KEY (species_id) REFERENCES species(id),
  ADD COLUMN owner_id INT,
  ADD FOREIGN KEY (owner_id) REFERENCES owners(id
);

SELECT * FROM animals;

CREATE TABLE IF NOT EXISTS vets (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(100),
age INT,
date_of_graduation DATE
);

vet_clinic=# SELECT * FROM vets;

CREATE TABLE IF NOT EXISTS specialization (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
species_id INT,
FOREIGN KEY (species_id) REFERENCES species(id),
vet_id INT,
FOREIGN KEY (vet_id) REFERENCES vets(id)
);

vet_clinic=# SELECT * FROM specialization;

CREATE TABLE IF NOT EXISTS visits (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
animal_id INT,
FOREIGN KEY (animal_id) REFERENCES animals(id),
vet_id INT,
FOREIGN KEY (vet_id) REFERENCES vets(id)
);

ALTER TABLE visits
ADD COLUMN date_of_visit DATE;

SELECT * FROM visits;

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- INDEX
CREATE INDEX animal_id_desc ON visits(animal_id DESC);
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

CREATE INDEX vet_index ON visits(vet_id);
explain analyze SELECT * FROM visits
WHERE vet_id = 2;

CREATE INDEX email_desc ON owners(email DESC);
explain analyze SELECT * FROM owners
WHERE email = 'owner_18327@mail.com';
