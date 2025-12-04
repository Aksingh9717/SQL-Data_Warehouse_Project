===============================================================================================================
--MEASURE EXPLORATION
===============================================================================================================
-- Find the Total Sales
SELECT SUM(sales_amount) As Total_sales FROM gold.fact_sales
---------------------------------------------------------------------------------------------------------------
-- Find how many items are sold
SELECT SUM(quantity)as total_quantity FROM gold.fact_sales
---------------------------------------------------------------------------------------------------------------
-- Find the average selling price
SELECT AVG(price) as avg_price FROM gold.fact_sales
---------------------------------------------------------------------------------------------------------------
-- Find the Total number of Orders
SELECT COUNT(order_number) as total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) as total_orders FROM gold.fact_sales
---------------------------------------------------------------------------------------------------------------
-- Find the Total number of products
SELECT COUNT(product_name) as total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_name) as total_products FROM gold.dim_products
---------------------------------------------------------------------------------------------------------------
-- Find the Total number of customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers
---------------------------------------------------------------------------------------------------------------
-- Find the Total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales
---------------------------------------------------------------------------------------------------------------

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
---------------------------------------------------------------------------------------------------------------
