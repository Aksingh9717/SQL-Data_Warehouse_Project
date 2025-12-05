/*
=========================================================
Customer Report
=========================================================
Purpose:
 - This report consolidates key custome metrics and behaviors

 Highlights:
	1. Gathers essentials fields such as names , ages and transaction details.
	2. Segments customers into categories(VIP , Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		-- total orders
		-- total sales
		-- total quantity purchased
		-- total products
		-- lifespan(in months)
	4. Calculates valuable KPIs:
		-- recency (months since last order)
		-- average order value
		-- average monthly spend
===========================================================
*/

CREATE VIEW gold.report_customers AS
WITH base_query AS(
/*-----------------------------------------------------------
1) Base Query: Retrieves core columns from tables
-------------------------------------------------------------*/
SELECT
fs.order_number,
fs.product_key,
fs.order_date,
fs.sales_amount,
fs.quantity,
dc.customer_key,
dc.customer_number,
CONCAT(dc.first_name,' ',dc.last_name) as customer_name,
DATEDIFF(YEAR,dc.birthdate,GETDATE()) as age
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_customers as dc
ON dc.customer_key = fs.customer_key
WHERE order_date is NOT NULL)

,customer_aggregations AS(
/*-----------------------------------------------------------
1) Customer Aggregations: Summarize key metrics at the customer level
-------------------------------------------------------------*/
SELECT
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) as total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) as total_quantity,
COUNT(DISTINCT product_key) as total_products,
MAX(order_date) as last_order_date,
DATEDIFF (month,MIN(order_date),MAX(order_date)) as lifespan
FROM base_query
GROUP BY
customer_key,
customer_number,
customer_name,
age
)
SELECT 
customer_key,
customer_number,
customer_name,
age,
CASE 
	WHEN age<20 THEN 'Under 20'
	WHEN age between 20 and 29 THEN '20-29'
	WHEN age between 30 and 39 THEN '30-39'
	WHEN age between 40 and 49 THEN '40-49'
	ELSE '50 and above'
END AS age_group,
CASE WHEN lifespan>12 AND total_sales>5000 THEN 'VIP'
	WHEN  lifespan>=12 AND total_sales<=5000 THEN 'Regular'
	ELSE 'New'
END customer_segment,
DATEDIFF(month,last_order_date,GETDATE()) AS recency,
total_orders,
total_sales,
total_quantity,
total_products,
last_order_date,
lifespan,
--Compute average order value(AVO)
CASE WHEN total_sales =0 THEN 0
	ELSE total_sales/ total_orders
END AS avg_order_vale,
-- compute average monthly spend
CASE WHEN lifespan =0 THEN total_sales
	ELSE total_sales/ lifespan
END AS avg_monthly_spend
FROM customer_aggregations


Select * from [gold].[report_customers]

/*
===============================================================
Product Report
===============================================================
Purpose:
	- This report consolidated key products metrics and behaviors.
Highlights:
	1.Gathers essentials filelds such as product name, category, subcategory, and cost.
	2.Segments products by revenue to identify High -Performers, Mid-Range, or Low-Performers.
	3.Aggregates product - level metrics:
		-- total orders
		-- total sales
		-- total quantity sold
		-- total customers(unique)
		-- lifespan (in months)
	4. Calculates valuable KPIs:
		-- Recency (Months since last sale)
		-- average order revenue (AOR)
		-- Average monthly revenue

===============================================================
*/
CREATE VIEW gold.report_products AS
WITH base_query AS(
/*-------------------------------------------------------------------
1) Base Query: Retrieves core column from fact_sales and dim_products
-------------------------------------------------------------------*/

SELECT 
	fs.order_number,
	fs.customer_key,
	fs.order_date,
	fs.sales_amount,
	fs.quantity,
	dp.product_key,
	dp.product_name,
	dp.category,
	dp.subcategory,
	dp.cost
FROM gold.fact_sales as fs
LEFT JOIN gold.dim_products as dp
ON fs.product_key = dp.product_key
WHERE order_date IS NOT NULL -- considering valid sales dates only
),
product_aggregations AS(
/*-------------------------------------------------------------------
2) Product Aggregations: Summarize key metrics at the product level
-------------------------------------------------------------------*/
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS FLOAT)/NULLIF(quantity,0)),1) AS avg_selling_price
FROM base_query
GROUP BY
	product_key,
	product_name,
	category,
	subcategory,
	cost
)
/*-------------------------------------------------------------------
3) Final Query: Combines all the product results into one output
-------------------------------------------------------------------*/
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(MONTH, last_sale_date, GETDATE()) as recency_in_months,
	CASE	
		WHEN total_sales>50000 THEN 'High-Performer'
		WHEN total_sales>=10000 THEN 'Mid_Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	--Average Order Revenue
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales/total_orders
	END AS avg_order_revenue,
	--Average Monthly Revenue
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregations

select * from gold.report_products
