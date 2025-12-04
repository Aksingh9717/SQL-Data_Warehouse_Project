===============================================================================================================
-- DATE EXPLORATION
===============================================================================================================

-- Find the date of the first and last order
-- How many years of sales are available
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) as last_order_date,
DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) as order_range_year
FROM gold.fact_sales
--------------------------------------------------------------------------------------------------------------
-- Find the youngest and the oldest customer
SELECT
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(YEAR,MIN(birthdate),GETDATE()) as oldest_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(YEAR,MAX(birthdate),GETDATE()) as youngest_age
FROM gold.dim_customers
