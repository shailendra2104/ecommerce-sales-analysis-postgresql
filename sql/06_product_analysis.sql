-- ============================================
-- Product & Category Analysis
-- ============================================


-- 1. Product-wise Performance

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY revenue DESC;


-- 2. Top 5 Products by Revenue

SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;


-- 3. Top 5 Products by Units Sold

SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 5;


-- 4. Category Performance

SELECT
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY revenue DESC;


-- 5. Sub-category Analysis

SELECT
    p.sub_category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.sub_category
ORDER BY revenue DESC;


-- 6. Top Product in Each Category

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


-- 7. Category Revenue Contribution

WITH category_sales AS (
    SELECT
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products AS p
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.category
)
SELECT
    category,
    revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_contribution_pct
FROM category_sales
ORDER BY revenue DESC;


-- 8. Product Revenue Ranking

WITH product_sales AS (
    SELECT
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
        p.product_id,
        p.product_name
)
SELECT
    product_name,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM product_sales
ORDER BY revenue_rank;