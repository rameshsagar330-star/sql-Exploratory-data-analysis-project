			/*----======================----
			---- DIMENSION EXPLORATION ----
			----======================----
-- Explore all countries our customers come fromz
*/
SELECT DISTINCT country FROM gold.dim_customers;

-- Explore all Categories "The major Divisions"
SELECT DISTINCT
  category,
  subcategory,
  product_name
FROM gold.dim_products
ORDER BY 1,2,3;
