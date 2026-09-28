-- ============================================
-- E-Commerce Sales & Customer Analytics
-- Data Cleaning & Validation
-- PostgreSQL
-- ============================================


-- 1. Check NULL values in Customers

SELECT *
FROM customers
WHERE customer_id IS NULL
   OR customer_name IS NULL
   OR gender IS NULL
   OR city IS NULL
   OR state IS NULL
   OR signup_date IS NULL;


-- 2. Check NULL values in Products

SELECT *
FROM products
WHERE product_id IS NULL
   OR product_name IS NULL
   OR category IS NULL
   OR sub_category IS NULL
   OR price IS NULL;


-- 3. Check NULL values in Orders

SELECT *
FROM orders
WHERE order_id IS NULL
   OR customer_id IS NULL
   OR order_date IS NULL
   OR payment_method IS NULL
   OR order_status IS NULL;


-- 4. Check NULL values in Order Items

SELECT *
FROM order_items
WHERE order_item_id IS NULL
   OR order_id IS NULL
   OR product_id IS NULL
   OR quantity IS NULL
   OR unit_price IS NULL;


-- 5. Check duplicate Customer IDs

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 6. Check duplicate Product IDs

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- 7. Check duplicate Order IDs

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- 8. Check invalid quantities

SELECT *
FROM order_items
WHERE quantity <= 0;


-- 9. Check invalid prices

SELECT *
FROM products
WHERE price <= 0;

SELECT *
FROM order_items
WHERE unit_price <= 0;


-- 10. Check valid order statuses

SELECT DISTINCT order_status
FROM orders;


-- 11. Check valid payment methods

SELECT DISTINCT payment_method
FROM orders;


-- 12. Check orphan customer records

SELECT o.*
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 13. Check orphan product records

SELECT oi.*
FROM order_items AS oi
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


-- 14. Check orphan order records

SELECT oi.*
FROM order_items AS oi
LEFT JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- 15. Check product price consistency

SELECT
    oi.order_id,
    oi.product_id,
    p.price AS product_price,
    oi.unit_price AS order_item_price
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE p.price <> oi.unit_price;


-- 16. Check cancelled orders

SELECT *
FROM orders
WHERE order_status = 'Cancelled';