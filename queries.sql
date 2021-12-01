/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered='true' AND escape_attempt < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempt FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered='true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Adding a new columnn to the animals table
ALTER TABLE animals
ADD COLUMN species VARCHAR(100)

-- Transaction to update species column
BEGIN; -- start transaction
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals; -- verify the change
ROLLBACK;
SELECT species FROM animals; -- verify the changes are reverted

-- Transaction to update animals based on species
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon'; 
UPDATE animals SET species = 'pokemon' WHERE species IS NULL; 

SELECT species from animals; -- verify the change
COMMIT;
SELECT species from animals; -- verify the change was saved
END;

-- Transaction to delete all animals;
BEGIN;
DELETE FROM animals;
SELECT * FROM animals; -- verify the change
ROLLBACK;
SELECT * FROM animals; -- verify the change

-- Transaction to delete all animals born after JAN-01-2022;
BEGIN;
DELETE FROM animals WHERE  date_of_birth >= '2022-01-01';
SAVEPOINT SP_DELETE_ANIMALS;

UPDATE animals SET weight_kg = weight_kg * -1;
SELECT weight_kg FROM animals; -- verify that change
ROLLBACK TO SP_DELETE_ANIMALS;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0; 
COMMIT;

-- Count all animals
SELECT COUNT(*) FROM animals;

-- Count all animals that have never tried to escaped
SELECT COUNT(*) FROM animals WHERE escape_attempt = 0;

-- Avergae weight in kg of all animals
SELECT AVG(weight_kg) FROM animals;

-- Most escape attempt average
SELECT neutered, AVG(escape_attempt) FROM animals
GROUP BY neutered;

-- Minimum and maximum weight of each type of animal
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

-- Average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempt) FROM animals
WHERE  date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

-- All melody animals
SELECT * FROM animals
   LEFT JOIN owners
ON animals.owner_id = owners.id
   WHERE full_name = 'Melody Pond';
