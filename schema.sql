/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer PRIMARY KEY,
	name varchar(100),
	date_of_birth date,
	escape_attempt integer,
	neutered boolean,
	weight_kg decimal(13,2),
	species varchar(100)
);
