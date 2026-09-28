-- ============================================
-- Order & Payment Analysis
-- ============================================


-- 1. Order Status Count

SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 2. Order Status Percentage

SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 3. Cancellation Rate

SELECT
    ROUND(
        COUNT(*) FILTER (
            WHERE order_status = 'Cancelled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct
FROM orders;


-- 4. Payment Method Usage

SELECT
    payment_method,
    COUNT(*) AS order_count
FROM orders
GROUP BY payment_method
ORDER BY order_count DESC;


-- 5. Payment Method Revenue

SELECT
    o.payment_method,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.payment_method
ORDER BY revenue DESC;


-- 6. Payment Method Revenue Contribution

WITH payment_sales AS (
    SELECT
        o.payment_method,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.payment_method
)
SELECT
    payment_method,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_contribution_pct
FROM payment_sales
ORDER BY revenue DESC;


-- 7. City-wise Cancellation Rate

SELECT
    c.city,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE o.order_status = 'Cancelled'
    ) AS cancelled_orders,
    ROUND(
        COUNT(*) FILTER (
            WHERE o.order_status = 'Cancelled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY cancellation_rate_pct DESC;


-- 8. Payment Method + Order Status

SELECT
    payment_method,
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY
    payment_method,
    order_status
ORDER BY
    payment_method,
    order_status;


-- 9. City + Payment Analysis

SELECT
    c.city,
    o.payment_method,
    COUNT(*) AS order_count
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.city,
    o.payment_method
ORDER BY
    c.city,
    order_count DESC;