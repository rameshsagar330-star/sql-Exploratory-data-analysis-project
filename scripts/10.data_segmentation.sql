--------------------
--DATA SEGMENTATION
--------------------
-- [measure] by [measure]
/* segment products into cost ranges and count how many products fall into each segment*/
WITH product_segment AS(
SELECT
product_key,
product_name,
cost,
CASE WHEN cost < 100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	 ELSE 'Above 1000'
	 END  cost_range
FROM gold.dim_products)
SELECT
cost_range,
COUNT(product_key) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC

/* Group customers into three segments based in their dspending behavior:
	-VIP	: customers with at least 12 months of history and spending more than 5000/-.
	-Regular: customers with at least 12 months of history and spending 5000/- oe less.
	-New	: Customers with a lifespan less than 12 months.
and find the total number of customers by each group
*/
WITH customer_spending AS (
SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key)
SELECT
	customer_key,
	total_spending,
	life_span,
	CASE WHEN life_span >= 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN life_span <= 12 AND total_spending <= 5000 THEN 'Regular'
		 ELSE 'New'
	END customer_segment
FROM customer_spending;

--counting the total customers
WITH customer_spending01 AS (
SELECT
	c.customer_key,
	SUM(f.sales_amount) AS total_spending,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)
SELECT
	customer_segment,
	COUNT(customer_key) AS total_customers
FROM(
SELECT
	customer_key,
	CASE WHEN life_span >= 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN life_span <= 12 AND total_spending <= 5000 THEN 'Regular'
		 ELSE 'New'
	END customer_segment
FROM customer_spending01)t
GROUP BY  customer_segment
ORDER BY total_customers DESC;
