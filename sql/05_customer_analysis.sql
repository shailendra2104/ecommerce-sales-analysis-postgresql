-- ============================================
-- Customer Analysis
-- ============================================


-- 1. Customer-wise Sales

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    SUM(oi.quantity) AS units_purchased,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spending DESC;


-- 2. Top 5 Customers

SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 5;


-- 3. Repeat Customers

SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS delivered_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY delivered_orders DESC;


-- 4. Customer AOV

WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.customer_name,
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.customer_id,
        c.customer_name,
        o.order_id
)
SELECT
    customer_name,
    ROUND(AVG(order_value), 2) AS customer_aov
FROM customer_orders
GROUP BY customer_id, customer_name
ORDER BY customer_aov DESC;


-- 5. Customer Segmentation

WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_name,
    total_spending,
    CASE
        WHEN total_spending >= 50000 THEN 'Premium'
        WHEN total_spending >= 20000 THEN 'Regular'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_sales
ORDER BY total_spending DESC;


-- 6. Customer Ranking

WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_name,
    total_spending,
    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;


-- 7. Top Customer in Each City

WITH customer_sales AS (
    SELECT
        c.city,
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.city,
        c.customer_id,
        c.customer_name
),
ranked_customers AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY total_spending DESC
        ) AS city_rank
    FROM customer_sales
)
SELECT
    city,
    customer_name,
    total_spending
FROM ranked_customers
WHERE city_rank = 1
ORDER BY total_spending DESC;