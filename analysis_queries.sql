-- ============================================================
-- Retail Operations SQL: Subqueries & Table Joins
-- Author: Ava Szczygiel
-- Tools: MySQL 8.0
-- Description: Demonstrates subqueries (IN, correlated), and
--              table joins (INNER JOIN, JOIN, LEFT OUTER JOIN)
--              to answer multi-table business questions on a
--              retail operations database.
-- ============================================================

USE aa630_m2_activity;

-- ============================================================
-- PART 1: WARM-UP — FILTERING, CALCULATED FIELDS & GROUPING
-- ============================================================

-- 1.1: Products whose description contains the word 'jet'
-- Business Question: Which products are jet-related?
-- Technique: LIKE with % wildcard for partial text matching

SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%jet%';


-- 1.2: Product ID, original price, and price with $0.50 added
-- Business Question: What would prices look like with a $0.50 price increase?
-- Technique: Arithmetic calculated field with AS alias; sorted by new price DESC
-- Note: Fixed from original — CONCAT() was used incorrectly; correct approach
--       is arithmetic addition to create a true numeric calculated field.

SELECT
    prod_id,
    prod_price,
    ROUND(prod_price + 0.50, 2) AS new_price
FROM products
ORDER BY new_price DESC;


-- 1.3: Item prices and how many times each price appears in OrderItems
-- Business Question: Which price points are most common in orders?
-- Technique: GROUP BY with COUNT() to aggregate frequency by price

SELECT
    item_price,
    COUNT(*) AS times_ordered
FROM orderitems
GROUP BY item_price
ORDER BY item_price ASC;


-- ============================================================
-- PART 2: SUBQUERIES
-- ============================================================

-- 2.1: Customer IDs for orders containing at least one item priced $10 or more
-- Business Question: Which customers have placed high-value orders?
-- Technique: Subquery with IN to filter orders from OrderItems by price threshold

SELECT cust_id
FROM orders
WHERE order_num IN (
    SELECT order_num
    FROM orderitems
    WHERE item_price >= 10
);


-- 2.2: Customer ID and order date for orders containing product 'FB' (Bird seed)
-- Business Question: Which customers ordered Bird seed and when?
-- Technique: Subquery with IN filtering by specific prod_id; sorted chronologically

SELECT cust_id, order_date
FROM orders
WHERE order_num IN (
    SELECT order_num
    FROM orderitems
    WHERE prod_id = 'FB'
)
ORDER BY order_date ASC;


-- 2.3: Each product name alongside total quantity sold across all orders
-- Business Question: Which products have the highest total sales volume?
-- Technique: Correlated subquery — references the outer query's prod_id to
--            compute a per-product SUM(quantity) from OrderItems

SELECT
    prod_name,
    (SELECT SUM(quantity)
     FROM orderitems
     WHERE orderitems.prod_id = products.prod_id) AS quant_sold
FROM products
ORDER BY quant_sold DESC;


-- ============================================================
-- PART 3: TABLE JOINS
-- ============================================================

-- 3.1: Customer name and order number using INNER JOIN
-- Business Question: Which customers have placed orders (matched records only)?
-- Technique: INNER JOIN returns only rows with matching cust_id in both tables;
--            excludes customers with no orders

SELECT cust_name, order_num
FROM customers
INNER JOIN orders ON customers.cust_id = orders.cust_id
ORDER BY cust_name ASC, order_num ASC;


-- 3.2: Same result using shorthand JOIN (equivalent to INNER JOIN)
-- Business Question: Confirm JOIN and INNER JOIN produce identical results
-- Technique: JOIN is shorthand for INNER JOIN in MySQL — same behavior,
--            cleaner syntax for simple equi-joins

SELECT cust_name, order_num
FROM customers
JOIN orders ON customers.cust_id = orders.cust_id
ORDER BY cust_name ASC;


-- 3.3: Customer name and order number using LEFT OUTER JOIN
-- Business Question: Which customers exist in the system, with or without orders?
-- Technique: LEFT OUTER JOIN retains ALL rows from the left table (customers),
--            filling order_num with NULL for customers who have never placed an order.
--            Useful for identifying inactive customers.

SELECT cust_name, order_num
FROM customers
LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id
ORDER BY cust_name ASC;
