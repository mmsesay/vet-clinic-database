/* Populate database with sample data. */

INSERT INTO animals(
  	id, name, date_of_birth,
  	escape_attempt, neutered, weight_kg
) 
VALUES(1, 'Agumon', '2020-02-03', 0, true, 10.23);
	(2, 'Gabumon', '2018-11-15', 2, true, 8);
	(3, 'Pikachu', '2021-01-7', 1, false, 15.04);
	(4, 'Devimon', '2017-05-12', 5, true, 11);
	(5, 'Charmander', '2020-02-08', 0, false, -11);
	(6, 'Plantmon', '2022-11-15', 2, true, -5);
	(7, 'Squirtle', '1993-04-02', 3, false, -12.13);
	(8, 'Angemon', '2005-06-12', 1, true, -45);
	(9, 'Boarmon', '2005-07-07', 7, true, 20.4);
	10, 'Blossom', '1998-08-13', 3, true, 17);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
		('Jennifer Orwell', 19),
		('Bob', 45),
		('Melody Pond', 77),
		('Dean Winchester', 14),
		('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Modify inserted animals so it includes the species_id value
UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Digimon')
WHERE name like '%mon';

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

-- Modify inserted animals to include owner information (owner_id) 
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon'  OR name = 'Boarmon';

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
	   ('Maisy Smith', 26, '2019-01-17'),
	   ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harknes', 38, '2008-06-08');

INSERT INTO specializations (species_id, vet_id)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
	   ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
       ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon'));
	   ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));
	   

	   