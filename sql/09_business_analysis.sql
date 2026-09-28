-- ============================================
-- Advanced Business Analysis
-- ============================================


-- 1. Customer Revenue Contribution

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
    ROUND(
        total_spending * 100.0 /
        SUM(total_spending) OVER (),
        2
    ) AS revenue_contribution_pct
FROM customer_sales
ORDER BY total_spending DESC;


-- 2. Repeat vs One-Time Customers

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS delivered_orders
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN delivered_orders = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY
    CASE
        WHEN delivered_orders = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END
ORDER BY customer_count DESC;


-- 3. Repeat vs One-Time Customer Revenue

WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS order_count,
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
    CASE
        WHEN order_count = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customers,
    SUM(total_spending) AS total_revenue,
    ROUND(AVG(total_spending), 2) AS avg_customer_spending
FROM customer_sales
GROUP BY
    CASE
        WHEN order_count = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;


-- 4. Top Product in Each Category

WITH product_sales AS (
    SELECT
        p.category,
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products AS p
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.category,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    category,
    product_name,
    revenue
FROM ranked_products
WHERE product_rank = 1
ORDER BY revenue DESC;


-- 5. Top Customer in Each City

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


-- 6. Customer Ranking + Segmentation

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
        WHEN total_spending >= 50000
            THEN 'Premium'
        WHEN total_spending >= 20000
            THEN 'Regular'
        ELSE 'Low Value'
    END AS customer_segment,
    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;


-- 7. Final Business KPI Report

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
customer_count AS (
    SELECT
        COUNT(DISTINCT customer_id) AS total_customers
    FROM orders
    WHERE order_status = 'Delivered'
),
cancelled AS (
    SELECT
        COUNT(*) AS cancelled_orders
    FROM orders
    WHERE order_status = 'Cancelled'
)
SELECT
    s.delivered_orders,
    s.units_sold,
    s.total_revenue,
    ROUND(
        s.total_revenue /
        NULLIF(s.delivered_orders, 0),
        2
    ) AS average_order_value,
    c.total_customers,
    x.cancelled_orders,
    ROUND(
        x.cancelled_orders * 100.0 /
        NULLIF(
            s.delivered_orders + x.cancelled_orders,
            0
        ),
        2
    ) AS cancellation_rate_pct
FROM sales AS s
CROSS JOIN customer_count AS c
CROSS JOIN cancelled AS x;