-- CREATE TABLE statment for dog licensing data
-- https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp

CREATE TABLE dogs (
	dog_id varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
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

COPY dogs
FROM '/Users/stephanie/Desktop/NYC_Dog_Licensing_Dataset copy.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- Creating indeces for faster searching

CREATE INDEX name_idx ON dogs (name);
CREATE INDEX zipcode_idx ON dogs (zipcode);
CREATE INDEX breed_idx ON dogs (breed);

-- Checking dataset

SELECT * FROM dogs

-- CREATE TABLE statement for NYC zipcode/borough data

CREATE TABLE nyc(
	zipcode varchar(5) NOT NULL,
	borough varchar(13) NOT NULL,
	neighborhood varchar(30) NOT NULL
);

COPY nyc
FROM '/Users/stephanie/Desktop/dogproj/zipcode_borough.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',')



-- Update dog licensing table with boroughs(inherently empty) from NYC/boroughs table
UPDATE dogs
SET borough = nyc.borough
FROM
   nyc
WHERE
   dogs.zipcode = nyc.zipcode;

-- Check that they match up (used on a smaller data subset)
SELECT d.borough_copy, d.zipcode, n.borough, n.zipcode
FROM dogs d join nyc n ON d.zipcode = n.zipcode;


