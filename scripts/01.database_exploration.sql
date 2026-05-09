			----======================----
			---- DATABASE EXPLORATION ----
			----======================----
-- Explore All Objects in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore All columns in the database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';
