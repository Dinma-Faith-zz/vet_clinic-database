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
