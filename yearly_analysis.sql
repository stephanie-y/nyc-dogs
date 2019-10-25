-- Extracting data for each years
-- Below is a sample code for data pulled on licenses issued in the year 2018
-- The date should be ISO-8601 format, YYYY-MM-DD
COPY (
SELECT *
FROM dogs
WHERE issue_date::date < '2019-01-01' AND issue_date::date > '2017-12-31' 
ORDER BY issue_date DESC
)
TO '/Users/stephanie/Desktop/dogproj/2018.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- Create a .csv for each year for an individual yearly analysis

CREATE TABLE dog_2018 (
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

-- Importing data from the main data set

COPY dog_2018 (
	data_id,
	name,
	gender,
	birth_year,
	breed, 
	borough,
	zipcode,
	issue_date,
	expire_date,
	extract_year
)
FROM '/Users/stephanie/Desktop/dogproj/2018.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT * FROM dog_2018;

-- Just getting rid of stuff that won't be useful later on (OPTIONAL)
ALTER TABLE dog_2018 DROP COLUMN data_id;
ALTER TABLE dog_2018 DROP COLUMN extract_year;

-- Extracting data of most popular dog breeds per year ordered from most popular to least
COPY (
SELECT breed, count(*) FROM dog_2018
WHERE breed <> 'Unknown'
GROUP BY breed
ORDER BY count(*) DESC
	)
TO '/Users/stephanie/Desktop/dogproj/most-popular-2018.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');