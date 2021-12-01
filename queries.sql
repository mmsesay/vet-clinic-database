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

SELECT species from animals; -- verify that change
COMMIT;
SELECT species from animals; -- verify that change was saved
END;

-- Transaction to delete all animals;
BEGIN;
DELETE FROM animals;
SELECT * FROM animals; -- verify that change

ROLLBACK;
SELECT * FROM animals; -- verify that change
