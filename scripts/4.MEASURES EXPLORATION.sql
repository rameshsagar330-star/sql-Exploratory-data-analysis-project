	/*	----======================----
			---- MEASURES EXPLORATION ----
			----======================---- */
--find the Total Sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales
--Find how may items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales
--Find the avarage selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales
--Find the Total number of orders
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales
--Find the Total number of products
SELECT COUNT(product_key) AS total_orders FROM gold.dim_products
SELECT COUNT(DISTINCT product_name) AS total_orders FROM gold.dim_products
--Find the Total number of customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers
--Find the Total number of customers tha has placed an order
SELECT COUNT(customer_key) AS total_customers FROM gold.fact_sales
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales

--Generate a Report that shows all key metrics of the business
SELECT 'Total_sales'  AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total_quantity'  AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Avarage_price', AVG(price) AS avg_price FROM gold.fact_sales
UNION ALL
SELECT 'Total_orders', COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales
UNION ALL
SELECT 'Total_products', COUNT(product_name) AS total_orders FROM gold.dim_products
UNION ALL
SELECT 'Total_customers', COUNT(customer_key) AS total_customers FROM gold.dim_customers
