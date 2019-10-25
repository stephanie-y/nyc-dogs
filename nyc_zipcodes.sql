-- creating table for zipcodes

-- CREATE TABLE statement for NYC zipcode/borough data
-- New York County (Manhattan)
-- Kings County (Brooklyn)
-- Bronx County (The Bronx)
-- Richmond County (Staten Island)
-- Queens County (Queens)


CREATE TABLE nyc(
	county_name varchar(30),
	FIPS varchar(2),
	county_code varchar(3),
	County_fips varchar(5),
	zipcode varchar(5),
	somedate date
);

COPY nyc_data (
	county_name,
	FIPS,
	county_code,
	County_fips,
	zipcode,
	somedate
)
FROM '/Users/stephanie/Desktop/dogproj/New_York_State_ZIP_Codes-County_FIPS_Cross-Reference.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- Exporting all the necessary NYC and Long Island counties, 7 in total

COPY (
	SELECT zipcode, county_name, borough FROM nyc_data
	WHERE county_name = 'New York' OR 
	county_name = 'Kings' OR
	county_name = 'Bronx' OR
	county_name = 'Richmond' OR
	county_name = 'Queens' OR
	county_name = 'Suffolk' OR
	county_name = 'Nassau'
	ORDER BY zipcode ASC
	)
TO '/Users/stephanie/Desktop/dogproj/nyc_zipcodes.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- Creating new, simplified table

CREATE TABLE nyc_zipcodes (
	zipcode varchar(5),
	county varchar(15)

)