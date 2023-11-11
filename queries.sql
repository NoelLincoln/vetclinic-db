--find all animals
SELECT * FROM animals;

--  Find all animals whose name ends in "mon".
SELECT * FROM animals
WHERE name LIKE '%mon';

--List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';


--List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

--List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

--List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

--Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered = true;

--Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE name <> 'Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. 
BEGIN;
UPDATE animals
SET species = 'unspecified';


-- Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
SELECT * FROM animals; -- species column = unspecified
ROLLBACK;
SELECT * FROM animals -- species column = null

--Inside a transaction: Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

BEGIN;

-- Update species to 'digimon' for animals with names ending in "mon"
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update species to 'pokemon' for animals with no species set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

SELECT * FROM animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.

BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

SELECT * FROM animals;


-- Roll back the transaction to undo the deletion
ROLLBACK;

SELECT * FROM animals;



-- Inside a transaction: Delete all animals born after Jan 1st, 2022.Create a savepoint for the transaction.Update all animals' weight to be their weight multiplied by -1. Rollback to the savepoint Update all animals' weights that are negative to be their weight ultiplied by -1. Commit transaction



BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT savepoint_one;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO savepoint_one;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- Write queries to answer the following questions: 

--How many animals are there?
SELECT COUNT(*) FROM animals;


-- How many animals have never tried to escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) as total_escape_attempts
FROM animals
GROUP BY neutered;


-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals
GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


--Write queries (using JOIN) to answer the following questions:

-- What animals belong to Melody Pond?
SELECT a.name AS animal_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';


--List of all animals that are pokemon (their type is Pokemon).
SELECT a.name AS animal_name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';


--List all owners and their animals, remember to include those that don't own any animal.
SELECT
    o.full_name AS owner_name,
    a.name AS animal_name
FROM
    owners o
LEFT JOIN
    animals a ON o.id = a.owner_id
ORDER BY
    o.full_name, a.name;


--How many animals are there per species?
SELECT
    s.name AS species_name,
    COUNT(a.id) AS animal_count
FROM
    species s
LEFT JOIN
    animals a ON s.id = a.species_id
GROUP BY
    s.name
ORDER BY
    species_name;


--List all Digimon owned by Jennifer Orwell.
SELECT
    a.name AS digimon_name
FROM
    owners o
JOIN
    animals a ON o.id = a.owner_id
JOIN
    species s ON a.species_id = s.id
WHERE
    o.full_name = 'Jennifer Orwell'
    AND s.name = 'Digimon';


--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
    a.name AS animal_name
FROM
    owners o
JOIN
    animals a ON o.id = a.owner_id
WHERE
    o.full_name = 'Dean Winchester'
    AND a.escape_attempts IS NULL;


-- Who owns the most animals?
SELECT
    o.full_name AS owner_name,
    COUNT(a.id) AS animal_count
FROM
    owners o
LEFT JOIN
    animals a ON o.id = a.owner_id
GROUP BY
    o.full_name
ORDER BY
    animal_count DESC
LIMIT 1;


--Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT
    a.name AS last_animal_seen
FROM
    visits v
JOIN
    animals a ON v.animal_id = a.id
WHERE
    v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY
    v.visit_date DESC
LIMIT 1;


-- How many different animals did Stephanie Mendez see?
SELECT
    COUNT(DISTINCT v.animal_id) AS number_of_animals_seen
FROM
    visits v
WHERE
    v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

    
-- List all vets and their specialties, including vets with no specialties.
SELECT
    v.name AS vet_name,
    COALESCE(s.name, 'No Specialty') AS specialty_name
FROM
    vets v
LEFT JOIN
    specializations sp ON v.id = sp.vet_id
LEFT JOIN
    species s ON sp.species_id = s.id
ORDER BY
    v.name, specialty_name;


-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
    a.name AS animal_name
FROM
    visits v
JOIN
    animals a ON v.animal_id = a.id
WHERE
    v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
    AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';



-- What animal has the most visits to vets?
SELECT
    a.name AS animal_name,
    COUNT(v.animal_id) AS visit_count
FROM
    visits v
JOIN
    animals a ON v.animal_id = a.id
GROUP BY
    a.name
ORDER BY
    visit_count DESC
LIMIT 1;


-- Who was Maisy Smith's first visit?
SELECT
    a.name AS first_visited_animal
FROM
    visits v
JOIN
    animals a ON v.animal_id = a.id
WHERE
    v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY
    v.visit_date
LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
    a.name AS animal_name,
    v.visit_date,
    ve.name AS vet_name
FROM
    visits v
JOIN
    animals a ON v.animal_id = a.id
JOIN
    vets ve ON v.vet_id = ve.id
ORDER BY
    v.visit_date DESC
LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
    COUNT(*) AS num_visits_without_specialization
FROM
    visits v
JOIN
    animals a ON v.animal_id = a.id
JOIN
    vets ve ON v.vet_id = ve.id
LEFT JOIN
    specializations s ON ve.id = s.vet_id AND a.species_id = s.species_id
WHERE
    s.vet_id IS NULL
    OR s.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

WITH VetSpeciesVisits AS (
    SELECT
        ve.id AS vet_id,
        a.species_id,
        COUNT(*) AS num_visits
    FROM
        visits v
    JOIN
        animals a ON v.animal_id = a.id
    JOIN
        vets ve ON v.vet_id = ve.id
    WHERE
        ve.name = 'Maisy Smith'
    GROUP BY
        ve.id, a.species_id
)

SELECT
    s.name AS suggested_specialty
FROM
    VetSpeciesVisits vsv
JOIN
    species s ON vsv.species_id = s.id
ORDER BY
    vsv.num_visits DESC
LIMIT 1;
