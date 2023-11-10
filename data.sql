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

