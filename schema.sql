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
