CREATE DATABASE SQL_Sales_Project;	
-- SQL Retail Sales Analysis 
-- Create TABLE
DROP TABLE IF EXISTS Retail_Sales_Project
CREATE TABLE Retail_Sales_Project

					(
						transactions_id INT PRIMARY KEY,
						sale_date DATE,
						sale_time TIME,
						customer_id INT,
						gender VARCHAR(15),
						age INT,
						category VARCHAR(15),
						quantity INT,
						price_per_unit FLOAT,
						cogs FLOAT,
						total_sale FLOAT




					);
SELECT TOP 10* FROM [dbo].[SALES ANALYSIS]
WHERE transactions_id is null
or 
sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null

--
DELETE FROM [dbo].[SALES ANALYSIS]
WHERE transactions_id is null
or 
sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null
--
SELECT COUNT(*) AS TotalRows
FROM [dbo].[SALES ANALYSIS] AS SA;



-- Data Exploration

-- How many sales do we have?
SELECT COUNT (*) AS total_sale from [dbo].[SALES ANALYSIS]

-- How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) AS total_sales from [dbo].[SALES ANALYSIS]

-- How many categories do we have?
SELECT COUNT(DISTINCT category) AS total_categories from [dbo].[SALES ANALYSIS]

-- Data Analysis & Business Key Problems & Answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 SELECT *
FROM [dbo].[SALES ANALYSIS]
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT TOP 1 * FROM [dbo].[SALES ANALYSIS];
SELECT DISTINCT category FROM [dbo].[SALES ANALYSIS];
SELECT MIN(sale_date), MAX(sale_date) FROM [dbo].[SALES ANALYSIS];

SELECT *
FROM [dbo].[SALES ANALYSIS]
WHERE category = 'Clothing'
  AND quantity >= 4
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';

  -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
	category,
	SUM(total_sale) AS net_sale,
	COUNT (*) AS total_orders
FROM [dbo].[SALES ANALYSIS]
  GROUP BY category;
  
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
category,
	CAST(ROUND(AVG(age), 2) AS DECIMAL(10, 2)) AS avg_age
FROM [dbo].[SALES ANALYSIS]
WHERE category = 'Beauty'
GROUP BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM [dbo].[SALES ANALYSIS]
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
	category,
	gender,
COUNT (*) AS total_transactions
FROM [dbo].[SALES ANALYSIS]
GROUP BY
category,
gender
ORDER BY 1


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
    
SELECT 
    sale_year,
    sale_month,
    avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM [dbo].[SALES ANALYSIS]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_months
WHERE rank = 1
ORDER BY sale_year;





   

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT
customer_id,
SUM(total_sale) as total_sales
FROM [dbo].[SALES ANALYSIS]
GROUP BY customer_id
ORDER BY total_sales DESC
SELECT TOP 5 *
FROM [dbo].[SALES ANALYSIS]

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
category,
COUNT(DISTINCT customer_id) as unique_customers
FROM [dbo].[SALES ANALYSIS]
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
CASE
	WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
	WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END as shift
FROM [dbo].[SALES ANALYSIS]
)
SELECT
shift,
COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift




- End of Project

  



















