CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id serial PRIMARY KEY,
    name varchar(255),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal(10, 2)
);

-- add species column
ALTER TABLE animals
ADD COLUMN species varchar(255);

-- create owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INTEGER
);

--create species table
CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name TEXT
);

-- Modify animals table: 
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table

-- id is already set as autoincremented PRIMARY KEY


-- Drop the existing 'species' column
ALTER TABLE animals
DROP COLUMN species;

-- Add the 'species_id' column as a foreign key referencing the 'species' table
ALTER TABLE animals
ADD COLUMN species_id INTEGER;

-- Add the foreign key constraint
ALTER TABLE animals
ADD CONSTRAINT fk_species_id
    FOREIGN KEY(species_id)
        REFERENCES species(id);


-- Add the 'owner_id' column as a foreign key referencing the 'owners' table

-- Add the 'owner_id' column to the "animals" table
ALTER TABLE animals
ADD COLUMN owner_id INTEGER;

-- Add the foreign key constraint
ALTER TABLE animals
ADD CONSTRAINT fk_owner_id
    FOREIGN KEY(owner_id)
    REFERENCES owners(id);



