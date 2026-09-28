-- ============================================
-- Monthly Sales & Growth Analysis
-- ============================================


-- 1. Monthly Sales Performance

SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS month,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY month
ORDER BY month;


-- 2. Monthly AOV

WITH monthly_orders AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE AS month,
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        month,
        o.order_id
)
SELECT
    month,
    ROUND(AVG(order_value), 2) AS monthly_aov
FROM monthly_orders
GROUP BY month
ORDER BY month;


-- 3. Month-over-Month Revenue Growth

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY month
),
monthly_growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    month,
    revenue,
    previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue)
        * 100.0
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_growth_pct
FROM monthly_growth
ORDER BY month;


-- 4. Revenue Trend

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY month
)
SELECT
    month,
    revenue,
    CASE
        WHEN revenue >
             LAG(revenue) OVER (ORDER BY month)
        THEN 'Increased'
        WHEN revenue <
             LAG(revenue) OVER (ORDER BY month)
        THEN 'Decreased'
        ELSE 'No Change'
    END AS revenue_trend
FROM monthly_sales
ORDER BY month;


-- 5. Monthly Category Performance

SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS month,
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY
    month,
    p.category
ORDER BY
    month,
    revenue DESC;


-- 6. Category Rank Within Each Month

WITH monthly_category_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE AS month,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    JOIN products AS p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        month,
        p.category
)
SELECT
    month,
    category,
    revenue,
    RANK() OVER (
        PARTITION BY month
        ORDER BY revenue DESC
    ) AS category_rank
FROM monthly_category_sales
ORDER BY
    month,
    category_rank;


-- 7. Final Monthly KPI Report

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE AS month,
        COUNT(DISTINCT o.order_id) AS orders,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY month
)
SELECT
    month,
    orders,
    revenue,
    ROUND(revenue / NULLIF(orders, 0), 2) AS aov,
    LAG(revenue) OVER (
        ORDER BY month
    ) AS previous_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        * 100.0
        / NULLIF(
            LAG(revenue) OVER (ORDER BY month),
            0
        ),
        2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY month;