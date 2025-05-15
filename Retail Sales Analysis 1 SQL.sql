-- SQL Retail Sales Analysis - P1

-- Create Table 
CREATE TABLE retail_sales_1
	(
		transactions_id INT PRIMARY KEY,
		sale_date	DATE,
		sale_time	TIME,
		customer_id	INT,
		gender	VARCHAR(15),
		age	INT,
		category VARCHAR(15),	
		quantiy	INT,
		price_per_unit FLOAT,	
		cogs FLOAT,
		total_sale FLOAT
	);

SELECT * 
	FROM retail_sales_1
	LIMIT 10

SELECT COUNT(*) 
	FROM retail_sales_1

-- To find NULL Value 

SELECT * 
	FROM retail_sales_1
	WHERE transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Deleting NULL Values

DELETE FROM retail_sales_1
	WHERE transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

SELECT COUNT(*) 
	FROM retail_sales_1;

-- Data Exploration

-- No. of days?
SELECT COUNT(*)as total_sale FROM retail_sales_1;

-- no. of cusytomers?
SELECT COUNT(DISTINCT customer_id)as total_sale FROM retail_sales_1;

-- categories?
SELECT DISTINCT category as total_sale FROM retail_sales_1;


-- DATA ANALYSIS - SOLVING BUSINESS PROBLEMS

-- 1) SALES MADE ON SPECIFIC DATE?
SELECT *
	FROM retail_sales_1
	WHERE sale_date = '2022-11-05';                           
	
-- 2) Clothing with sales >10 times and in Nov'22
SELECT *
	FROM retail_sales
	WHERE category = 'clothing'
		AND
		TO_CHAR(sale_date,'YYYY-MM')='2022-22'
		AND quantiy>=4;

-- 3) total sale for each category
SELECT 
	category,
	SUM(total_sale) AS net_sale,
	COUNT(*) AS total_orders
FROM retail_saleS_1
GROUP BY 1

-- 4) Avg age of customers who bought from beauty category
SELECT 
	ROUND(AVG(age),2) AS avg_age
FROM retail_sales_1
WHERE category ='Beauty';


-- 5) Find all  where total sale > 1000
SELECT *
FROM retail_sales_1
WHERE t0tal_sale >1000;


-- 6) total NO. transsactions by each gender in each category?
SELECT 
	category,gender,
	COUNT(*) AS total_transactions
FROM retail_sales_1
GROUP BY 1,2
ORDER BY 1;

-- 7) Calculate avg selling in each month 
--		best month in each year
SELECT 
	year,
	month,
	avg_sale
FROM
	(SELECT
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) AS month,
		AVG(total_sale) AS avg_sale,
		-- for part 2
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales_1  
		GROUP BY 1,2 	
	) as t1
where rank = 1	
	
-- ORDER BY 1,3 DESC 


-- 8) top 5 custometers with highest total sales?
SELECT 
	customer_id,
	SUM(total_sale) AS Total_sales
FROM retail_sales_1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 9)No. of UNIQUE custometers who purchased from each category?
SELECT  
	category,
	COUNT(DISTINCT customer_id)	AS no. of unique customers
FROM retail_sales_1
GROUP BY 1;

-- 10) each shift and no. of orders in each shift?
WITH hourly_sales
AS
(SELECT *,
	CASE
		WHEN EXTRACT (HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 16 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales_1
)
SELECT 
	shift,
	COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift 
ORDER BY total_orders DESC;


--END of Questions