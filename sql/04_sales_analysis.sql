-- ============================================
-- Sales Analysis & Core KPIs
-- ============================================


-- 1. Total Orders

SELECT
    COUNT(*) AS total_orders
FROM orders;


-- 2. Delivered Orders

SELECT
    COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'Delivered';


-- 3. Cancelled Orders

SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';


-- 4. Total Units Sold

SELECT
    SUM(oi.quantity) AS total_units_sold
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered';


-- 5. Total Revenue

SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered';


-- 6. Average Order Value

WITH order_values AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.order_id
)
SELECT
    ROUND(AVG(order_value), 2) AS average_order_value
FROM order_values;


-- 7. Revenue by Payment Method

SELECT
    o.payment_method,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.payment_method
ORDER BY revenue DESC;


-- 8. Revenue by City

SELECT
    c.city,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.city
ORDER BY revenue DESC;


-- 9. City Revenue Contribution

WITH city_sales AS (
    SELECT
        c.city,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.city
)
SELECT
    city,
    revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_contribution_pct
FROM city_sales
ORDER BY revenue DESC;


-- 10. Overall KPI Report

WITH sales AS (
    SELECT
        COUNT(DISTINCT o.order_id) AS delivered_orders,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
),
order_values AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.order_id
)
SELECT
    s.delivered_orders,
    s.units_sold,
    s.total_revenue,
    ROUND(AVG(ov.order_value), 2) AS average_order_value
FROM sales AS s
CROSS JOIN order_values AS ov
GROUP BY
    s.delivered_orders,
    s.units_sold,
    s.total_revenue;