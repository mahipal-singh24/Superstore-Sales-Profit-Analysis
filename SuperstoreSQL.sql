# creating super store database
CREATE DATABASE superstore_db;
use superstore_db;

#Creating superstore table
CREATE TABLE superstore (
    row_id INT,
    order_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(30),
    customer_id VARCHAR(30),
    customer_name VARCHAR(100),
    segment VARCHAR(30),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(10),
    region VARCHAR(30),
    product_id VARCHAR(30),
    category VARCHAR(30),
    sub_category VARCHAR(30),
    product_name VARCHAR(255),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2),
    year INT,
    month INT,
    month_name VARCHAR(15),
    shipping_days INT
);

#testing purpose
CREATE TABLE superstore_staging (
    row_id TEXT,
    order_id TEXT,
    order_date TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code TEXT,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales TEXT,
    quantity TEXT,
    discount TEXT,
    profit TEXT,
    year TEXT,
    month TEXT,
    month_name TEXT,
    shipping_days TEXT
);

INSERT INTO superstore
SELECT
    CAST(row_id AS UNSIGNED),
    order_id,
    STR_TO_DATE(order_date, '%Y-%m-%d'),
    STR_TO_DATE(ship_date, '%Y-%m-%d'),
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    CAST(sales AS DECIMAL(12,2)),
    CAST(quantity AS UNSIGNED),
    CAST(discount AS DECIMAL(5,2)),
    CAST(profit AS DECIMAL(12,2)),
    CAST(year AS UNSIGNED),
    CAST(month AS UNSIGNED),
    month_name,
    CAST(shipping_days AS UNSIGNED)
FROM superstore_staging;

select count(*) from superstore;

SELECT *
FROM superstore_staging
LIMIT 5;

SELECT
    COUNT(*) AS invalid_decimal_rows
FROM superstore_staging
WHERE sales NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$'
   OR discount NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$'
   OR profit NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';
   
SELECT
    COUNT(*) AS empty_sales,
    SUM(discount = '') AS empty_discount,
    SUM(profit = '') AS empty_profit
FROM superstore_staging;

DESCRIBE superstore;

SELECT
    row_id,
    sales,
    discount,
    profit
FROM superstore_staging
WHERE sales NOT REGEXP '^-?[0-9]+([.][0-9]+)?$'
   OR discount NOT REGEXP '^-?[0-9]+([.][0-9]+)?$'
   OR profit NOT REGEXP '^-?[0-9]+([.][0-9]+)?$'
LIMIT 20;

USE superstore_db;

SELECT 
    COUNT(*) AS total_rows,
    MIN(row_id) AS min_row_id,
    MAX(row_id) AS max_row_id
FROM superstore;

SELECT 
    row_id,
    COUNT(*) AS count
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1;

SELECT
    SUM(row_id IS NULL) AS null_row_id,
    SUM(order_id IS NULL) AS null_order_id,
    SUM(order_date IS NULL) AS null_order_date,
    SUM(sales IS NULL) AS null_sales,
    SUM(profit IS NULL) AS null_profit
FROM superstore;

-- Which product category generates the most sales and profit?
select 
	category,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    sum(quantity) as total_quantity,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by category
order by total_sales desc;
-- Technology is the strongest category, generating the highest sales and highest profit.
-- Furniture is a concern because although it generates substantial sales, its profit is much lower than Technology and Office Supplies.
-- Furniture has sales close to Technology, but its profit margin is only 2.49%.

select 
	sub_category,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    sum(quantity) as total_quantity,
	round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by sub_category
order by total_profit desc;

-- Which subcategories are losing money?
select
	sub_category,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    sum(quantity) as total_quantity,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by sub_category
having total_profit < 0
order by total_profit desc;
-- Tables is the main loss-making subcategory and should be investigated first.

-- -------------------- Regional Performance -----------------------------

-- Which region generates the most sales and profit, and which region performs poorly?
select
	region,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    sum(quantity) as total_quantity,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by region
order by total_profit desc;
-- So Central is the region we should investigate.

-- ------------- Segment Performance -----------
-- Which region generates the most sales and profit, and which region performs poorly?
select
	segment,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by segment 
order by total_profit desc;
-- so sales volume not equal to profitability.

-- -----------------Yearly Performance --------------------

select
	year,
    sum(sales) as total_profit,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by year
order by year;

-- --------------Monthly Performance------------

select 
	month,
    month_name,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by month, month_name
order by month;

-- ----------------------State-Level Performance--------------------
-- Which states generate the most profit, and which states are actually losing money?

select
	state,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by state
order by total_profit desc;
-- California → highest profit: $76,381
-- New York → $74,039 profit with 23.82% margin
-- Texas → biggest loss: -$25,729
-- Ohio → -$16,971, lowest margin among these states at -21.69%
-- Pennsylvania → -$15,560
-- Several states have strong margins despite lower sales, such as Indiana (34.33%) and Minnesota (36.24%).

-- --------------------------- Loss-Making States ------------------
SELECT
    state,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY state
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;
-- these states need more attention
-- we have done so far
-- Category → Subcategory → Region → Segment → Year → Month → State

-- --------------------Top 10 Most Profitable Products ---------------

select
	product_name,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by product_name
order by total_profit desc
limit 10;

-- ------------------Bottom 10 Products by Profit -----------------
-- Which individual products are causing the biggest losses?

SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 10;
-- This is useful because now we can investigate whether high discounts are causing these losses.

-- -------------------------Discount vs Profit--------------------

SELECT
    discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY discount
ORDER BY discount;
-- The major turning point is around 30% discount. Above this level, the dataset becomes loss-making overall.
-- High discount → lower profit margin → losses in certain products/categories.

-- ----------------Shipping Mode Performance --------------------------
SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(AVG(shipping_days), 2) AS avg_shipping_days,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY ship_mode
ORDER BY total_profit DESC;

-- --------------------Top Customers by Profit------------------
SELECT
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;
-- These customers have relatively high margins, so they could be considered high-value customers.

-- Which Customers Generate the Most Sales?
SELECT
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;
-- Sean Miller
-- Sales: $25,043 → highest among customers
-- Profit: -$1,980.74 
-- Profit margin: -7.91%

-- Tamara Chand
-- Sales: $19,052
-- Profit: $8,981
-- Margin: 47.14%

-- High sales don't necessarily mean high profitability.

-- Find Loss-Making Customers
select 
	customer_name,
    count(order_id) as total_order,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by customer_name
having total_profit < 0
order by total_profit
limit 10;

-- Which Products Are Being Sold at High Discounts?
select
	product_name,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin,
    ROUND(AVG(discount) * 100, 2) AS avg_discount
from superstore
group by product_name
order by avg_discount desc
limit 10;

-- Average discount ≥ 30%
-- Total profit < 0
-- These are the products that deserve the most attention from management because they're being heavily discounted and losing money.

select
	product_name,
    round(avg(discount)*100,2) as avg_discount,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round((sum(profit)/sum(sales))*100,2) as profit_margin
from superstore
group by product_name
HAVING AVG(discount) >= 0.30
   AND SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 10;

 