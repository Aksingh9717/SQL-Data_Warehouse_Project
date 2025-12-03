--EDA-EXPLORATORY DATA ANALYSIS
===============================================================================================================
--DATABASE EXPLORATION
===============================================================================================================

--Explore All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES;
--------------------------------------------------------------------------------------------------------------
--Explore All Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;
--------------------------------------------------------------------------------------------------------------
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';


===============================================================================================================
--DIMENSIONS EXPLORATION
===============================================================================================================
--Explore All the Countries our customers come from.
SELECT DISTINCT country FROM gold.dim_customers;
--------------------------------------------------------------------------------------------------------------
--Explore All Categories "The Major Divisons"
SELECT DISTINCT category, subcategory,product_name FROM gold.dim_products
ORDER BY 1,2,3;

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


===============================================================================================================
--MEASURE EXPLORATION
===============================================================================================================
-- Find the Total Sales
SELECT SUM(sales_amount) As Total_sales FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity)as total_quantity FROM gold.fact_sales

-- Find the average selling price
SELECT AVG(price) as avg_price FROM gold.fact_sales

-- Find the Total number of Orders
SELECT COUNT(order_number) as total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) as total_orders FROM gold.fact_sales

-- Find the Total number of products
SELECT COUNT(product_name) as total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_name) as total_products FROM gold.dim_products

-- Find the Total number of customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

-- Find the Total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales


---- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM  gold.fact_sales
UNION ALL
SELECT 'Total Quantity' , SUM(quantity) FROM  gold.fact_sales
UNION ALL
SELECT 'Average Price' , AVG(price) FROM  gold.fact_sales
UNION ALL
SELECT 'Total No. Orders' ,COUNT(DISTINCT order_number) FROM  gold.fact_sales
UNION ALL 
SELECT 'Total No. Products' ,COUNT(DISTINCT product_name) FROM  gold.dim_products
UNION ALL
SELECT 'Total No. Customers' ,COUNT(DISTINCT customer_key) FROM  gold.dim_customers

===============================================================================================================
-- (MAGNITUDE) MEASURE AND DIMESNIONS EXPLORATIONS
===============================================================================================================


--Find total customers by countries
SELECT COUNT(customer_key)as total_customers,country 
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC

--Find total customers by gender
SELECT COUNT(gender)as total_customers,gender 
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC


--Find total products by category
SELECT category,
COUNT(product_key) as total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC


--What is the average costs in eachcategory?
select category,
avg(cost) as avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY category DESC

--What is the total revenue generated for each category
SELECT dp.category,
SUM(fs.sales_amount) as total_revenue
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_products as dp
ON fs.product_key = dp.product_key
GROUP BY dp.category
ORDER BY total_revenue DESC

--Find the total revenue is generated by each customer
SELECT dc.customer_key,
dc.first_name, dc.last_name,
SUM(fs.sales_amount) as total_revenue
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_customers as dc
ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key,dc.first_name, dc.last_name
ORDER BY total_revenue DESC

--What is the distribution of sold items across countries?
SELECT dc.country,
SUM(fs.quantity) as total_sold_items
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_customers as dc
ON fs.customer_key = dc.customer_key
GROUP BY dc.country
ORDER BY total_sold_items DESC


===============================================================================================================
--RANKING ANALYSIS
===============================================================================================================

--Which 5 products generate the highest revenue?
SELECT
TOP 5 dp.product_name,
SUM(fs.sales_amount) as total_revenue
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_products as dp
ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue DESC

---What are the 5 worst-performing products in terms of sales?
SELECT TOP 5 dp.product_name,
SUM(fs.sales_amount) as total_revenue
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_products as dp
ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue 

-- Find the Top 10 customers who have genrated the highest revenue
SELECT * FROM gold.fact_sales
SELECT * FROM gold.dim_customers

SELECT TOP 10 dc.customer_key,
dc.first_name, dc.last_name,
SUM(fs.sales_amount) as total_revenue
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_customers as dc
ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key,
dc.first_name, 
dc.last_name
ORDER BY total_revenue DESC

--3 Customers with the fewest orders placed
SELECT TOP 3 dc.customer_key,
dc.first_name, dc.last_name,
COUNT(DISTINCT order_number) as total_orders
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_customers as dc
ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key,
dc.first_name, 
dc.last_name
ORDER BY total_orders








