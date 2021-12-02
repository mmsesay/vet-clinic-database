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

-- All pokemon animals
SELECT * FROM animals
   LEFT JOIN species
ON animals.species_id = species.id
   WHERE species.name = 'Pokemon';

-- All owners and their animals
SELECT
   full_name as owner_name,
   name as animal_name
FROM owners
   LEFT JOIN animals
ON owners.id = animals.owner_id;

-- Animals count per species
SELECT species.name, COUNT(*) FROM animals
   LEFT JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- All Digimon owned by Jennifer Orwell
SELECT * FROM animals
   LEFT JOIN owners
ON animals.owner_id = owners.id
   LEFT JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- All animals owned by Dean Winchester that haven't tried to escape
SELECT * FROM animals
   LEFT JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempt = 0;

-- Owners with who owns the most animals?
SELECT owners.full_name, COUNT(owners.full_name) FROM animals
   LEFT JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(owners.full_name) DESC;

SELECT animals.name, visits.date_of_visit FROM visits
   JOIN animals 
ON animals.id = visits.animal_id
   JOIN vets 
ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT DISTINCT animals.name FROM visits
   JOIN animals 
ON animals.id = visits.animal_id
   JOIN vets 
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

SELECT 
	vets.name as vet_name, species.name as specialities FROM vets
	JOIN specializations 
ON vets.id = specializations.vet_id OR vets.id != specializations.vet_id
	JOIN species 
ON specializations.species_id = species.id;

SELECT animals.name, visits.date_of_visit FROM visits
   JOIN animals 
ON animals.id = visits.animal_id
   JOIN vets 
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit > '2020-04-01' AND date_of_visit < '2020-08-30'

