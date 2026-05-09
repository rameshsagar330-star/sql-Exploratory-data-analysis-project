					----===========================----
					---- CHANGE OVER TIME ANALYSIS ----
					----===========================----

--Analyze how a measure evolves over time.
--[measure] by [data dimension]
--total sales per year
SELECT 
YEAR(order_date) AS order_year,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

--total sales per month
SELECT 
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)

--total sales per year and month
SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) as order_month,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)

--for only year a with sum of sales with total customers
SELECT 
YEAR(order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

--for only year and month with sum of sales and total customers
SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)

--for only year and month a with sum of sales, total quantity and total customers
SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)

--for only year a with sum of sales, total quantity and total customers in different aproch 1
SELECT 
DATETRUNC(YEAR, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
ORDER BY DATETRUNC(YEAR, order_date)

-- [BEST APROCH] for only month a with sum of sales, total quantity and total customers in different aproch 2
SELECT 
DATETRUNC(MONTH, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date)

--for only month a with sum of sales, total quantity and total customers in different aproch 3
SELECT 
FORMAT(order_date, 'YYYY-MMM') AS order_date,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'YYYY-MMM')
ORDER BY FORMAT(order_date, 'YYYY-MMM')
