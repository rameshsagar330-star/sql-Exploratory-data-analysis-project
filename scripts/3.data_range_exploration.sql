		/*	----======================----
			---- DATA RANGE EXPLORATION ----
			----======================----
--Find the date date of first and last
--How many yearts old sales are available    
*/

SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_date,
DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_date_month
FROM gold.fact_sales;

--Find the youngest and the oldest customer
SELECT 
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS old_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS young_age
FROM gold.dim_customers
