/*
============================================================================
PRODUCT REPORT
============================================================================
Purpose:
	- This report consolidates key product metrics and behaviors

Highlights:
	1. Gathers essential fields such as product names, category, subcategory, and cost.
	2. Segments products by revenue to identify High-performer, mid-range, and low-performers.
	3. Aggregates product-level metrics:
		- total orders
		- total sales
		- total quantity sold
		- total customers (unique)
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last sales)
		- avarage order revenue (AOR)
		- average monthly revenue
=============================================================================
*/

IF OBJECT_ID('gold.report_product', 'V') IS NOT NULL
	DROP VIEW gold.report_product;
GO
CREATE VIEW gold.report_product AS
/*-----------------------------------------------
1) Base Query: Retrieves core columns from table
-------------------------------------------------*/
WITH base_query AS (
SELECT 
	f.product_key,
	f.customer_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.category_id,
	f.order_number,
	f.order_date,
	f.sales_amount,
	f.price,
	p.cost,
	f.quantity
FROM gold.fact_sales f
INNER JOIN gold.dim_products p
ON p.product_key = f.product_key

),
/*---------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
----------------------------------------------------------------------*/
product_agrregation AS (
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	COUNT(order_number)									AS total_orders,
	SUM(sales_amount)									AS total_sales,
	SUM(quantity)										AS total_quantity,
	COUNT(DISTINCT customer_key)						AS Total_customers,
	AVG(price)											AS avg_selling_price,
	MAX(order_date)										AS last_sale_date,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date))	AS life_span
FROM base_query
GROUP BY product_key,
		 product_name,
		 category,
		 subcategory,
		 cost
)
/*--------------------------------------------------------------
3) Final Query: Combine all product results into one output
----------------------------------------------------------------*/
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	--Resency (months since last sale)
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
	CASE WHEN total_sales >= 50000 THEN 'High_Performer'
		 WHEN total_sales >= 10000 THEN 'Mid_Range'
		 ELSE 'Low_Performer'
	END segment_of_product,
	life_span,
	total_customers,
	total_orders,
	total_quantity,
	total_sales,
	avg_selling_price,
	--Average Order Revenue (AOR)
	CASE WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END average_order_revenue,
	-- Average Monthly Revenue
	CASE WHEN life_span = 0 THEN 0
		ELSE total_sales / life_span
	END average_monthly_sales
FROM product_agrregation
