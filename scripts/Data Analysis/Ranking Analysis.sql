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
----------------------------------------------------------------------------------------------------------------
---What are the 5 worst-performing products in terms of sales?
SELECT TOP 5 dp.product_name,
SUM(fs.sales_amount) as total_revenue
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_products as dp
ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue 
----------------------------------------------------------------------------------------------------------------
-- Find the Top 10 customers who have genrated the highest revenue
SELECT * FROM gold.fact_sales
SELECT * FROM gold.dim_customers
----------------------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------------------
