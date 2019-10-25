-- CREATE TABLE statment for dog licensing data
-- https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp

CREATE TABLE dogs (
	dog_id bigserial PRIMARY KEY,
	data_id varchar(50),
	name varchar (30) NOT NULL,
	gender varchar(1),
	birth_year varchar(4),
	breed varchar (50) NOT NULL, 
	borough varchar(13),
	zipcode varchar(5)	NOT NULL,
	issue_date date,
	expire_date date,
	extract_year varchar(4)
);

-- Importing data using COPY 
-- Shortcut on MacOS, OPTION+COMMAND+C after right-clicking to copy the path.

COPY dogs (
	data_id,
	dog_name,
	gender,
	birth_year,
	breed, 
	borough,
	zipcode,
	issue_date,
	expire_date,
	extract_year
)
FROM '/Users/stephanie/Desktop/dogproj/NYC_Dog_Licensing_Dataset.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- Creating indeces for faster searching

CREATE INDEX name_idx ON dogs (name);
CREATE INDEX zipcode_idx ON dogs (zipcode);
CREATE INDEX breed_idx ON dogs (breed);

-- Remaking primary key to ensure no missing values in original key
ALTER TABLE dog_id DROP COLUMN data_id;


-- Checking dataset

SELECT * FROM dogs


-- Checking for null values in zipcode
SELECT count(*)
FROM dogs
WHERE zipcode IS NULL

-- Using UPDATE TABLE to import boroughs(inherently empty) from created NYC/LI zipcode table
UPDATE dogs
SET borough = nyc.borough
FROM
   nyc
WHERE
   dogs.zipcode = nyc.zipcode;

-- Check that they match up (used on a smaller data subset) also optional
SELECT d.borough_copy, d.zipcode, n.borough, n.zipcode
FROM dogs d join nyc n ON d.zipcode = n.zipcode;


-- Checking count for unknown breeds
SELECT count(*) as total_count,
    SUM(CASE WHEN breed = 'Unknown' then 1 else 0 end) AS unknown_count,
	SUM(CASE WHEN breed <> 'Unknown' then 1 else 0 end) AS known_count
FROM dogs;