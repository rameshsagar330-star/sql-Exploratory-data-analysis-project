/* 			-----------------------
  			--Cumulative analysis--
  			-----------------------    */
--[cumulative measure] by [date dimension]
--Calculate the total sales per month
--and the running total of sales over time
SELECT
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS runnign_total_sales
FROM
(
SELECT
DATETRUNC(MONTH, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
)t

--Calculate the total sales per year
--and the running total of sales over time
SELECT
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS runnign_total_sales
FROM
(
SELECT
DATETRUNC(YEAR, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
)t

--Calculate the total sales per year
--and the running total of sales over time with moving average price
SELECT
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS runnign_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) AS moving_avg_price
FROM
(
SELECT
DATETRUNC(YEAR, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
)t

--Calculate the total sales per month
--and the running total of sales over time with moving average price
SELECT
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS runnign_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) AS moving_avg_price
FROM
(
SELECT
DATETRUNC(MONTH, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
)t
