INSERT INTO animals VALUES
(1,'Agumon',DATE '2020-02-03',0,true,10.23),
(2,'Gabumon',DATE '2018-11-15',2,true,8),
(3,'Pikachu',DATE '2021-01-07',1,false,15.04),
(4,'Devimon',DATE '2017-05-12',5,true,11);



-- Insert new animals data
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    (5,'Charmander',DATE '2020-02-08' ,0, false, -11),
    (6,'Plantmon',DATE '2021-11-15',  2,true, -5.7),
    (7,'Squirtle',DATE '1993-04-02', 3 ,false,-12.13),
    (8,'Angemon', DATE '2005-06-12',1, true,  -45),
    (9,'Boarmon',DATE '2005-06-07',7, true,  20.4),
    (10,'Blossom',DATE '1998-10-13',3, true,  17),
    (11,'Ditto', DATE '2022-05-14', 4, true, 22);


--Insert the following data into the owners table:
INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

--Insert the following data into the species table:
INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon');


--Modify your inserted animals so it includes the species_id value:
-- Update animals with species_id based on the condition
UPDATE animals
SET species_id = 
    CASE 
        WHEN LOWER(SUBSTRING(name FROM LENGTH(name) - 2)) = 'mon' THEN 
            (SELECT id FROM species WHERE name = 'Digimon')
        ELSE 
            (SELECT id FROM species WHERE name = 'Pokemon')
    END;


--Modify your inserted animals to include owner information (owner_id):
-- Update animals with owner_id based on owner names
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');


-- add data to vets table
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');


-- Insert data for specializations
INSERT INTO specializations (vet_id, species_id)
VALUES
    -- Vet William Tatcher specialized in Pokemon
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),

    -- Vet Stephanie Mendez specialized in Digimon and Pokemon
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),

    -- Vet Jack Harkness specialized in Digimon
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

--insert data for visits 
-- Assuming you know the animal_id and vet_id values for the animals and vets
-- Insert data for visits
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
    -- Agumon visited William Tatcher on May 24th, 2020.
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24'),

    -- Agumon visited Stephanie Mendez on Jul 22th, 2020.
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),

    -- Gabumon visited Jack Harkness on Feb 2nd, 2021.
    ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),

    -- Pikachu visited Maisy Smith on Jan 5th, 2020.
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),

    -- Pikachu visited Maisy Smith on Mar 8th, 2020.
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),

    -- Pikachu visited Maisy Smith on May 14th, 2020.
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),

    -- Continue with the remaining visits...
    -- ...

    -- Blossom visited William Tatcher on Jan 11th, 2021.
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');
